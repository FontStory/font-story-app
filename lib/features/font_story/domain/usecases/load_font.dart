import 'package:dartz/dartz.dart';
import 'package:font_story/core/error/failure.dart';
import 'package:font_story/core/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

import '../entities/font.dart';
import '../repositories/repository.dart';

@injectable
class LoadFont implements UseCase<void, FontEntity> {
  final FontStoryRepository _repository;

  LoadFont(this._repository);

  @override
  Future<Either<Failure, void>> call(FontEntity param) async {
    return await _repository.loadFontIntoApp(param);
  }
}
