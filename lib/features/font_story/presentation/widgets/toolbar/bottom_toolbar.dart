import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/index.dart' show AppDimensions;
import 'package:font_story/core/extensions/index.dart' show SpacingExtension;
import 'package:font_story/features/font_story/presentation/cubit/style_selection/style_selection_cubit.dart';

import '../../cubit/highlight/highlight_cubit.dart';
import 'bottom_toolbar_tab.dart';
import 'color/color_list.dart';
import 'font/font_list.dart';
import 'style/style_list.dart';

class BottomToolbar extends StatelessWidget {
  const BottomToolbar({super.key, this.hasHighlight = false});

  final bool hasHighlight;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<StyleSelectionCubit, StyleSelectionState, bool>(
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
                      const StyleList(),
                      FontList(hasHighlight: hasHighlight),
                      ColorList(
                        pageStorageKey: 'color',
                        hasHighlight: hasHighlight,
                        getSelectedValue: (state) => (
                          type: state.colorSelectionType,
                          color: state.selectedColor,
                          gradient: state.selectedGradient,
                        ),
                        onColorChanged: (cubit, color) => hasHighlight
                            ? context.read<HighlightCubit>().changeColor(color)
                            : cubit.selectColor(color),
                        onGradientChanged: (cubit, gradient) => hasHighlight
                            ? context.read<HighlightCubit>().changeGradient(
                                gradient,
                              )
                            : cubit.selectGradient(gradient),
                      ),
                      if (isColorMutable)
                        ColorList(
                          pageStorageKey: 'style-color',
                          hasHighlight: hasHighlight,
                          getSelectedValue: (state) => (
                            type: state.styleColorSelectionType,
                            color: state.selectedStyleColor,
                            gradient: state.selectedStyleGradient,
                          ),
                          onColorChanged: (cubit, color) =>
                              cubit.selectStyleColor(color),
                          onGradientChanged: (cubit, gradient) =>
                              cubit.selectStyleGradient(gradient),
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
