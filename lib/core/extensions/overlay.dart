import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_story/core/extensions/index.dart';
import 'package:font_story/config/values/index.dart';

import '../components/bottom_sheets/bottom_sheet.dart';
import '../components/buttons/button.dart';

extension OverlayExtension on BuildContext {
  void showCustomBottomSheet({
    required Widget content,
    bool isDismissible = true,
    bool enableDrag = true,
    Color backgroundOverlayColor = Colors.black54,
    Duration animationDuration = const Duration(milliseconds: 300),
    Curve animationCurve = Curves.easeInOut,
  }) {
    showModalBottomSheet(
      context: this,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      barrierColor: backgroundOverlayColor,
      transitionAnimationController: AnimationController(
        vsync: navigator,
        duration: animationDuration,
      ),
      builder: (BuildContext context) {
        return BottomSheetContent(
          content: content,
          animationCurve: animationCurve,
        );
      },
    );
  }

  Future<T?> showCustomDialog<T>({
    required Widget content,
    Duration? autoDismissDuration = const Duration(milliseconds: 2800),
    bool isDismissible = true,
    Color backgroundOverlayColor = Colors.black54,
    Duration animationDuration = const Duration(milliseconds: 300),
    Curve animationCurve = Curves.easeInOut,
    double maxWidth = 400.0,
    EdgeInsets padding = const EdgeInsets.all(16.0),
    Color? backgroundColor,
  }) {
    // Check if a modal route (like a dialog) is already active.
    if (ModalRoute.of(this)?.isCurrent != true) {
      // If so, pop the current route to dismiss the existing dialog.
      pop();
    }

    final dialogFuture = showDialog<T>(
      context: this,
      barrierDismissible: isDismissible,
      barrierColor: backgroundOverlayColor,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: backgroundColor,
          child: Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            padding: padding,
            child: content,
          ),
        );
      },
    );

    if (autoDismissDuration != null) {
      Future.delayed(autoDismissDuration, () {
        if (canPop) {
          pop();
        }
      });
    }

    return dialogFuture;
  }

  Future<void> showColorPickerDialog({
    required Color defaultColor,
    required Function(Color) onColorChanged,
    bool isDismissible = true,
    Color backgroundOverlayColor = Colors.black54,
    Duration animationDuration = const Duration(milliseconds: 300),
    Curve animationCurve = Curves.easeInOut,
  }) {
    return showDialog<void>(
      context: this,
      barrierDismissible: isDismissible,
      barrierColor: backgroundOverlayColor,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: AlertDialog(
            contentPadding: AppSpacing.xl.all,
            backgroundColor: context.palette.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: AppRadius.circle,
                bottom: AppRadius.xlg,
              ),
            ),
            content: SingleChildScrollView(
              child: Theme(
                data: context.theme.copyWith(
                  textTheme: context.theme.textTheme.copyWith(
                    bodyLarge: context.theme.textTheme.bodyLarge?.copyWith(
                      color: context.palette.onSurface,
                    ),
                    bodyMedium: context.theme.textTheme.bodyMedium?.copyWith(
                      color: context.palette.onSurface,
                    ),
                  ),
                ),
                child: HueRingPicker(
                  portraitOnly: true,
                  enableAlpha: true,
                  pickerColor: defaultColor,
                  onColorChanged: onColorChanged,
                ),
              ),
            ),
            actionsPadding:
                AppSpacing.lg.left + AppSpacing.lg.bottom + AppSpacing.lg.right,
            actions: [
              AppButton.primary(
                context: context,
                isExpanded: true,
                appButtonSize: AppButtonSize.xlarge,
                label: 'ui.select_color'.tr(),
                onTap: () => context.pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}
