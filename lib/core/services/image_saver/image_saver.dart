import 'dart:typed_data';

abstract class ImageSaver {
  Future<void> save(Uint8List bytes);
}
