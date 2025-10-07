import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/index.dart';
import 'package:font_story/core/extensions/index.dart';
import 'package:font_story/features/font_story/presentation/cubit/style_selection/style_selection_cubit.dart';

import 'border.dart';
import 'padding.dart';
import 'radius.dart';
import 'shadow.dart';
import 'text.dart';

class OptionsSheet extends StatelessWidget {
  const OptionsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.xl.horizontal,
      child:
          BlocSelector<
            StyleSelectionCubit,
            StyleSelectionState,
            ({
              bool canChangeDecoration,
              bool hasBorder,
              bool hasBorderRadius,
              bool hasPadding,
              bool hasShadow,
            })
          >(
            selector: (state) {
              final boxDecoration = state.selectedStyle?.boxDecoration;
              final boxPadding = state.selectedStyle?.boxPadding;
              return (
                canChangeDecoration:
                    state.selectedStyle?.canChangeDecoration ?? false,
                hasBorder: boxDecoration?.border != null,
                hasBorderRadius: boxDecoration?.borderRadius != null,
                hasPadding: boxPadding != null,
                hasShadow: boxDecoration?.boxShadow?.isNotEmpty != null,
              );
            },
            builder: (context, conditions) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                spacing: AppSpacing.xl,
                children: [
                  const TextSpacingOptions(),
                  if (conditions.canChangeDecoration) ...{
                    if (conditions.hasBorder) const BorderWidthOptions(),
                    if (conditions.hasBorderRadius) const BorderRadiusOptions(),
                    if (conditions.hasPadding) const PaddingOptions(),
                    if (conditions.hasShadow) const ShadowOptions(),
                  },
                  AppSpacing.xxxl.verticalSpace,
                ],
              );
            },
          ),
    );
  }
}
