import 'package:dartz/dartz.dart';
import 'package:font_story/core/error/failure.dart';

import '../entities/style.dart';

abstract interface class StyleRepository {
  Future<Either<Failure, List<TextEffectStyle>>> getStylesFromRemote();

  Future<Either<Failure, List<TextEffectStyle>>> getStylesFromLocal();
}
