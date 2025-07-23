import 'package:dartz/dartz.dart';
import 'package:font_story/core/common/localization/language.dart';
import 'package:font_story/core/error/failure.dart';
import 'package:font_story/core/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

import '../entities/font.dart';
import '../repositories/repository.dart';

@injectable
class GetFonts implements UseCase<List<FontEntity>, Language?> {
  final FontStoryRepository repository;

  GetFonts(this.repository);

  @override
  Future<Either<Failure, List<FontEntity>>> call(Language? language) async {
    return await repository.getFonts(language);
  }
}
