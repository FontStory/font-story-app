import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:font_story/core/services/network.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class InternetConnectivityCubit extends Cubit<bool> {
  final NetworkManager _networkManager;

  InternetConnectivityCubit(this._networkManager) : super(true);

  Future<void> checkInternetConnection() async {
    if (kIsWeb) {
      emit(true);
      return;
    }
    if (await _networkManager.isConnected &&
        await _networkManager.checkNetworkConnection()) {
      emit(true);
    } else {
      emit(false);
    }
  }
}
