import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/core/constants/ui.dart';

import '../cubit/font_story_cubit.dart';

class SizeSlider extends StatelessWidget {
  const SizeSlider({super.key});

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
    return SizedBox(
      height: 200,
      child: RotatedBox(
        quarterTurns: -1,
        child: BlocSelector<FontStoryCubit, FontStoryState, double>(
          selector: (state) => state.selectedFontSize,
          builder: (context, currentFontSize) {
            return Slider(
              value: _fontSizeToSliderValue(currentFontSize),
              min: 0.0,
              max: 1.0,
              onChanged: (newValue) {
                final newFontSize = _sliderValueToFontSize(newValue);
                context.read<FontStoryCubit>().changeFontSize(newFontSize);
              },
            );
          },
        ),
      ),
    );
  }
}
