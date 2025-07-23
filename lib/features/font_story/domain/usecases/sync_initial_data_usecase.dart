import 'package:dartz/dartz.dart';
import 'package:font_story/core/error/failure.dart';
import 'package:font_story/core/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

import '../repositories/repository.dart';

@injectable
class SyncInitialDataUseCase implements NoParamUseCase<void> {
  final FontStoryRepository repository;

  SyncInitialDataUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call() async {
    return await repository.syncInitialData();
  }
}
