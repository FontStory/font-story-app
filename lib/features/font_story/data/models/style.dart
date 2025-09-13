import 'dart:convert' show jsonDecode;

import 'package:isolate_manager/isolate_manager.dart';

class RelativePositionModel {
  final double? dx;
  final double? dy;

  const RelativePositionModel({this.dx, this.dy});

  factory RelativePositionModel.fromJson(Map<String, dynamic> json) {
    return RelativePositionModel(
      dx: (json['x'] as num?)?.toDouble(),
      dy: (json['y'] as num?)?.toDouble(),
    );
  }
}

class TextLayerStyleModel {
  final Map<String, dynamic>? style;
  final RelativePositionModel? position;

  const TextLayerStyleModel({this.style, this.position});

  factory TextLayerStyleModel.fromJson(Map<String, dynamic> json) {
    return TextLayerStyleModel(
      style: json['style'] as Map<String, dynamic>?,
      position: json['position'] != null
          ? RelativePositionModel.fromJson(json['position'])
          : null,
    );
  }
}

class TextEffectStyleModel {
  final String name;
  final String thumbnail;
  final String? defaultTextColor;
  final String? defaultStyleColor;
  final bool? canChangeColor;
  final Map<String, dynamic>? baseTextStyle;
  final Map<String, dynamic>? effectStyle;
  final List<TextLayerStyleModel>? layeredTextStyles;

  const TextEffectStyleModel({
    required this.name,
    required this.thumbnail,
    this.defaultTextColor,
    this.defaultStyleColor,
    this.canChangeColor,
    this.baseTextStyle,
    this.effectStyle,
    this.layeredTextStyles,
  });

  factory TextEffectStyleModel.fromJson(
    Map<String, dynamic> json, {
    required String baseUrl,
  }) {
    return TextEffectStyleModel(
      name: json['name'] ?? '',
      thumbnail: '$baseUrl${json['thumbnail']}',
      defaultTextColor: json['defaultTextColor'] as String?,
      defaultStyleColor: json['defaultStyleColor'] as String?,
      canChangeColor: json['canChangeColor'] as bool?,
      baseTextStyle: json['baseTextStyle'] as Map<String, dynamic>?,
      effectStyle: json['effectStyle'] as Map<String, dynamic>?,
      layeredTextStyles: (json['layeredTextStyles'] as List<dynamic>?)
          ?.map((e) => TextLayerStyleModel.fromJson(e))
          .toList(),
    );
  }

  @pragma('vm:entry-point')
  @isolateManagerWorker
  static List<TextEffectStyleModel> fromNestedJson(
    Map<String, String> payload,
  ) {
    final List<TextEffectStyleModel> styles = [];

    final jsonString = payload['jsonString'];
    final baseUrl = payload['baseUrl'];

    if (jsonString == null || baseUrl == null) return [];

    try {
      final decodedJson = jsonDecode(jsonString);

      if (decodedJson is! List) return [];

      for (final styleData in decodedJson) {
        if (styleData is Map<String, dynamic>) {
          styles.add(
            TextEffectStyleModel.fromJson(styleData, baseUrl: baseUrl),
          );
        }
      }
    } catch (e) {
      rethrow;
    }

    return styles;
  }
}
