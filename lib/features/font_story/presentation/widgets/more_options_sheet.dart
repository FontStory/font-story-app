import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/index.dart';
import 'package:font_story/core/components/buttons/button.dart';
import 'package:font_story/core/extensions/index.dart';

import '../cubit/font_story_cubit.dart';

class MoreOptionsSheet extends StatelessWidget {
  const MoreOptionsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.xl.horizontal,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.xxxl,
        children: [
          // Line Height
          BlocSelector<FontStoryCubit, FontStoryState, double>(
            selector: (state) => state.lineHeight,
            builder: (context, lineHeight) {
              return _buildSlider(
                context: context,
                label: 'ui.line_height'.tr(),
                min: 0.8,
                max: 3.0,
                step: 0.2,
                value: lineHeight,
                onChanged: (value) =>
                    context.read<FontStoryCubit>().changeLineHeight(value),
              );
            },
          ),

          // Word Spacing
          BlocSelector<FontStoryCubit, FontStoryState, double>(
            selector: (state) => state.wordSpacing,
            builder: (context, wordSpacing) {
              return _buildSlider(
                context: context,
                label: 'ui.word_spacing'.tr(),
                value: wordSpacing,
                onChanged: (value) =>
                    context.read<FontStoryCubit>().changeWordSpacing(value),
              );
            },
          ),

          // Letter Spacing
          BlocSelector<FontStoryCubit, FontStoryState, double>(
            selector: (state) => state.letterSpacing,
            builder: (context, letterSpacing) {
              return _buildSlider(
                context: context,
                label: 'ui.letter_spacing'.tr(),
                value: letterSpacing,
                onChanged: (value) =>
                    context.read<FontStoryCubit>().changeLetterSpacing(value),
              );
            },
          ),
          SizedBox.shrink(),
          AppButton.secondary(
            context: context,
            isExpanded: true,
            appButtonSize: AppButtonSize.xlarge,
            label: 'ui.reset_spacing'.tr(),
            onTap: () => context.read<FontStoryCubit>().resetTextSpacing(),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider({
    required BuildContext context,
    required String label,
    required double value,
    double min = -10.0,
    double max = 10.0,
    double step = 0.5,
    required ValueChanged<double> onChanged,
  }) {
    // Ensure the step is not zero to avoid division by zero errors.
    final double effectiveStep = (step <= 0) ? 0.1 : step;

    // Calculate the number of divisions based on the range and the desired step.
    final int divisions = ((max - min) / effectiveStep).round();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              label,
              style: context.typography.heading6.copyWith(
                color: context.palette.onSurface,
              ),
            ),
            Text(
              value.toStringAsFixed(1),
              style: context.typography.paragraph.copyWith(
                color: context.palette.onSurface,
              ),
            ),
          ],
        ),
        Slider(
          padding: AppSpacing.lg.top,
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
