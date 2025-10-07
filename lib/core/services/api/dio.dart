import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:http_cache_hive_store/http_cache_hive_store.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;

import '../../constants/api.dart';
import 'retry_interceptor.dart';

@lazySingleton
class DioService {
  final Dio _dio;
  final Dio _dioForDownloads;
  late CacheOptions _cacheOptions;

  DioService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {'Content-Type': 'application/json'},
        ),
      ),
      _dioForDownloads = Dio() {
    _initCacheOptions().then((_) {
      _dio.interceptors.add(DioCacheInterceptor(options: _cacheOptions));
      _dioForDownloads.interceptors.add(
        DioCacheInterceptor(options: _cacheOptions),
      );
    });
    _dio.interceptors.add(
      RetryInterceptor(
        dio: _dio,
        maxRetries: 3,
        retryDelay: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _initCacheOptions() async {
    _cacheOptions = CacheOptions(
      store: HiveCacheStore(
        kIsWeb ? null : (await getTemporaryDirectory()).path,
      ),
      policy: CachePolicy.request,
      maxStale: const Duration(days: 7),
      hitCacheOnErrorCodes: [
        500, // Internal Server Error
        502, // Bad Gateway
        503, // Service Unavailable
        504, // Gateway Timeout
        408, // Request Timeout
        429, // Too Many Requests (GitHub rate limit)
      ],
      priority: CachePriority.normal,
      hitCacheOnNetworkFailure: true,
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

  Future<Response<List<int>>> download(
    String absoluteUrl, {
    Function(int, int)? onReceiveProgress,
  }) {
    return _dioForDownloads.get<List<int>>(
      absoluteUrl,
      options: Options(responseType: ResponseType.bytes),
      onReceiveProgress: onReceiveProgress,
    );
  }
}
