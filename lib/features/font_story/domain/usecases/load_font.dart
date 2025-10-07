import 'package:dartz/dartz.dart';
import 'package:font_story/core/error/failure.dart';
import 'package:font_story/core/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

import '../entities/font.dart';
import '../repositories/font_repository.dart';

@injectable
class LoadFont implements UseCase<void, FontEntity> {
  final FontRepository _repository;

  LoadFont(this._repository);

  Future<Either<Failure, void>> callWithProgress(
    FontEntity param, {
    Function(int, int)? onReceiveProgress,
  }) async {
    return await _repository.loadFontIntoApp(
      param,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Either<Failure, void>> call(FontEntity param) async {
    return await _repository.loadFontIntoApp(param);
  }
}
