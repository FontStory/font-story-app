import 'dart:convert';

import 'package:isolate_manager/isolate_manager.dart' show isolateManagerWorker;

import '../../domain/entities/font.dart';

class FontModel extends FontEntity {
  const FontModel({
    required super.id,
    required super.title,
    required super.fontFamily,
    required super.path,
    super.language,
  });

  factory FontModel.fromJson(
    Map<String, dynamic> json, {
    required String language,
    required String baseUrl,
  }) {
    final path = '$baseUrl${json['url']}';
    return FontModel(
      id: path.hashCode,
      title: json['name'],
      fontFamily: json['name'],
      path: path,
      language: language,
    );
  }

  @pragma('vm:entry-point')
  @isolateManagerWorker
  static List<FontModel> fromNestedJson(Map<String, String> payload) {
    final List<FontModel> fonts = [];
    try {
      final jsonString = payload['jsonString']!;
      final baseUrl = payload['baseUrl']!;
      final languageKey = payload['language']!.toLowerCase();

      final decodedJson = jsonDecode(jsonString);
      final fontsByLanguage = decodedJson['fonts'] as Map<String, dynamic>;

      final fontList = fontsByLanguage[languageKey] as List?;
      if (fontList == null) {
        return [];
      }

      for (final fontData in fontList) {
        if (fontData is Map<String, dynamic>) {
          fonts.add(
            FontModel.fromJson(
              fontData,
              language: languageKey,
              baseUrl: baseUrl,
            ),
          );
        }
      }
    } catch (e) {
      rethrow;
    }

    return fonts;
  }
}
