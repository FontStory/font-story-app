import 'package:flutter/material.dart' show BuildContext, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_story/core/common/internet/internet_connectivity_cubit.dart';
import 'package:font_story/core/common/localization/cubit/localization_cubit.dart';
import 'package:font_story/core/services/clipboard/clipboard_loader.dart';
import 'package:font_story/core/services/image_saver/image_saver_loader.dart';
import 'package:font_story/features/font_story/presentation/cubit/box_decoration/box_decoration_cubit.dart';
import 'package:font_story/features/font_story/presentation/cubit/color_selection/color_selection_cubit.dart';
import 'package:font_story/features/font_story/presentation/cubit/editor_controller/editor_controller_cubit.dart';
import 'package:font_story/features/font_story/presentation/cubit/export/export_cubit.dart';
import 'package:font_story/features/font_story/presentation/cubit/font_selection/font_selection_cubit.dart';
import 'package:font_story/features/font_story/presentation/cubit/highlight/highlight_cubit.dart';
import 'package:font_story/features/font_story/presentation/cubit/style_selection/style_selection_cubit.dart';
import 'package:font_story/features/font_story/presentation/cubit/text_formatting/text_formatting_cubit.dart';
import 'package:font_story/features/font_story/presentation/screens/text_editor_screen.dart';
import 'package:font_story/locator/service_locator.dart';
import 'package:font_story/splash.dart';

part 'paths.dart';

class AppRoutes {
  AppRoutes._();

  static const String initialRoute = AppRoutePaths.splash;

  static Map<String, Widget Function(BuildContext)> routes = {
    AppRoutePaths.splash: (context) => BlocProvider.value(
      value: locator.get<InternetConnectivityCubit>()
        ..checkInternetConnection(),
      child: const SplashScreen(),
    ),
    AppRoutePaths.main: (context) => MultiBlocProvider(
      providers: [
        // Individual cubits
        BlocProvider(
          create: (context) {
            final initialLanguage = context.read<LocalizationCubit>().state;
            return FontSelectionCubit(locator.get())
              ..getFonts(language: initialLanguage);
          },
        ),
        BlocProvider(
          create: (_) => StyleSelectionCubit(locator.get())..getStyles(),
        ),
        BlocProvider(create: (_) => ColorSelectionCubit()),
        BlocProvider(create: (_) => TextFormattingCubit()),
        BlocProvider(create: (_) => HighlightCubit()),
        BlocProvider(create: (_) => BoxDecorationCubit()),
        BlocProvider(
          create: (_) => ExportCubit(
            clipboard,
            imageSaver,
            locator.get(),
            noAds: dotenv.env['NO_ADS'] == 'true',
          ),
        ),

        // Coordinator cubit that depends on others
        BlocProvider(
          create: (context) => EditorControllerCubit(
            fontSelectionCubit: context.read<FontSelectionCubit>(),
            styleSelectionCubit: context.read<StyleSelectionCubit>(),
            colorSelectionCubit: context.read<ColorSelectionCubit>(),
            textFormattingCubit: context.read<TextFormattingCubit>(),
            boxDecorationCubit: context.read<BoxDecorationCubit>(),
          ),
        ),
      ],
      child: const TextEditorScreen(),
    ),
  };
}
