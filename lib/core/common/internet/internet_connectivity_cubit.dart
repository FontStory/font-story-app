import 'package:bloc/bloc.dart';
import 'package:font_story/core/services/network.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class InternetConnectivityCubit extends Cubit<bool> {
  final NetworkManager _networkManager;

  InternetConnectivityCubit(this._networkManager) : super(false);

  Future<void> checkInternetConnection() async {
    if (await _networkManager.isConnected &&
        await _networkManager.checkNetworkConnection()) {
      emit(true);
    } else {
      emit(false);
    }
  }
}
