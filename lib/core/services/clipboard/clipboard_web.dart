import 'dart:typed_data' show Uint8List;
import 'package:pasteboard/pasteboard.dart';
import 'clipboard.dart';

final ClipboardService clipboard = WebClipboardService();

class WebClipboardService implements ClipboardService {
  @override
  Future<void> copyText(String text) async {
    try {
      Pasteboard.writeText(text);
    } catch (e) {
      throw Exception('Failed to copy text: $e');
    }
  }

  @override
  Future<void> copyImage(Uint8List bytes) async {
    try {
      await Pasteboard.writeImage(bytes);
    } catch (_) {
      throw Exception('Clipboard API is not supported on this platform.');
    }
  }
}
