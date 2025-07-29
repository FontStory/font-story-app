import 'package:flutter/services.dart' show ByteData, FontLoader, Uint8List;
import 'package:injectable/injectable.dart' show LazySingleton;

import '../../helpers/log.dart';

abstract interface class DynamicFontLoader {
  Set<String> get loadedFontFamilies;

  Future<void> load({required String fontFamily, required Uint8List bytes});
}

@LazySingleton(as: DynamicFontLoader)
class DefaultDynamicFontLoader implements DynamicFontLoader {
  /// A cache to keep track of font families that have already been loaded.
  @override
  final loadedFontFamilies = <String>{};

  @override
  Future<void> load({
    required String fontFamily,
    required Uint8List bytes,
  }) async {
    if (loadedFontFamilies.contains(fontFamily)) {
      LogManager.instance.d('Font family "$fontFamily" is already loaded.');
      return;
    }

    try {
      final fontLoader = FontLoader(fontFamily);
      fontLoader.addFont(Future.value(ByteData.view(bytes.buffer)));
      await fontLoader.load();

      loadedFontFamilies.add(fontFamily);
      LogManager.instance.i('Successfully loaded font family "$fontFamily".');
    } catch (e, s) {
      LogManager.instance.e('Error loading font family "$fontFamily"', e, s);
    }
  }
}
