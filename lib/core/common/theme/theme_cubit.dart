import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:font_story/config/themes/theme.dart';
import 'package:font_story/config/values/gradient.dart';
import 'package:font_story/config/values/palette.dart';
import 'package:injectable/injectable.dart';

part 'theme_state.dart';

@lazySingleton
class ThemeCubit extends HydratedCubit<ThemeState> {
  static final Map<Color, Gradient> _colorGradients = {
    // Vibrant Pairs
    AppPalette.primaryPink: AppGradient.pinkRush,
    AppPalette.primaryBlaze: AppGradient.sunsetBlaze,
    AppPalette.primaryPeach: AppGradient.peachWhisper,
    AppPalette.primaryLavender: AppGradient.lavenderDreams,

    // Natural Pairs
    AppPalette.primaryMint: AppGradient.vibrantAqua,
    AppPalette.primarySky: AppGradient.skyDrift,

    // Monochrome Pairs
    AppPalette.primaryGray: AppGradient.mistyGraphite,
  };

  static final _colorKeys = _colorGradients.keys.toList();

  ThemeCubit() : super(_getThemeStateByIndex(0));

  static ThemeState _getThemeStateByIndex(int index, {String? fontFamily}) {
    final color = _colorKeys[index];
    final gradient = _colorGradients[color]!;
    final themeData = AppTheme.getThemeFromColor(color, fontFamily: fontFamily);
    return ThemeState(
      themeData: themeData,
      gradient: gradient,
      themeIndex: index,
      fontFamily: fontFamily,
    );
  }

  void changeToNextTheme() {
    final currentFontFamily = state.fontFamily;
    final currentIndex = state.themeIndex;
    final nextIndex = (currentIndex + 1) % _colorKeys.length;
    emit(_getThemeStateByIndex(nextIndex, fontFamily: currentFontFamily));
  }

  void updateFontFamily(String newFontFamily) {
    final currentIndex = state.themeIndex;
    emit(_getThemeStateByIndex(currentIndex, fontFamily: newFontFamily));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    final index = json['themeIndex'] as int? ?? 0;
    return _getThemeStateByIndex(index);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return {'themeIndex': state.themeIndex};
  }
}
