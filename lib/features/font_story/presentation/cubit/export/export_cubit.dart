import 'dart:typed_data' show Uint8List;
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:font_story/core/constants/enums/status.dart';
import 'package:font_story/core/services/clipboard/clipboard.dart';
import 'package:font_story/core/services/google_ads.dart';
import 'package:font_story/core/services/image_saver/image_saver.dart';
part 'export_state.dart';

class ExportCubit extends Cubit<ExportState> {
  final ClipboardService _clipboard;
  final ImageSaver _imageSaver;
  final AdManager _adManager;
  final bool noAds;

  ExportCubit(
    this._clipboard,
    this._imageSaver,
    this._adManager, {
    required this.noAds,
  }) : super(const ExportState()) {
    // Only load an ad if ads are enabled for the user.
    if (!noAds) {
      _adManager.loadRewardedAd();
    }
  }

  void messageHandled() {
    emit(state.copyWith(clearMessage: true));
  }

  Future<bool> copyImage({required Uint8List? imageBytes}) {
    return _executeExportAction(
      imageBytes: imageBytes,
      action: () => _clipboard.copyImage(imageBytes!),
      loadingMessageKey: 'messages.copying_image',
      successMessageKey: 'messages.copy_success',
      errorMessageKey: 'messages.copy_error',
    );
  }

  Future<bool> saveImage({required Uint8List? imageBytes}) {
    return _executeExportAction(
      imageBytes: imageBytes,
      action: () => _imageSaver.save(imageBytes!),
      loadingMessageKey: 'messages.saving_image',
      successMessageKey: 'messages.save_success',
      errorMessageKey: 'messages.save_error',
    );
  }

  Future<bool> _showAdIfNeeded() async {
    // If the user has the NoAds flag, we can proceed without an ad.
    if (noAds) {
      return true;
    }

    // Otherwise, show the ad and check if the user earned the reward.
    emit(
      state.copyWith(
        status: DataStatus.loading,
        message: 'messages.loading_ad'.tr(),
      ),
    );
    final bool rewardEarned = await _adManager.showRewardedAd();

    if (!rewardEarned) {
      emit(
        state.copyWith(
          status: DataStatus.error,
          message: 'messages.ad_reward_required'.tr(),
        ),
      );
      return false;
    }

    return true;
  }

  Future<bool> _executeExportAction({
    required Uint8List? imageBytes,
    required Future<void> Function() action,
    required String loadingMessageKey,
    required String successMessageKey,
    required String errorMessageKey,
  }) async {
    // Conditionally show an ad and check if we can proceed.
    final bool canProceed = await _showAdIfNeeded();
    if (!canProceed) {
      return false;
    }

    if (imageBytes == null) {
      emit(
        state.copyWith(
          status: DataStatus.error,
          message: 'messages.capture_error'.tr(),
        ),
      );
      return false;
    }

    emit(
      state.copyWith(
        status: DataStatus.loading,
        message: loadingMessageKey.tr(),
      ),
    );
    try {
      await action();
      emit(
        state.copyWith(
          status: DataStatus.success,
          message: successMessageKey.tr(),
        ),
      );
      return true;
    } catch (e) {
      emit(
        state.copyWith(status: DataStatus.error, message: errorMessageKey.tr()),
      );
      return false;
    }
  }
}
