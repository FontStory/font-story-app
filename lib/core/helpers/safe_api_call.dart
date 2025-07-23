import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:dio/dio.dart' show DioException, DioExceptionType;
import 'package:easy_localization/easy_localization.dart' show StringTranslateExtension;

import '../error/api_exception.dart';
import '../error/failure.dart';

/// Wraps an API call and handles errors uniformly.
Future<Either<Failure, T>> safeApiCall<T>(Future<T> Function() apiCall) async {
  try {
    final result = await apiCall();
    return Right(result);
  } on DioException catch (e) {
    final code = e.response?.statusCode?.toString() ?? '';

    switch (e.type) {
      case DioExceptionType.connectionError:
        return Left(
          NetworkFailure(message: 'messages.network_connection_error'.tr()),
        );

      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return Left(ServerFailure(message: 'errors.timeout'.tr()));

      case DioExceptionType.badResponse:
        return Left(ServerFailure(message: 'errors.server'.tr(args: [code])));

      default:
        return Left(NetworkFailure(message: 'errors.network'.tr(args: [code])));
    }
  } on SocketException {
    return Left(
      NetworkFailure(message: 'messages.network_connection_error'.tr()),
    );
  } on TimeoutException {
    return Left(ServerFailure(message: 'errors.timeout'.tr()));
  } on ApiException catch (e) {
    return Left(ServerFailure(message: e.message));
  } catch (e) {
    return Left(ServerFailure(message: 'errors.unknown'.tr()));
  }
}
