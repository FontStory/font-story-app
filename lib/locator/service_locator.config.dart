// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:font_story/core/common/internet/internet_connectivity_cubit.dart'
    as _i508;
import 'package:font_story/core/common/localization/cubit/localization_cubit.dart'
    as _i1042;
import 'package:font_story/core/common/theme/theme_cubit.dart' as _i426;
import 'package:font_story/core/services/api/dio.dart' as _i880;
import 'package:font_story/core/services/font/font_loader.dart' as _i82;
import 'package:font_story/core/services/google_ads.dart' as _i87;
import 'package:font_story/core/services/hive_manager.dart' as _i1062;
import 'package:font_story/core/services/network.dart' as _i864;
import 'package:font_story/core/services/permission_handler.dart' as _i343;
import 'package:font_story/features/font_story/data/data_sources/local/font/font_local_datasource.dart'
    as _i39;
import 'package:font_story/features/font_story/data/data_sources/local/style/style_local_datasource.dart'
    as _i716;
import 'package:font_story/features/font_story/data/data_sources/remote/font/font_remote_datasource.dart'
    as _i553;
import 'package:font_story/features/font_story/data/data_sources/remote/style/style_remote_datasource.dart'
    as _i341;
import 'package:font_story/features/font_story/data/repositories/font_repository_impl.dart'
    as _i339;
import 'package:font_story/features/font_story/data/repositories/style_repository_impl.dart'
    as _i502;
import 'package:font_story/features/font_story/domain/repositories/font_repository.dart'
    as _i724;
import 'package:font_story/features/font_story/domain/repositories/style_repository.dart'
    as _i11;
import 'package:font_story/features/font_story/domain/usecases/get_fonts.dart'
    as _i886;
import 'package:font_story/features/font_story/domain/usecases/get_styles.dart'
    as _i659;
import 'package:font_story/features/font_story/domain/usecases/load_font.dart'
    as _i307;
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
    gh.lazySingleton<_i508.InternetConnectivityCubit>(
      () => _i508.InternetConnectivityCubit(gh<_i864.NetworkManager>()),
    );
    gh.factory<_i553.FontRemoteDatasource>(
      () => _i553.FontDatasourceImpl(gh<_i880.DioService>()),
    );
    gh.factory<_i716.StyleLocalDatasource>(
      () => _i716.StyleLocalDatasourceImpl(gh<_i1062.HiveManager>()),
    );
    gh.factory<_i341.StyleRemoteDatasource>(
      () => _i341.StyleDatasourceImpl(gh<_i880.DioService>()),
    );
    gh.factory<_i39.FontLocalDatasource>(
      () => _i39.FontLocalDatasourceImpl(gh<_i1062.HiveManager>()),
    );
    gh.factory<_i11.StyleRepository>(
      () => _i502.StyleRepositoryImpl(
        gh<_i341.StyleRemoteDatasource>(),
        gh<_i716.StyleLocalDatasource>(),
      ),
    );
    gh.factory<_i659.GetStyles>(
      () => _i659.GetStyles(gh<_i11.StyleRepository>()),
    );
    gh.factory<_i724.FontRepository>(
      () => _i339.FontRepositoryImpl(
        gh<_i553.FontRemoteDatasource>(),
        gh<_i82.DynamicFontLoader>(),
      ),
    );
    gh.factory<_i886.GetFonts>(
      () => _i886.GetFonts(gh<_i724.FontRepository>()),
    );
    gh.factory<_i307.LoadFont>(
      () => _i307.LoadFont(gh<_i724.FontRepository>()),
    );
    return this;
  }
}
