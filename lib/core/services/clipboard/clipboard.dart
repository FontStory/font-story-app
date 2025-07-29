import 'dart:typed_data';

abstract class ClipboardService {
  Future<void> copyText(String text);
  Future<void> copyImage(Uint8List bytes);
}
