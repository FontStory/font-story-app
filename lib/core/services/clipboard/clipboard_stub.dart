import 'dart:typed_data';
import 'clipboard.dart';

final ClipboardService clipboard = FallbackClipboardService();

class FallbackClipboardService implements ClipboardService {
  @override
  Future<void> copyText(String text) async =>
      throw Exception('Clipboard not supported on this platform.');

  @override
  Future<void> copyImage(Uint8List bytes) async =>
      throw Exception('Clipboard not supported on this platform.');
}
