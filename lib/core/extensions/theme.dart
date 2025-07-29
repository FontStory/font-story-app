import 'package:flutter/material.dart' show BuildContext, ThemeData, Theme;
import 'package:font_story/config/themes/extensions/color_palette.dart';
import 'package:font_story/config/themes/extensions/text_typography.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorPalette get palette => theme.extension<ColorPalette>()!;

  TextTypography get typography => theme.extension<TextTypography>()!;
}
