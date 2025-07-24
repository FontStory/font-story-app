import 'dart:io';
import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio _dio;
  final int _maxRetries;
  final Duration _retryDelay;

  RetryInterceptor({
    required Dio dio,
    int maxRetries = 1,
    Duration retryDelay = const Duration(seconds: 2),
  }) : _retryDelay = retryDelay,
       _maxRetries = maxRetries,
       _dio = dio;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Check if the error is due to a connectivity issue.
    if (_shouldRetry(err)) {
      final options = err.requestOptions;
      int retryCount = options.extra["retryCount"] ?? 0;

      if (retryCount < _maxRetries) {
        retryCount++;
        options.extra["retryCount"] = retryCount;

        // Wait for a short delay before retrying.
        await Future.delayed(_retryDelay);

        try {
          final response = await _dio.fetch(options);
          return handler.resolve(response);
        } catch (e) {
          return handler.next(e as DioException);
        }
      }
    }
    return handler.next(err);
  }

  // Check if the error was caused by a SocketException which indicates a connectivity issue.
  bool _shouldRetry(DioException err) => err.error is SocketException;
}
