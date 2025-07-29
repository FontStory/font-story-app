import 'package:dartz/dartz.dart';
import 'package:font_story/core/common/localization/language.dart';
import 'package:font_story/core/constants/api.dart';
import 'package:font_story/core/error/failure.dart';
import 'package:font_story/core/helpers/safe_api_call.dart';
import 'package:font_story/core/services/font/font_loader.dart';
import 'package:injectable/injectable.dart';
import 'package:isolate_manager/isolate_manager.dart';

import '../../domain/entities/index.dart';
import '../../domain/repositories/repository.dart';
import '../data_sources/local/datasource.dart';
import '../data_sources/remote/datasource.dart';
import '../models/font.dart';
import '../models/style.dart';

@Injectable(as: FontStoryRepository)
class FontStoryRepositoryImpl implements FontStoryRepository {
  final FontStoryRemoteDatasource _remoteDatasource;
  final FontStoryLocalDatasource _localDatasource;
  final DynamicFontLoader _fontLoader;

  FontStoryRepositoryImpl(
    this._remoteDatasource,
    this._localDatasource,
    this._fontLoader,
  );

  @override
  Future<Either<Failure, void>> syncInitialData() {
    return safeApiCall<void>(() async {
      final results = await Future.wait([
        _remoteDatasource.fetchStylesJson(),
        _remoteDatasource.fetchFontsJson(),
      ]);

      await Future.wait([
        _localDatasource.saveStylesJson(results[0]),
        _localDatasource.saveFontsJson(results[1]),
      ]);
    });
  }

  @override
  Future<Either<Failure, List<TextEffectStyle>>> getStyles() {
    return safeApiCall<List<TextEffectStyle>>(() async {
      String? jsonString = await _localDatasource.getStylesJson();

      if (jsonString == null) {
        jsonString = await _remoteDatasource.fetchStylesJson();
        await _localDatasource.saveStylesJson(jsonString);
      }

      final payload = {'jsonString': jsonString, 'baseUrl': baseUrl};

      return await IsolateManager.runFunction(
        TextEffectStyleModel.parseToUiModel,
        payload,
      );
    });
  }

  @override
  Future<Either<Failure, List<FontEntity>>> getFonts(Language? language) {
    return safeApiCall<List<FontEntity>>(() async {
      String? jsonString = await _localDatasource.getFontsJson();

      if (jsonString == null) {
        jsonString = await _remoteDatasource.fetchFontsJson();
        await _localDatasource.saveFontsJson(jsonString);
      }

      final payload = {
        'jsonString': jsonString,
        'baseUrl': baseUrl,
        'language': language?.name ?? Language.english.name,
      };

      return await IsolateManager.runFunction(
        FontModel.fromNestedJson,
        payload,
      );
    });
  }

  @override
  Future<Either<Failure, void>> loadFontIntoApp(FontEntity font) {
    return safeApiCall<void>(() async {
      if (!_fontLoader.loadedFontFamilies.contains(font.fontFamily)) {
        final fontBytes = await _remoteDatasource.downloadFont(font.path);
        await _fontLoader.load(fontFamily: font.fontFamily, bytes: fontBytes);
      }
    });
  }
}
