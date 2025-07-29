// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:font_story/core/common/localization/cubit/localization_cubit.dart'
    as _i1042;
import 'package:font_story/core/common/theme/theme_cubit.dart' as _i426;
import 'package:font_story/core/services/api/dio.dart' as _i880;
import 'package:font_story/core/services/font/font_loader.dart' as _i82;
import 'package:font_story/core/services/google_ads.dart' as _i87;
import 'package:font_story/core/services/hive_manager.dart' as _i1062;
import 'package:font_story/core/services/network.dart' as _i864;
import 'package:font_story/core/services/permission_handler.dart' as _i343;
import 'package:font_story/features/font_story/data/data_sources/local/datasource.dart'
    as _i794;
import 'package:font_story/features/font_story/data/data_sources/remote/datasource.dart'
    as _i690;
import 'package:font_story/features/font_story/data/repositories/repository_impl.dart'
    as _i69;
import 'package:font_story/features/font_story/domain/repositories/repository.dart'
    as _i764;
import 'package:font_story/features/font_story/domain/usecases/get_fonts.dart'
    as _i886;
import 'package:font_story/features/font_story/domain/usecases/get_styles.dart'
    as _i659;
import 'package:font_story/features/font_story/domain/usecases/load_font.dart'
    as _i307;
import 'package:font_story/features/font_story/domain/usecases/sync_initial_data.dart'
    as _i967;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i1042.LocalizationCubit>(
      () => _i1042.LocalizationCubit(),
    );
    gh.lazySingleton<_i426.ThemeCubit>(() => _i426.ThemeCubit());
    gh.lazySingleton<_i880.DioService>(() => _i880.DioService());
    gh.lazySingleton<_i87.AdManager>(() => _i87.AdManager());
    gh.lazySingleton<_i1062.HiveManager>(() => _i1062.HiveManager());
    gh.lazySingleton<_i82.DynamicFontLoader>(
      () => _i82.DefaultDynamicFontLoader(),
    );
    gh.lazySingleton<_i343.PermissionHandler>(
      () => _i343.PermissionHandlerService(),
    );
    gh.lazySingleton<_i864.NetworkManager>(() => _i864.NetworkManagerImpl());
    gh.factory<_i690.FontStoryRemoteDatasource>(
      () => _i690.FontStoryDatasourceImpl(gh<_i880.DioService>()),
    );
    gh.factory<_i794.FontStoryLocalDatasource>(
      () => _i794.FontStoryLocalDatasourceImpl(gh<_i1062.HiveManager>()),
    );
    gh.factory<_i764.FontStoryRepository>(
      () => _i69.FontStoryRepositoryImpl(
        gh<_i690.FontStoryRemoteDatasource>(),
        gh<_i794.FontStoryLocalDatasource>(),
        gh<_i82.DynamicFontLoader>(),
      ),
    );
    gh.factory<_i886.GetFonts>(
      () => _i886.GetFonts(gh<_i764.FontStoryRepository>()),
    );
    gh.factory<_i659.GetStyles>(
      () => _i659.GetStyles(gh<_i764.FontStoryRepository>()),
    );
    gh.factory<_i307.LoadFont>(
      () => _i307.LoadFont(gh<_i764.FontStoryRepository>()),
    );
    gh.factory<_i967.SyncInitialData>(
      () => _i967.SyncInitialData(gh<_i764.FontStoryRepository>()),
    );
    return this;
  }
}
