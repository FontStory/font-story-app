import 'package:flutter/material.dart';
import 'package:font_story/core/extensions/index.dart';

import '../../../config/values/index.dart';

enum AppButtonSize {
  /// Extra small button size
  xSmall,

  /// Small button size
  small,

  /// Medium button size
  medium,

  /// Large button size
  large,

  /// Extra large button size
  xlarge,

  /// Extra extra large button size
  xxLarge,
}

typedef IconBuilder = Widget Function(Color iconColor);

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onTap,
    this.isExpanded = false,
    this.leading,
    this.trailing,
    this.appButtonSize = AppButtonSize.medium,
    required this.backgroundColor,
    required this.focusColor,
    required this.hoverColor,
    required this.disabledColor,
    required this.textColor,
    required this.disabledTextColor,
  });

  final String label;

  final VoidCallback? onTap;

  final bool isExpanded;

  final IconBuilder? leading;

  final IconBuilder? trailing;

  final AppButtonSize appButtonSize;

  final Color backgroundColor;

  final Color focusColor;

  final Color hoverColor;

  final Color disabledColor;

  final Color textColor;

  final Color disabledTextColor;

  BorderSide defaultBorder(BuildContext context) => BorderSide.none;

  BorderSide focusedBorder(BuildContext context) => BorderSide.none;

  BorderSide hoverBorder(BuildContext context) => BorderSide.none;

  BorderSide disabledBorder(BuildContext context) => BorderSide.none;

  factory AppButton.primary({
    required BuildContext context,
    required String label,
    VoidCallback? onTap,
    AppButtonSize appButtonSize = AppButtonSize.medium,
    bool isExpanded = false,
    IconBuilder? leading,
    IconBuilder? trailing,
  }) {
    return AppButton(
      label: label,
      onTap: onTap,
      isExpanded: isExpanded,
      leading: leading,
      trailing: trailing,
      appButtonSize: appButtonSize,
      backgroundColor: context.palette.primary,
      focusColor: context.palette.primary.withValues(alpha: 0.52),
      hoverColor: context.palette.primary.withValues(alpha: 0.56),
      disabledColor: context.palette.primary.withValues(alpha: 0.52),
      textColor: context.palette.onPrimary,
      disabledTextColor: context.palette.onPrimary.withValues(alpha: 0.38),
    );
  }

  factory AppButton.secondary({
    required BuildContext context,
    required String label,
    VoidCallback? onTap,
    AppButtonSize appButtonSize = AppButtonSize.medium,
    bool isExpanded = false,
    IconBuilder? leading,
    IconBuilder? trailing,
  }) {
    return AppButton(
      label: label,
      onTap: onTap,
      isExpanded: isExpanded,
      leading: leading,
      trailing: trailing,
      appButtonSize: appButtonSize,
      backgroundColor: context.palette.secondary,
      focusColor: context.palette.secondary.withValues(alpha: 0.52),
      hoverColor: context.palette.secondary.withValues(alpha: 0.56),
      disabledColor: context.palette.primary.withValues(alpha: 0.52),
      textColor: context.palette.onSecondary,
      disabledTextColor: context.palette.onSecondary.withValues(alpha: 0.38),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inputTextColor = WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) return disabledTextColor;
      return textColor;
    });

    return TextButton(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return disabledColor;
          if (states.contains(WidgetState.hovered)) return hoverColor;
          if (states.contains(WidgetState.focused)) return focusColor;
          if (states.contains(WidgetState.pressed)) return focusColor;
          return backgroundColor;
        }),
        shape: WidgetStateProperty.resolveWith((states) {
          final shape = RoundedRectangleBorder(
            borderRadius: BorderRadius.all(AppRadius.md),
          );

          if (states.contains(WidgetState.disabled)) {
            return shape.copyWith(side: disabledBorder(context));
          }

          if (states.contains(WidgetState.focused)) {
            return shape.copyWith(side: focusedBorder(context));
          }

          if (states.contains(WidgetState.hovered)) {
            return shape.copyWith(side: hoverBorder(context));
          }

          if (states.contains(WidgetState.pressed)) {
            return shape.copyWith(side: focusedBorder(context));
          }

          return shape.copyWith(side: defaultBorder(context));
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return disabledColor;
          if (states.contains(WidgetState.hovered)) return hoverColor;
          if (states.contains(WidgetState.focused)) return focusColor;
          if (states.contains(WidgetState.pressed)) return focusColor;
          return backgroundColor;
        }),
        foregroundColor: inputTextColor,
        fixedSize: WidgetStateProperty.all(switch (appButtonSize) {
          AppButtonSize.small ||
          AppButtonSize.xSmall => const Size(double.infinity, 36),
          AppButtonSize.medium => const Size(double.infinity, 40),
          AppButtonSize.large => const Size(double.infinity, 44),
          AppButtonSize.xlarge => const Size(double.infinity, 48),
          AppButtonSize.xxLarge => const Size(double.infinity, 56),
        }),
        padding: WidgetStateProperty.all(switch (appButtonSize) {
          AppButtonSize.small ||
          AppButtonSize.xSmall => const EdgeInsets.symmetric(horizontal: 12),
          AppButtonSize.medium => const EdgeInsets.symmetric(horizontal: 16),
          AppButtonSize.large => const EdgeInsets.symmetric(horizontal: 16),
          AppButtonSize.xlarge => const EdgeInsets.symmetric(horizontal: 20),
          AppButtonSize.xxLarge => const EdgeInsets.symmetric(horizontal: 24),
        }),
      ),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
        children: [
          if (leading != null) ...[
            leading!(onTap != null ? textColor : disabledTextColor),
            SizedBox(width: AppSpacing.sm),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
            child: Text(
              label,
              style: context.typography.paragraph.copyWith(
                color: onTap != null ? textColor : disabledTextColor,
              ),
            ),
          ),
          if (trailing != null) ...[
            SizedBox(width: AppSpacing.sm),
            trailing!(onTap != null ? textColor : disabledTextColor),
          ],
        ],
      ),
    );
  }
}
