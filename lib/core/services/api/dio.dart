import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../constants/api.dart';
import 'retry_interceptor.dart';

@lazySingleton
class DioService {
  final Dio _dio;
  final Dio _dioForDownloads;

  DioService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {'Content-Type': 'application/json'},
        ),
      ),
      _dioForDownloads = Dio() {
    _dio.interceptors.add(
      RetryInterceptor(
        dio: _dio,
        maxRetries: 3,
        retryDelay: const Duration(seconds: 2),
      ),
    );
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.post(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.put(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.delete(path, data: data, queryParameters: queryParameters);
  }

  Future<Response<List<int>>> download(String absoluteUrl) {
    return _dioForDownloads.get<List<int>>(
      absoluteUrl,
      options: Options(responseType: ResponseType.bytes),
    );
  }
}
