import 'dart:typed_data' show Uint8List;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_story/core/constants/global.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:font_story/config/values/index.dart';
import 'package:font_story/core/extensions/index.dart';
import 'package:screenshot/screenshot.dart';

import '../cubit/export/export_cubit.dart';

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

  /// Handles the entire share process: capture, copy, and launch.
  Future<void> _shareAndLaunch(BuildContext context, String url) async {
    await _captureAndAct(context, (bytes) async {
      final cubit = context.read<ExportCubit>();
      final bool success = await cubit.copyImage(imageBytes: bytes);
      if (success && context.mounted) {
        cubit.launchAppUrl(url);
      }
    });
  }

  /// Captures the screenshot and executes the given action.
  Future<void> _captureAndAct(
      BuildContext context,
      Future<void> Function(Uint8List) onCaptured,
      ) async {
    if (isTextFieldEmpty) return;

    focusNode.unfocus();
    await Future.delayed(const Duration(milliseconds: 100));

    if (context.mounted) {
      final imageBytes = await screenshotController.capture(
        pixelRatio: MediaQuery.devicePixelRatioOf(context),
      );
      if (imageBytes != null) {
        await onCaptured(imageBytes);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<_ExportOption> exportOptions = [
      _ExportOption(
        icon: Icon(Iconsax.import_1_copy, color: context.palette.onSurface),
        backgroundColor: context.palette.surface,
        labelKey: 'ui.save_gallery',
        onTap: () async => await _captureAndAct(
          context,
              (bytes) async => await context.read<ExportCubit>().saveImage(imageBytes: bytes),
        ),
      ),
      _ExportOption(
        icon: SvgPicture.asset('assets/icons/instagram.svg', height: 32,
            colorFilter: ColorFilter.mode(context.palette.onSurface, BlendMode.srcIn)),
        backgroundColor: AppPalette.instagram,
        labelKey: 'ui.instagram_story',
        onTap: () async => await _shareAndLaunch(context, instagramUrl),
      ),
      _ExportOption(
        icon: SvgPicture.asset('assets/icons/whatsapp.svg', height: 32,
            colorFilter: ColorFilter.mode(context.palette.onSurface, BlendMode.srcIn)),
        backgroundColor: AppPalette.whatsapp,
        labelKey: 'ui.whatsapp_status',
        onTap: () async => await _shareAndLaunch(context, whatsappUrl),
      ),
      _ExportOption(
        icon: SvgPicture.asset('assets/icons/telegram.svg', height: 28,
            colorFilter: ColorFilter.mode(context.palette.onSurface, BlendMode.srcIn)),
        backgroundColor: AppPalette.telegram,
        labelKey: 'ui.telegram_sticker',
        onTap: () async => await _shareAndLaunch(context, telegramUrl),
      ),
    ];

    return DefaultTextStyle(
      style: context.typography.paragraph.copyWith(
        color: context.palette.onSurface,
      ),
      textAlign: TextAlign.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: exportOptions
            .map((option) => _ExportOptionButton(option: option))
            .toList(),
      ),
    );
  }
}

class _ExportOptionButton extends StatelessWidget {
  const _ExportOptionButton({required this.option});

  final _ExportOption option;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: option.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: option.backgroundColor,
              child: option.icon,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(option.labelKey.tr()),
          ],
        ),
      ),
    );
  }
}

class _ExportOption {
  const _ExportOption({
    required this.icon,
    required this.backgroundColor,
    required this.labelKey,
    this.onTap,
  });

  final Widget icon;
  final Color backgroundColor;
  final String labelKey;
  final VoidCallback? onTap;
}