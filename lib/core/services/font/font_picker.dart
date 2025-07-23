import 'dart:async';
import 'package:file_picker/file_picker.dart'
    show FilePicker, FileType, PlatformFile;
import 'package:flutter/services.dart' show PlatformException;
import 'package:injectable/injectable.dart' show LazySingleton;

import '../../helpers/log.dart';

abstract interface class FontPicker {
  Future<PlatformFile?> pickFontFile();
}

@LazySingleton(as: FontPicker)
class FilePickerAdapter implements FontPicker {
  static const _allowedExtensions = ['ttf', 'otf', 'woff', 'woff2', 'ttc'];

  @override
  Future<PlatformFile?> pickFontFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: _allowedExtensions,
        allowMultiple: false,
      );
      return result?.files.single;
    } on PlatformException catch (e, s) {
      LogManager.instance.e(
        'File picking failed due to a platform issue',
        e,
        s,
      );
      return null;
    } catch (e, s) {
      LogManager.instance.e(
        'An unexpected error occurred while picking a font',
        e,
        s,
      );
      return null;
    }
  }
}
