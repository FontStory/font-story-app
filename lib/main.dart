import 'package:easy_localization/easy_localization.dart'
    show EasyLocalization, BuildContextEasyLocalizationExtension;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;

import 'config/routes/routes.dart';
import 'core/common/localization/cubit/localization_cubit.dart';
import 'core/common/localization/language.dart';
import 'core/common/theme/theme_cubit.dart';
import 'core/constants/local.dart';
import 'core/helpers/log.dart';
import 'core/services/hive_manager.dart';
import 'features/font_story/domain/usecases/sync_initial_data_usecase.dart';
import 'locator/service_locator.dart';

part 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    dotenv.load(fileName: '.env'),
    EasyLocalization.ensureInitialized(),
    _initializeHydratedBloc(),
  ]);

  configureDependencies();
  await locator<HiveManager>().init();
  LogManager.instance.initialize();

  final syncUseCase = locator<SyncInitialDataUseCase>();
  await syncUseCase.call();

  final localization = LocalizationCubit();
  final theme = ThemeCubit();

  theme.updateFontFamily(localization.state.fontFamily);

  runApp(
    EasyLocalization(
      supportedLocales: kSupportedLocales,
      path: kTranslatesPath,
      fallbackLocale: kFallbackLocale,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => localization),
          BlocProvider(create: (_) => theme),
        ],
        child: const FontStory(),
      ),
    ),
  );
}

Future<void> _initializeHydratedBloc() async {
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
}
