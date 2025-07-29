import 'package:flutter/material.dart';

class RelativePosition {
  final double? dx;
  final double? dy;

  const RelativePosition({this.dx, this.dy});
}

class TextLayerStyle {
  final TextStyle style;
  final RelativePosition? position;

  const TextLayerStyle({required this.style, this.position});
}

class TextEffectStyle {
  final int id;
  final String name;
  final String thumbnail;
  final List<TextLayerStyle>? layeredTextStyles;
  final TextStyle? baseTextStyle;
  final TextStyle? effectStyle;
  final Color? defaultTextColor;
  final Color? defaultStyleColor;
  final bool canChangeColor;

  const TextEffectStyle({
    required this.id,
    required this.name,
    required this.thumbnail,
    this.defaultTextColor,
    this.layeredTextStyles,
    this.baseTextStyle,
    this.effectStyle,
    this.defaultStyleColor,
    this.canChangeColor = false,
  });
}
