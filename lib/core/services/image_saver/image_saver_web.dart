import 'dart:typed_data';
import 'dart:html' as html;

import 'image_saver.dart';

final ImageSaver imageSaver = WebImageSaver();

class WebImageSaver implements ImageSaver {
  @override
  Future<void> save(Uint8List bytes) async {
    _download(bytes);
  }

  void _download(Uint8List bytes) {
    final blob = html.Blob([bytes], 'image/png');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..download = 'IMG-${DateTime.now().millisecondsSinceEpoch}.png'
      ..style.display = 'none';

    html.document.body?.append(anchor);
    anchor.click();
    anchor.remove();
    html.Url.revokeObjectUrl(url);
  }
}
