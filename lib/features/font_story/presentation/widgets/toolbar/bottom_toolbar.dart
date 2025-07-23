import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/index.dart' show AppDimensions;
import 'package:font_story/core/extensions/index.dart' show SpacingExtension;
import 'package:font_story/features/font_story/presentation/cubit/font_story_cubit.dart';

import 'bottom_toolbar_tab.dart';
import 'color/color_list.dart';
import 'font/font_list.dart';
import 'style/style_list.dart';

class BottomToolbar extends StatelessWidget {
  const BottomToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FontStoryCubit, FontStoryState, bool>(
      selector: (state) => state.selectedStyle?.canChangeColor ?? false,
      builder: (context, isColorMutable) {
        return DefaultTabController(
          length: isColorMutable ? 4 : 3,
          initialIndex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              10.verticalSpace,
              SizedBox(
                height: AppDimensions.cardBox,
                child: RepaintBoundary(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      StyleList(),
                      FontList(),
                      ColorList(
                        pageStorageKey: 'color',
                        getSelectedColor: (state) => state.selectedColor,
                        onColorChanged: (cubit, color) =>
                            cubit.selectColor(color),
                      ),
                      if (isColorMutable)
                        ColorList(
                          pageStorageKey: 'style-color',
                          getSelectedColor: (state) => state.selectedStyleColor,
                          onColorChanged: (cubit, color) =>
                              cubit.selectStyleColor(color),
                        ),
                    ],
                  ),
                ),
              ),
              20.verticalSpace,
              BottomToolbarTab(isColorMutable: isColorMutable),
            ],
          ),
        );
      },
    );
  }
}
