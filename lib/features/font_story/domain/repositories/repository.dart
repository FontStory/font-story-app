import 'package:dartz/dartz.dart';
import 'package:font_story/core/common/localization/language.dart';
import 'package:font_story/core/error/failure.dart';

import '../entities/index.dart';

abstract interface class FontStoryRepository {
  Future<Either<Failure, void>> syncInitialData();

  Future<Either<Failure, List<TextEffectStyle>>> getStyles();

  Future<Either<Failure, List<FontEntity>>> getFonts(Language? language);

  Future<Either<Failure, void>> loadFontIntoApp(FontEntity font);
}
