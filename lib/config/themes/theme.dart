import 'package:flutter/material.dart';

import '../values/index.dart';
import 'extensions/color_palette.dart';
import 'extensions/text_typography.dart';

class AppTheme {
  AppTheme._();

  // This method generates a theme based on a primary color
  static ThemeData getThemeFromColor(Color primaryColor, {String? fontFamily}) {
    final colorPalette = _getColorPalette(primaryColor);
    final typography = _getTextTypography(colorPalette, fontFamily: fontFamily);

    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      scaffoldBackgroundColor: colorPalette.background,
      colorSchemeSeed: primaryColor,
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          backgroundColor: colorPalette.surface,
          foregroundColor: colorPalette.onSurface,
          iconSize: AppDimensions.icon,
        ),
      ),
      sliderTheme: SliderThemeData(
        inactiveTrackColor: colorPalette.surface,
        activeTrackColor: colorPalette.onSurface,
        thumbColor: colorPalette.onSurface,
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return colorPalette.primary;
          }
          return colorPalette.onSurface;
        }),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colorPalette.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(AppRadius.lg)
        )
        
      ),
      extensions: [colorPalette, typography],
    );
  }

  static TextTypography _getTextTypography(
    ColorPalette palette, {
    String? fontFamily,
  }) {
    return TextTypography(
      tiny: AppTypography.tiny.copyWith(
        color: palette.onBackground,
        fontFamily: fontFamily,
      ),
      small: AppTypography.small.copyWith(
        color: palette.onBackground,
        fontFamily: fontFamily,
      ),
      paragraph: AppTypography.paragraph.copyWith(
        color: palette.onBackground,
        fontFamily: fontFamily,
      ),
      heading6: AppTypography.heading6.copyWith(
        color: palette.onBackground,
        fontFamily: fontFamily,
      ),
      heading5: AppTypography.heading5.copyWith(
        color: palette.onBackground,
        fontFamily: fontFamily,
      ),
      heading4: AppTypography.heading4.copyWith(
        color: palette.onBackground,
        fontFamily: fontFamily,
      ),
      heading3: AppTypography.heading3.copyWith(
        color: palette.onBackground,
        fontFamily: fontFamily,
      ),
      heading2: AppTypography.heading2.copyWith(
        color: palette.onBackground,
        fontFamily: fontFamily,
      ),
      heading1: AppTypography.heading1.copyWith(
        color: palette.onBackground,
        fontFamily: fontFamily,
      ),
    );
  }

  static ColorPalette _getColorPalette(Color primaryColor) {
    return ColorPalette(
      primary: primaryColor,
      onPrimary: AppPalette.white,
      secondary: AppPalette.white,
      onSecondary: AppPalette.dark,
      error: AppPalette.red,
      onError: AppPalette.white,
      success: AppPalette.green,
      onSuccess: AppPalette.white,
      background: AppPalette.white,
      onBackground: AppPalette.dark,
      surface: AppPalette.white.withValues(alpha: 0.15),
      onSurface: AppPalette.white,
    );
  }
}
