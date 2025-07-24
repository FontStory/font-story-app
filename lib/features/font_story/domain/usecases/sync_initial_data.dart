import 'package:dartz/dartz.dart';
import 'package:font_story/core/error/failure.dart';
import 'package:font_story/core/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

import '../repositories/repository.dart';

@injectable
class SyncInitialData implements NoParamUseCase<void> {
  final FontStoryRepository _repository;

  SyncInitialData(this._repository);

  @override
  Future<Either<Failure, void>> call() async {
    return await _repository.syncInitialData();
  }
}
