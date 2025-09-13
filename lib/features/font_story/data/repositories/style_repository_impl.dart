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
    return safeApiCall<List<TextEffectStyle>>(() async {
      final jsonString = await _remoteDatasource.fetchStylesJson();

      final payload = {'jsonString': jsonString, 'baseUrl': baseUrl};

      final styleModels = await IsolateManager.runFunction(
        TextEffectStyleModel.fromNestedJson,
        payload,
      );

      return styleModels.toEntityList();
    });
  }

  @override
  Future<Either<Failure, List<TextEffectStyle>>> getStylesFromLocal() async {
    try {
      final jsonString = await _localDatasource.getStylesJson();

      final payload = {'jsonString': jsonString, 'baseUrl': baseUrl};

      final styleModels = await IsolateManager.runFunction(
        TextEffectStyleModel.fromNestedJson,
        payload,
      );

      return Right(styleModels.toEntityList());
    } on LocaleException catch (e) {
      return Left(LocaleFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: 'errors.unknown'.tr()));
    }
  }
}
