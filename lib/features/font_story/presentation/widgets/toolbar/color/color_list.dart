import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/index.dart'
    show AppDimensions, AppPalette, AppSpacing;
import 'package:font_story/core/extensions/index.dart'
    show PaddingExtension, SpacingExtension;

import '../../../cubit/font_story_cubit.dart';
import 'color_item.dart';
import 'color_picker_item.dart';

class ColorList extends StatelessWidget {
  const ColorList({
    super.key,
    required this.pageStorageKey,
    required this.getSelectedColor,
    required this.onColorChanged,
  });

  final String pageStorageKey;
  final Function(FontStoryState state) getSelectedColor;
  final Function(FontStoryCubit cubit, Color color) onColorChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.colorBox,
      child: BlocSelector<FontStoryCubit, FontStoryState, Color>(
        selector: (state) => getSelectedColor(state),
        builder: (context, selectedColor) {
          return ListView.separated(
            key: PageStorageKey<String>(pageStorageKey),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: 12.horizontal,
            itemCount: AppPalette.colorList.length + 1,
            itemBuilder: (context, index) => index == 0
                ? ColorPickerItem(
                    defaultColor: selectedColor,
                    onColorChanged: (color) =>
                        context.read<FontStoryCubit>().selectColor(color),
                  )
                : ColorItem(
                    color: AppPalette.colorList[index - 1],
                    // isSelected:
                    //     selectedColor == AppPalette.colorList[index - 1],
                    // onColorSelected: (color) =>
                    //     context.read<FontStoryCubit>().selectColor(color),
                    isSelected:
                        selectedColor == AppPalette.colorList[index - 1],
                    onColorSelected: (newColor) => onColorChanged(
                      context.read<FontStoryCubit>(),
                      newColor,
                    ),
                  ),
            separatorBuilder: (context, index) => AppSpacing.md.horizontalSpace,
          );
        },
      ),
    );
  }
}
