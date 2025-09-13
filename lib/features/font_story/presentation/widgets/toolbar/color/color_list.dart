import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/index.dart'
    show AppDimensions, AppSpacing;
import 'package:font_story/core/constants/ui.dart';
import 'package:font_story/core/extensions/index.dart'
    show PaddingExtension, SpacingExtension;

import '../../../cubit/font_story_cubit.dart';
import 'color_item.dart';
import 'color_picker_item.dart';
import '../gradient/gradient_item.dart';

class ColorList extends StatelessWidget {
  const ColorList({
    super.key,
    required this.pageStorageKey,
    required this.getSelectedValue,
    required this.onColorChanged,
    required this.onGradientChanged,
  });

  final String pageStorageKey;
  final (ColorSelectionType, Color, Gradient) Function(FontStoryState state)
  getSelectedValue;
  final Function(FontStoryCubit cubit, Color color) onColorChanged;
  final Function(FontStoryCubit cubit, Gradient gradient) onGradientChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.colorBox,
      child:
          BlocSelector<
            FontStoryCubit,
            FontStoryState,
            (ColorSelectionType, Color, Gradient)
          >(
            selector: getSelectedValue,
            builder: (context, selected) {
              final (selectionType, selectedColor, selectedGradient) = selected;

              return ListView.separated(
                key: PageStorageKey(pageStorageKey),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: 12.horizontal,
                itemCount: colorAndGradientList.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return ColorPickerItem(
                      defaultColor: selectedColor,
                      onColorChanged: (color) =>
                          onColorChanged(context.read<FontStoryCubit>(), color),
                    );
                  }

                  final item = colorAndGradientList[index - 1];

                  if (item is Color) {
                    return ColorItem(
                      color: item,
                      isSelected:
                          selectionType == ColorSelectionType.color &&
                          selectedColor == item,
                      onColorSelected: (color) =>
                          onColorChanged(context.read<FontStoryCubit>(), color),
                    );
                  } else if (item is Gradient) {
                    return GradientItem(
                      gradient: item,
                      isSelected:
                          selectionType == ColorSelectionType.gradient &&
                          selectedGradient == item,
                      onGradientSelected: (gradient) => onGradientChanged(
                        context.read<FontStoryCubit>(),
                        gradient,
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
                separatorBuilder: (context, index) =>
                    AppSpacing.md.horizontalSpace,
              );
            },
          ),
    );
  }
}
