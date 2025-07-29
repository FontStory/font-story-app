import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;

abstract class Failure {
  final String message;

  const Failure({required this.message});
}

class UnknownFailure extends Failure {
  UnknownFailure({String? message})
    : super(message: message ?? 'went_wrong'.tr());
}

class ServerFailure extends Failure {
  ServerFailure({String? message})
    : super(message: message ?? 'went_wrong'.tr());
}

class NetworkFailure extends Failure {
  NetworkFailure({String? message})
    : super(message: message ?? 'network_connection_error'.tr());
}
