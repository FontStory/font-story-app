import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:font_story/core/constants/enums/status.dart';
import 'package:font_story/core/services/network.dart';
import 'package:font_story/features/font_story/domain/usecases/sync_initial_data.dart';

class SyncCubit extends Cubit<DataStatus> {
  final NetworkManager _networkManager;
  final SyncInitialData _syncInitialData;

  SyncCubit(this._networkManager, this._syncInitialData)
    : super(DataStatus.initial);

  void syncData() async {
    emit(DataStatus.loading);

    if (!kIsWeb) {
      final isConnected = await _networkManager.isConnected;
      final canReachInternet = await _networkManager.checkNetworkConnection();

      if (!isConnected || !canReachInternet) {
        emit(DataStatus.error);
        return;
      }
    }

    final result = await _syncInitialData.call();
    result.fold((_) => emit(DataStatus.error), (_) => emit(DataStatus.success));
  }
}
