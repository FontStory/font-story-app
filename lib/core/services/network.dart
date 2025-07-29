import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

abstract interface class NetworkManager {
  Future<bool> get isConnected;
  Future<bool> checkNetworkConnection();
}

@LazySingleton(as: NetworkManager)
class NetworkManagerImpl implements NetworkManager {
  NetworkManagerImpl();

  @override
  Future<bool> get isConnected async {
    final connectivityResults = await Connectivity().checkConnectivity();
    const connectedTypes = {
      ConnectivityResult.mobile,
      ConnectivityResult.wifi,
      ConnectivityResult.ethernet,
      ConnectivityResult.vpn,
      ConnectivityResult.other,
    };
    return connectivityResults.any(connectedTypes.contains);
  }

  @override
  Future<bool> checkNetworkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }
}
