import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;

class ApiException implements Exception {
  final int? code;
  final String? _message;

  const ApiException({this.code, String? message}) : _message = message;

  String get message => _message ?? 'went_wrong'.tr();
}
