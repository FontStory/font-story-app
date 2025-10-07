import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/spacing.dart';
import 'package:font_story/core/constants/ui.dart';
import 'package:font_story/core/extensions/index.dart';

import '../cubit/highlight/highlight_cubit.dart';
import '../cubit/text_formatting/text_formatting_cubit.dart';

class SizeSlider extends StatelessWidget {
  const SizeSlider({super.key, this.hasHighlight = false});

  final bool hasHighlight;

  /// Converts a font size value to a normalized slider value between 0.0 and 1.0.
  double _fontSizeToSliderValue(double fontSize) {
    final clampedSize = fontSize.clamp(minFontSize, maxFontSize);
    return (clampedSize - minFontSize) / (maxFontSize - minFontSize);
  }

  /// Converts a normalized slider value (0.0 to 1.0) back to a font size.
  double _sliderValueToFontSize(double sliderValue) {
    return (sliderValue * (maxFontSize - minFontSize)) + minFontSize;
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TextFormattingCubit, TextFormattingState, double>(
      selector: (state) => state.selectedFontSize,
      builder: (context, currentFontSize) {
        final highlightFontSize = context.select(
          (HighlightCubit c) => c.state.fontSize,
        ) ?? currentFontSize;

        final fontSize = hasHighlight ? highlightFontSize : currentFontSize;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              fontSize.toInt().toString(),
              style: context.typography.paragraph.copyWith(
                color: context.palette.onSurface,
              ),
            ),
            AppSpacing.xl.verticalSpace,
            SizedBox(
              height: 142,
              child: RotatedBox(
                quarterTurns: -1,
                child: Slider(
                  value: _fontSizeToSliderValue(fontSize),
                  min: 0.0,
                  max: 1.0,
                  padding: EdgeInsets.zero,
                  onChanged: (newValue) {
                    final newFontSize = _sliderValueToFontSize(newValue);
                    if (hasHighlight) {
                      context.read<HighlightCubit>().changeFontSize(
                        newFontSize,
                      );
                    } else {
                      context.read<TextFormattingCubit>().changeFontSize(
                        newFontSize,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
