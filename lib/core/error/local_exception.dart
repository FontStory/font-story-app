import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;

class LocaleException implements Exception {
  final String? _message;

  const LocaleException({String? message}) : _message = message;

  String get message => _message ?? 'went_wrong'.tr();
}
