import 'package:flutter/material.dart';
import 'package:font_story/config/values/index.dart';
import 'package:font_story/core/extensions/index.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({super.key, required this.text, this.icon});

  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.xl,
      children: [
        Icon(icon, size: AppDimensions.iconLarge, color: context.palette.onSurface),
        Text(
          text,
          style: context.typography.heading6.copyWith(
            color: context.palette.onSurface,
            decoration: TextDecoration.none,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
