import 'package:flutter/material.dart';
import 'package:font_story/config/values/index.dart';
import 'package:font_story/core/extensions/index.dart';

class Expansion extends StatelessWidget {
  const Expansion({
    super.key,
    this.icon,
    this.title,
    this.customTitle,
    this.children = const [],
    this.initiallyExpanded = false,
  }) : assert(title != null || customTitle != null);

  final IconData? icon;
  final String? title;
  final Widget? customTitle;
  final List<Widget> children;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(AppRadius.md),
        color: context.palette.surface,
      ),
      child: Theme(
        data: context.theme.copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          initiallyExpanded: initiallyExpanded,
          iconColor: context.palette.onSurface,
          tilePadding: 16.horizontal,
          collapsedIconColor: context.palette.onSurface.withValues(alpha: 0.5),
          childrenPadding: 16.horizontal + 12.bottom,
          title:
              customTitle ??
              Row(
                spacing: AppSpacing.md,
                children: [
                  if (icon != null)
                    Icon(icon, color: context.palette.onSurface),
                  Text(
                    title!,
                    style: context.typography.heading6.copyWith(
                      color: context.palette.onSurface,
                    ),
                  ),
                ],
              ),
          children: children,
        ),
      ),
    );
  }
}
