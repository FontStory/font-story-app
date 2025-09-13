import 'package:flutter/material.dart';

/// A utility class with static methods to parse style-related JSON objects.
class StyleParser {
  /// Parses a hex string (e.g., "#RRGGBB" or "#AARRGGBB") into a [Color].
  static Color? parseColor(String? hexColor) {
    if (hexColor == null || hexColor.isEmpty) return null;
    final colorString = hexColor.replaceFirst('#', '');
    if (colorString.length == 6) {
      return Color(int.parse('ff$colorString', radix: 16));
    } else if (colorString.length == 8) {
      return Color(int.parse(colorString, radix: 16));
    }
    return null; // Return null for invalid formats
  }

  /// Parses a JSON map into a [Paint] object.
  static Paint _createPaint(Map<String, dynamic> paintJson) {
    return Paint()
      ..color = parseColor(paintJson['color']) ?? Colors.black
      ..strokeWidth = (paintJson['strokeWidth'] as num?)?.toDouble() ?? 1.0
      ..strokeJoin = switch (paintJson['strokeJoin']) {
        'round' => StrokeJoin.round,
        _ => StrokeJoin.miter,
      }
      ..style = switch (paintJson['paintStyle']) {
        'stroke' => PaintingStyle.stroke,
        _ => PaintingStyle.fill,
      };
  }

  /// Parses a JSON map into a [Shadow] object.
  static Shadow _parseShadow(Map<String, dynamic> json) {
    return Shadow(
      color: parseColor(json['color']) ?? Colors.black,
      blurRadius: (json['blurRadius'] as num?)?.toDouble() ?? 0.0,
      offset: Offset(
        (json['offsetX'] as num?)?.toDouble() ?? 0.0,
        (json['offsetY'] as num?)?.toDouble() ?? 0.0,
      ),
    );
  }

  /// Parses a JSON map into a [TextStyle] object.
  static TextStyle? parseTextStyle(Map<String, dynamic>? json) {
    if (json == null) return null;

    final decoration = switch (json['decoration']) {
      'underline' => TextDecoration.underline,
      'overline' => TextDecoration.overline,
      'lineThrough' => TextDecoration.lineThrough,
      _ => null,
    };

    final decorationStyle = switch (json['decorationStyle']) {
      'wavy' => TextDecorationStyle.wavy,
      'solid' => TextDecorationStyle.solid,
      'dashed' => TextDecorationStyle.dashed,
      'dotted' => TextDecorationStyle.dotted,
      'double' => TextDecorationStyle.double,
      _ => null,
    };

    return TextStyle(
      color: parseColor(json['color']),
      fontSize: (json['fontSize'] as num?)?.toDouble(),
      fontWeight: _parseFontWeight(json['fontWeight'] as String?),
      fontStyle: json['fontStyle'] == 'italic' ? FontStyle.italic : null,
      foreground: json['paint'] != null ? _createPaint(json['paint']) : null,
      background: json['backgroundPaint'] != null
          ? _createPaint(json['backgroundPaint'])
          : null,
      shadows: (json['shadows'] as List<dynamic>?)
          ?.map((s) => _parseShadow(s as Map<String, dynamic>))
          .toList(),
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationColor: parseColor(json['decorationColor']),
      decorationThickness: (json['decorationThickness'] as num?)?.toDouble(),
      letterSpacing: (json['letterSpacing'] as num?)?.toDouble(),
      wordSpacing: (json['wordSpacing'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      fontFamily: json['fontFamily'] as String?,
    );
  }

  static FontWeight? _parseFontWeight(String? weight) {
    return switch (weight) {
      'w100' => FontWeight.w100,
      'w200' => FontWeight.w200,
      'w300' => FontWeight.w300,
      'w400' => FontWeight.w400,
      'w500' => FontWeight.w500,
      'w600' => FontWeight.w600,
      'w700' => FontWeight.w700,
      'w800' => FontWeight.w800,
      'w900' => FontWeight.w900,
      _ => null,
    };
  }
}
