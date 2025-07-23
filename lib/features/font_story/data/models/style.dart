import 'dart:convert' show jsonDecode;

import 'package:flutter/material.dart';
import 'package:font_story/core/helpers/parser.dart';

import '../../domain/entities/index.dart';

class RelativePositionModel extends RelativePosition {
  const RelativePositionModel({super.dx, super.dy});

  factory RelativePositionModel.fromJson(Map<String, dynamic> json) {
    return RelativePositionModel(
      dx: (json['x'] as num?)?.toDouble(),
      dy: (json['y'] as num?)?.toDouble(),
    );
  }
}

class TextLayerStyleModel extends TextLayerStyle {
  const TextLayerStyleModel({required super.style, super.position});

  factory TextLayerStyleModel.fromJson(Map<String, dynamic> json) {
    final parsedStyle = StyleParser.parseTextStyle(json['style']);
    return TextLayerStyleModel(
      style: parsedStyle ?? const TextStyle(),
      position: json['position'] != null
          ? RelativePositionModel.fromJson(
              json['position'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

class TextEffectStyleModel extends TextEffectStyle {
  const TextEffectStyleModel({
    required super.id,
    required super.name,
    required super.thumbnail,
    super.defaultTextColor,
    super.baseTextStyle,
    super.effectStyle,
    super.layeredTextStyles,
    super.defaultStyleColor,
    super.canChangeColor,
  });

  factory TextEffectStyleModel.fromJson(
    Map<String, dynamic> json, {
    required String baseUrl,
  }) {
    return TextEffectStyleModel(
      id: (json['name']?.toString().hashCode ?? 0),
      name: json['name'] ?? '',
      thumbnail: '$baseUrl${json['thumbnail']}',
      defaultTextColor: StyleParser.parseColor(json['defaultTextColor']),
      baseTextStyle: StyleParser.parseTextStyle(json['baseTextStyle']),
      effectStyle: StyleParser.parseTextStyle(json['effectStyle']),
      layeredTextStyles: (json['layeredTextStyles'] as List<dynamic>?)
          ?.map((e) => TextLayerStyleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultStyleColor: StyleParser.parseColor(json['defaultStyleColor']),
      canChangeColor: (json['canChangeColor'] as bool?) ?? false,
    );
  }

  @pragma('vm:entry-point')
  static List<TextEffectStyleModel> parseToUiModel(
    Map<String, dynamic> payload,
  ) {
    final List<dynamic> data = jsonDecode(payload['jsonString']);
    final baseUrl = payload['baseUrl'] as String;

    return data
        .map(
          (json) => TextEffectStyleModel.fromJson(
            json as Map<String, dynamic>,
            baseUrl: baseUrl,
          ),
        )
        .toList();
  }
}
