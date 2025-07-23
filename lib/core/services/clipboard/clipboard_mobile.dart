import 'dart:typed_data' show Uint8List;
import 'package:super_clipboard/super_clipboard.dart';

import 'clipboard.dart';

final ClipboardService clipboard = MobileClipboardService();

class MobileClipboardService implements ClipboardService {
  @override
  Future<void> copyText(String text) async {
    final clipboard = SystemClipboard.instance;
    if (clipboard != null) {
      final item = DataWriterItem();
      item.add(Formats.plainText(text));
      await clipboard.write([item]);
    } else {
      throw Exception('Clipboard API is not supported on this platform.');
    }
  }

  @override
  Future<void> copyImage(Uint8List bytes) async {
    final clipboard = SystemClipboard.instance;
    if (clipboard != null) {
      final item = DataWriterItem(
          suggestedName: 'IMG-${DateTime.now().millisecondsSinceEpoch}.png');
      item.add(Formats.png(bytes));
      await clipboard.write([item]);
    } else {
      throw Exception('Clipboard API is not supported on this platform.');
    }
  }
}
