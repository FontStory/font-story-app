import 'package:flutter/material.dart';
import 'package:font_story/config/values/dimensions.dart';
import 'package:font_story/config/values/radius.dart';
import 'package:font_story/core/extensions/index.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    this.icon,
    this.iconWidget,
    this.onPressed,
    required this.backgroundColor,
    required this.focusColor,
    required this.hoverColor,
    required this.disabledColor,
    required this.iconColor,
    required this.focusIconColor,
    required this.hoverIconColor,
    required this.disabledIconColor,
  }) : assert(icon != null || iconWidget != null);

  final IconData? icon;

  final Widget? iconWidget;

  final VoidCallback? onPressed;

  final Color backgroundColor;

  final Color focusColor;

  final Color hoverColor;

  final Color disabledColor;

  final Color iconColor;

  final Color focusIconColor;

  final Color hoverIconColor;

  final Color disabledIconColor;

  BorderSide? defaultBorder(BuildContext context) => null;

  BorderSide? focusedBorder(BuildContext context) => null;

  BorderSide? hoverBorder(BuildContext context) => null;

  BorderSide? disabledBorder(BuildContext context) => null;

  factory AppIconButton.tonal({
    Key? key,
    required BuildContext context,
    IconData? icon,
    Widget? iconWidget,
    required VoidCallback? onPressed,
  }) {
    final surfaceColor = context.palette.surface;
    final onSurfaceColor = context.palette.onSurface;
    return AppIconButton(
      key: key,
      icon: icon,
      iconWidget: iconWidget,
      onPressed: onPressed,
      backgroundColor: surfaceColor,
      hoverColor: onSurfaceColor.withValues(alpha: 0.12),
      focusColor: onSurfaceColor.withValues(alpha: 0.16),
      disabledColor: onSurfaceColor.withValues(alpha: 0.05),
      iconColor: onSurfaceColor,
      hoverIconColor: onSurfaceColor,
      focusIconColor: onSurfaceColor,
      disabledIconColor: onSurfaceColor.withValues(alpha: 0.38),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: iconWidget ?? Icon(icon),
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        splashFactory: NoSplash.splashFactory,
        shape: WidgetStateProperty.resolveWith((states) {
          final shape = RoundedRectangleBorder(
            borderRadius: BorderRadius.all(AppRadius.md),
          );
          if (states.contains(WidgetState.disabled)) {
            return shape.copyWith(side: disabledBorder(context));
          }
          if (states.contains(WidgetState.focused) ||
              states.contains(WidgetState.pressed)) {
            return shape.copyWith(side: focusedBorder(context));
          }
          if (states.contains(WidgetState.hovered)) {
            return shape.copyWith(side: hoverBorder(context));
          }
          return shape.copyWith(side: defaultBorder(context));
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return disabledColor;
          if (states.contains(WidgetState.hovered)) return hoverColor;
          if (states.contains(WidgetState.focused) ||
              states.contains(WidgetState.pressed)) {
            return focusColor;
          }
          return backgroundColor;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return disabledIconColor;
          if (states.contains(WidgetState.hovered)) return hoverIconColor;
          if (states.contains(WidgetState.focused) ||
              states.contains(WidgetState.pressed)) {
            return focusIconColor;
          }
          return iconColor;
        }),
        iconSize: WidgetStateProperty.all(AppDimensions.icon),
        fixedSize: WidgetStateProperty.all(
          Size.square(AppDimensions.iconButton),
        ),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
