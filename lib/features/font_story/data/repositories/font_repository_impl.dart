import 'package:dartz/dartz.dart';
import 'package:font_story/core/common/localization/language.dart';
import 'package:font_story/core/constants/api.dart';
import 'package:font_story/core/error/failure.dart';
import 'package:font_story/core/helpers/safe_api_call.dart';
import 'package:font_story/core/services/font/font_loader.dart';
import 'package:font_story/features/font_story/data/mappers/font_mapper.dart';
import 'package:injectable/injectable.dart';
import 'package:isolate_manager/isolate_manager.dart';

import '../../domain/entities/font.dart';
import '../../domain/repositories/font_repository.dart';
import '../data_sources/remote/font/font_remote_datasource.dart';
import '../models/font.dart';

@Injectable(as: FontRepository)
class FontRepositoryImpl implements FontRepository {
  final FontRemoteDatasource _remoteDatasource;
  final DynamicFontLoader _fontLoader;

  FontRepositoryImpl(this._remoteDatasource, this._fontLoader);

  @override
  Future<Either<Failure, List<FontEntity>>> getFonts(Language? language) {
    return safeApiCall<List<FontEntity>>(() async {
      final jsonString = await _remoteDatasource.fetchFontsJson();

      final payload = {
        'jsonString': jsonString,
        'baseUrl': baseUrl,
        'language': language?.name ?? Language.english.name,
      };

      final fontModels = await IsolateManager.runFunction(
        FontModel.fromNestedJson,
        payload,
      );

      return fontModels.toEntityList();
    });
  }

  @override
  Future<Either<Failure, void>> loadFontIntoApp(FontEntity font) {
    return safeApiCall<void>(() async {
      if (!_fontLoader.loadedFontFamilies.contains(font.fontFamily)) {
        final fontBytes = await _remoteDatasource.downloadFont(
          font.toModel().path,
        );
        await _fontLoader.load(fontFamily: font.fontFamily, bytes: fontBytes);
      }
    });
  }
}
