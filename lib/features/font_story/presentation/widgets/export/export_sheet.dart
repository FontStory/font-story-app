import 'dart:typed_data' show Uint8List;
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart'
    show BuildContextEasyLocalizationExtension, StringTranslateExtension;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_story/features/font_story/domain/entities/export_option.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:font_story/config/values/index.dart';
import 'package:font_story/core/constants/global.dart';
import 'package:font_story/core/extensions/index.dart';
import 'package:font_story/core/helpers/launch_url.dart';
import '../../cubit/export/export_cubit.dart';

part 'export_option_button.dart';

class ExportSheet extends StatelessWidget {
  const ExportSheet({
    super.key,
    required this.screenshotController,
    required this.focusNode,
    this.isTextFieldEmpty = false,
  });

  final ScreenshotController screenshotController;
  final FocusNode focusNode;
  final bool isTextFieldEmpty;

  Future<void> _captureAndExecute(
    BuildContext context,
    Future<void> Function(Uint8List) onCaptureSuccess,
  ) async {
    if (isTextFieldEmpty) return;

    focusNode.unfocus();
    await Future.delayed(const Duration(milliseconds: 100));
    if (!context.mounted) return;

    final imageBytes = await screenshotController.capture(
      pixelRatio: MediaQuery.of(context).devicePixelRatio,
    );

    if (imageBytes != null) {
      await onCaptureSuccess(imageBytes);
    }
  }

  Future<void> _shareAndLaunch(BuildContext context, String url) {
    return _captureAndExecute(context, (bytes) async {
      final bool success = await context.read<ExportCubit>().copyImage(
        imageBytes: bytes,
      );
      if (success && context.mounted) {
        launchAppUrl(url);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: context.typography.paragraph.copyWith(
        color: context.palette.onSurface,
      ),
      textAlign: TextAlign.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildExportOptions(
          context,
        ).map((option) => ExportOptionButton(option: option)).toList(),
      ),
    );
  }

  List<ExportOption> _buildExportOptions(BuildContext context) {
    return [
      ExportOption(
        icon: Icon(Iconsax.import_1_copy, color: context.palette.onSurface),
        backgroundColor: context.palette.surface,
        labelKey: 'ui.save_gallery',
        onTap: () => _captureAndExecute(
          context,
          (bytes) => context.read<ExportCubit>().saveImage(imageBytes: bytes),
        ),
      ),
      ExportOption(
        icon: Icon(Iconsax.copy_copy, color: context.palette.onSurface),
        backgroundColor: context.palette.surface,
        labelKey: 'ui.copy_clipboard',
        onTap: () => _captureAndExecute(
          context,
          (bytes) => context.read<ExportCubit>().copyImage(imageBytes: bytes),
        ),
      ),
      ExportOption(
        icon: SvgPicture.asset(
          'assets/icons/instagram.svg',
          height: 32,
          colorFilter: ColorFilter.mode(
            context.palette.onSurface,
            BlendMode.srcIn,
          ),
        ),
        backgroundColor: AppPalette.instagram,
        labelKey: 'ui.instagram_story',
        onTap: () => _shareAndLaunch(context, instagramUrl),
      ),
      ExportOption(
        icon: SvgPicture.asset(
          'assets/icons/whatsapp.svg',
          height: 32,
          colorFilter: ColorFilter.mode(
            context.palette.onSurface,
            BlendMode.srcIn,
          ),
        ),
        backgroundColor: AppPalette.whatsapp,
        labelKey: 'ui.whatsapp_status',
        onTap: () => _shareAndLaunch(context, whatsappUrl),
      ),
      ExportOption(
        icon: SvgPicture.asset(
          'assets/icons/telegram.svg',
          height: 28,
          colorFilter: ColorFilter.mode(
            context.palette.onSurface,
            BlendMode.srcIn,
          ),
        ),
        backgroundColor: AppPalette.telegram,
        labelKey: 'ui.telegram_sticker',
        onTap: () => _shareAndLaunch(context, telegramUrl),
      ),
    ];
  }
}
