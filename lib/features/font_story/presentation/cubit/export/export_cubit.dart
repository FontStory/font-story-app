import 'dart:typed_data' show Uint8List;

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:font_story/core/constants/enums/status.dart';
import 'package:font_story/core/services/clipboard/clipboard.dart';
import 'package:font_story/core/services/image_saver/image_saver.dart';
import 'package:url_launcher/url_launcher.dart';

part 'export_state.dart';

class ExportCubit extends Cubit<ExportState> {
  final ClipboardService clipboard;
  final ImageSaver imageSaver;

  ExportCubit(this.clipboard, this.imageSaver) : super(const ExportState());

  void launchAppUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void messageHandled() {
    emit(state.copyWith(clearMessage: true));
  }

  /// Copies the image and returns true on success, false on failure.
  Future<bool> copyImage({required Uint8List? imageBytes}) async {
    emit(state.copyWith(status: DataStatus.loading));

    if (imageBytes == null) {
      emit(
        state.copyWith(
          status: DataStatus.error,
          message: 'messages.capture_error'.tr(),
        ),
      );
      return false;
    }

    try {
      await clipboard.copyImage(imageBytes);
      emit(
        state.copyWith(
          status: DataStatus.success,
          message: 'messages.copy_success'.tr(),
        ),
      );
      return true;
    } catch (e) {
      emit(
        state.copyWith(
          status: DataStatus.error,
          message: 'messages.copy_error'.tr(),
        ),
      );
      return false;
    }
  }

  Future<void> saveImage({required Uint8List? imageBytes}) async {
    emit(state.copyWith(status: DataStatus.loading));

    if (imageBytes == null) {
      emit(
        state.copyWith(
          status: DataStatus.error,
          message: 'messages.capture_error'.tr(),
        ),
      );
      return;
    }

    try {
      await imageSaver.save(imageBytes);
      emit(
        state.copyWith(
          status: DataStatus.success,
          message: 'messages.save_success'.tr(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: DataStatus.error,
          message: 'messages.save_error'.tr(),
        ),
      );
    }
  }
}
