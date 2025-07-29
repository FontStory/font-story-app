import 'dart:typed_data';
import 'dart:io';

import 'package:font_story/locator/service_locator.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

import '../permission_handler.dart';
import 'image_saver.dart';

final ImageSaver imageSaver = MobileImageSaver(locator.get());

class MobileImageSaver implements ImageSaver {
  final PermissionHandler _permissionHandler;

  MobileImageSaver(this._permissionHandler);

  @override
  Future<void> save(Uint8List bytes) async {
    final hasPermission = await _permissionHandler.requestStoragePermission();
    if (!hasPermission) {
      throw Exception('Storage permission not granted.');
    }

    await _saveImageToGallery(bytes);
  }

  Future<void> _saveImageToGallery(Uint8List bytes) async {
    final tempDir = await getTemporaryDirectory();
    final filePath =
        '${tempDir.path}/IMG-${DateTime.now().millisecondsSinceEpoch}.png';

    final file = await File(filePath).writeAsBytes(bytes);

    final result = await ImageGallerySaver.saveFile(file.path);
    if (result == null || result['isSuccess'] != true) {
      throw Exception('Failed to save image to gallery.');
    }
  }
}
