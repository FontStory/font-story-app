import 'dart:typed_data';

import 'image_saver.dart';

final ImageSaver imageSaver = FallbackImageSaver();

class FallbackImageSaver implements ImageSaver {
  @override
  Future<void> save(Uint8List bytes) async {
    throw Exception('save() not implemented on this platform.');
  }

  @override
  Future<void> downloadAndSave(String imageUrl) async {
    throw Exception('downloadAndSave() not implemented on this platform.');
  }
}
