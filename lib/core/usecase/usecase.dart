import 'package:dartz/dartz.dart' show Either;

import '../error/failure.dart';

abstract interface class UseCase<T, Param> {
  Future<Either<Failure, T>> call(Param param);
}

abstract interface class NoParamUseCase<T> {
  Future<Either<Failure, T>> call();
}
