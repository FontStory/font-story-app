import 'package:dartz/dartz.dart';
import 'package:font_story/core/common/localization/language.dart';
import 'package:font_story/core/error/failure.dart';

import '../entities/font.dart';

abstract interface class FontRepository {
  Future<Either<Failure, List<FontEntity>>> getFonts(Language? language);

  Future<Either<Failure, void>> loadFontIntoApp(FontEntity font);
}
