import 'package:flutter/material.dart' show Widget, Color, VoidCallback;

class ExportOption {
  const ExportOption({
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
