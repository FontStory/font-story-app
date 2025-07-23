import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

abstract class PermissionHandler {
  Future<bool> requestGalleryPermission();
  Future<bool> requestStoragePermission();
}

@LazySingleton(as: PermissionHandler)
class PermissionHandlerService implements PermissionHandler {
  @override
  Future<bool> requestGalleryPermission() async {
    if (kIsWeb) return true;

    if (Platform.isIOS) {
      return _requestPermission(Permission.photos);
    }

    final sdk = await _getAndroidSdkVersion();
    final permission = sdk >= 33 ? Permission.photos : Permission.storage;
    return _requestPermission(permission);
  }

  @override
  Future<bool> requestStoragePermission() async {
    if (kIsWeb) return true;

    if (Platform.isIOS) {
      return _requestPermission(Permission.photosAddOnly);
    }

    final sdk = await _getAndroidSdkVersion();
    if (sdk <= 32) {
      return _requestPermission(Permission.storage);
    }

    return true; // Android 33+ does not require storage permission
  }

  Future<int> _getAndroidSdkVersion() async {
    final info = await DeviceInfoPlugin().androidInfo;
    return info.version.sdkInt;
  }

  Future<bool> _requestPermission(Permission permission) async {
    final status = await permission.request();
    if (status.isGranted) return true;

    if (status.isPermanentlyDenied || status.isDenied) {
      await openAppSettings();
    }

    return false;
  }
}
