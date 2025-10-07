import 'package:flutter/material.dart';
import 'package:font_story/config/values/index.dart'
    show AppDimensions, AppSpacing;
import 'package:font_story/core/extensions/index.dart'
    show PaddingExtension, ThemeExtension;

class SliderOption extends StatelessWidget {
  final IconData? icon;
  final String label;
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final double step;
  final bool roundValue;
  final bool smallValueText;
  final bool smallTitleText;

  const SliderOption({
    super.key,
    this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
    this.min = -10.0,
    this.max = 10.0,
    this.step = 0.5,
    this.roundValue = false,
    this.smallValueText = false,
    this.smallTitleText = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveStep = step <= 0 ? 0.1 : step;
    final divisions = ((max - min) / effectiveStep).round();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: AppSpacing.md,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    size: AppDimensions.iconSmall,
                    color: context.palette.onSurface,
                  ),
                Text(
                  label,
                  style: smallTitleText
                      ? context.typography.small.copyWith(
                          color: context.palette.onSurface,
                        )
                      : context.typography.paragraph.copyWith(
                          color: context.palette.onSurface,
                        ),
                ),
              ],
            ),
            Text(
              roundValue ? value.toStringAsFixed(0) : value.toStringAsFixed(1),
              style: smallValueText
                  ? context.typography.tiny.copyWith(
                      color: context.palette.onSurface,
                    )
                  : context.typography.small.copyWith(
                      color: context.palette.onSurface,
                    ),
            ),
          ],
        ),
        Slider(
          padding: AppSpacing.sm.top,
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
