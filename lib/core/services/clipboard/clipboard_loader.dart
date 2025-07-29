export 'clipboard_stub.dart'
    if (dart.library.html) 'clipboard_web.dart'
    if (dart.library.io) 'clipboard_mobile.dart';
