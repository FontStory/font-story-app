import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;
import 'package:font_story/core/constants/api.dart';
import 'package:font_story/core/error/failure.dart';
import 'package:font_story/core/error/local_exception.dart';
import 'package:font_story/core/helpers/safe_api_call.dart';
import 'package:font_story/features/font_story/data/mappers/style_mapper.dart';
import 'package:injectable/injectable.dart';
import 'package:isolate_manager/isolate_manager.dart';

import '../../domain/entities/style.dart';
import '../../domain/repositories/style_repository.dart';
import '../data_sources/local/style/style_local_datasource.dart';
import '../data_sources/remote/style/style_remote_datasource.dart';
import '../models/style.dart';

@Injectable(as: StyleRepository)
class StyleRepositoryImpl implements StyleRepository {
  final StyleRemoteDatasource _remoteDatasource;
  final StyleLocalDatasource _localDatasource;

  StyleRepositoryImpl(this._remoteDatasource, this._localDatasource);

  @override
  Future<Either<Failure, List<TextEffectStyle>>> getStylesFromRemote() {
    return safeApiCall(() async {
      final jsonString = await _remoteDatasource.fetchStylesJson();
      return await _parseAndMapStyles(jsonString);
    });
  }

  @override
  Future<Either<Failure, List<TextEffectStyle>>> getStylesFromLocal() async {
    try {
      final jsonString = await _localDatasource.getStylesJson();
      final styles = await _parseAndMapStyles(jsonString);
      return Right(styles);
    } on LocaleException catch (e) {
      return Left(LocaleFailure(message: e.message));
    } catch (_) {
      return Left(UnknownFailure(message: 'errors.unknown'.tr()));
    }
  }

  /// Parses JSON into models and maps to entities using a single isolate
  Future<List<TextEffectStyle>> _parseAndMapStyles(String jsonString) async {
    final payload = {'jsonString': jsonString, 'baseUrl': baseUrl};

    // Parse models in isolate
    final List<TextEffectStyleModel> models = await IsolateManager.runFunction(
      TextEffectStyleModel.fromNestedJson,
      payload,
    );

    // Map models to entities in same isolate
    final List<TextEffectStyle> styles = await IsolateManager.runFunction(
      mapTextEffectStyles,
      models,
    );

    return styles;
  }
}
