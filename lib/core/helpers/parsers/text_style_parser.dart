import 'package:flutter/material.dart';
import 'package:font_story/core/extensions/string.dart';

/// A utility class with static methods to parse style-related JSON objects.

class TextStyleParser {
  static final Map<Map<String, dynamic>, TextStyle> _cache = {};

  static TextStyle? parseTextStyle(Map<String, dynamic>? json) {
    if (json == null) return null;

    // Check cache first
    if (_cache.containsKey(json)) return _cache[json];

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

    final style = TextStyle(
      color: (json['color'] as String?)?.parseColor,
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
      decorationColor: (json['decorationColor'] as String?)?.parseColor,
      decorationThickness: (json['decorationThickness'] as num?)?.toDouble(),
      letterSpacing: (json['letterSpacing'] as num?)?.toDouble(),
      wordSpacing: (json['wordSpacing'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      fontFamily: json['fontFamily'] as String?,
    );

    _cache[json] = style;
    return style;
  }

  static Paint _createPaint(Map<String, dynamic> paintJson) {
    return Paint()
      ..color = (paintJson['color'] as String?)?.parseColor ?? Colors.black
      ..strokeWidth = (paintJson['strokeWidth'] as num?)?.toDouble() ?? 1.0
      ..strokeJoin = switch (paintJson['strokeJoin']) {
        'round' => StrokeJoin.round,
        _ => StrokeJoin.miter,
      }
      ..strokeCap = switch (paintJson['strokeCap']) {
        'round' => StrokeCap.round,
        'square' => StrokeCap.square,
        _ => StrokeCap.butt,
      }
      ..style = switch (paintJson['paintStyle']) {
        'stroke' => PaintingStyle.stroke,
        _ => PaintingStyle.fill,
      };
  }

  static BoxShadow _parseShadow(Map<String, dynamic> json) {
    return BoxShadow(
      color: (json['color'] as String?)?.parseColor ?? Colors.transparent,
      blurRadius: (json['blurRadius'] as num?)?.toDouble() ?? 0.0,
      spreadRadius: (json['spreadRadius'] as num?)?.toDouble() ?? 0.0,
      offset: Offset(
        (json['offsetX'] as num?)?.toDouble() ?? 0.0,
        (json['offsetY'] as num?)?.toDouble() ?? 0.0,
      ),
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
