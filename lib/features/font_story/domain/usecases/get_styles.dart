import 'package:dartz/dartz.dart';
import 'package:font_story/core/error/failure.dart';
import 'package:font_story/core/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

import '../entities/style.dart';
import '../repositories/repository.dart';

@injectable
class GetStyles implements NoParamUseCase<List<TextEffectStyle>> {
  final FontStoryRepository _repository;

  GetStyles(this._repository);

  @override
  Future<Either<Failure, List<TextEffectStyle>>> call() async {
    return await _repository.getStyles();
  }
}
