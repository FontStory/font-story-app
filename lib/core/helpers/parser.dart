import 'package:flutter/material.dart';

/// A utility class with static methods to parse style-related JSON objects.
class StyleParser {
  /// Parses a hex string (e.g., "#RRGGBB" or "#AARRGGBB") into a [Color].
  static Color? parseColor(String? hexColor) {
    if (hexColor == null) return null;
    final buffer = StringBuffer();
    // Add full opacity (ff) if alpha channel is missing.
    if (hexColor.length == 7) buffer.write('ff');
    buffer.write(hexColor.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Parses a JSON map into a [Paint] object.
  static Paint _createPaint(Map<String, dynamic> paintJson) {
    return Paint()
      ..color = parseColor(paintJson['color']) ?? Colors.black
      ..strokeWidth = (paintJson['strokeWidth'] as num?)?.toDouble() ?? 1.0
      ..strokeJoin = (paintJson['strokeJoin'] == 'round')
          ? StrokeJoin.round
          : StrokeJoin.miter
      ..style = (paintJson['paintStyle'] == 'stroke')
          ? PaintingStyle.stroke
          : PaintingStyle.fill;
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

    TextDecoration? decoration;
    if (json['decoration'] == 'underline') {
      decoration = TextDecoration.underline;
    }

    TextDecorationStyle? decorationStyle;
    if (json['decorationStyle'] == 'wavy') {
      decorationStyle = TextDecorationStyle.wavy;
    } else if (json['decorationStyle'] == 'solid') {
      decorationStyle = TextDecorationStyle.solid;
    }

    return TextStyle(
      color: parseColor(json['color']),
      foreground: json['paint'] != null ? _createPaint(json['paint']) : null,
      background: json['backgroundPaint'] != null
          ? _createPaint(json['backgroundPaint'])
          : null,
      shadows: (json['shadows'] as List<dynamic>?)
          ?.map((s) => _parseShadow(s))
          .toList(),
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationThickness: (json['decorationThickness'] as num?)?.toDouble(),
    );
  }
}
