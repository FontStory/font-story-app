export 'image_saver_stub.dart'
    if (dart.library.html) 'image_saver_web.dart'
    if (dart.library.io) 'image_saver_mobile.dart';