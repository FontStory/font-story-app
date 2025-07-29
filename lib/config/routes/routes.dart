import 'package:flutter/material.dart' show BuildContext, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_story/core/common/localization/cubit/localization_cubit.dart';
import 'package:font_story/core/common/sync/sync_cubit.dart';
import 'package:font_story/core/services/clipboard/clipboard_loader.dart';
import 'package:font_story/core/services/image_saver/image_saver_loader.dart';
import 'package:font_story/features/font_story/presentation/cubit/export/export_cubit.dart';
import 'package:font_story/features/font_story/presentation/cubit/font_story_cubit.dart';
import 'package:font_story/features/font_story/presentation/screens/text_editor_screen.dart';
import 'package:font_story/locator/service_locator.dart';
import 'package:font_story/splash.dart';

part 'paths.dart';

class AppRoutes {
  AppRoutes._();

  static const String initialRoute = AppRoutePaths.splash;

  static Map<String, Widget Function(BuildContext)> routes = {
    AppRoutePaths.splash: (context) => BlocProvider(
      create: (context) => SyncCubit(locator.get(), locator.get())..syncData(),
      child: SplashScreen(),
    ),
    AppRoutePaths.main: (context) => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final initialLanguage = context.read<LocalizationCubit>().state;

            return FontStoryCubit(locator.get(), locator.get())
              ..getStyles()
              ..getFonts(language: initialLanguage);
          },
        ),
        BlocProvider(
          create: (context) => ExportCubit(
            clipboard,
            imageSaver,
            locator.get(),
            noAds: dotenv.env['NO_ADS'] == 'true',
          ),
        ),
      ],
      child: TextEditorScreen(),
    ),
  };
}
