import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/radius.dart';
import 'package:font_story/config/values/spacing.dart';
import 'package:font_story/core/extensions/index.dart';

import '../../cubit/text_formatting/text_formatting_cubit.dart';
import 'slider.dart';

class TextSpacingOptions extends StatelessWidget {
  const TextSpacingOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 16.horizontal + 12.vertical,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(AppRadius.md),
        color: context.palette.surface,
      ),
      child: Column(
        spacing: AppSpacing.lg,
        children: [
          BlocSelector<TextFormattingCubit, TextFormattingState, double>(
            selector: (state) => state.lineHeight,
            builder: (context, value) => SliderOption(
              label: 'ui.line_height'.tr(),
              value: value,
              min: 0.8,
              max: 3.0,
              step: 0.2,
              onChanged: (v) =>
                  context.read<TextFormattingCubit>().changeLineHeight(v),
            ),
          ),
          BlocSelector<TextFormattingCubit, TextFormattingState, double>(
            selector: (state) => state.wordSpacing,
            builder: (context, value) => SliderOption(
              label: 'ui.word_spacing'.tr(),
              value: value,
              onChanged: (v) =>
                  context.read<TextFormattingCubit>().changeWordSpacing(v),
            ),
          ),
          BlocSelector<TextFormattingCubit, TextFormattingState, double>(
            selector: (state) => state.letterSpacing,
            builder: (context, value) => SliderOption(
              label: 'ui.letter_spacing'.tr(),
              value: value,
              min: -2.0,
              max: 10.0,
              step: 1.0,
              onChanged: (v) =>
                  context.read<TextFormattingCubit>().changeLetterSpacing(v),
            ),
          ),
        ],
      ),
    );
  }
}
