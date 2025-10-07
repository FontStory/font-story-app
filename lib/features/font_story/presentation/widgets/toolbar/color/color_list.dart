import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/index.dart'
    show AppDimensions, AppSpacing;
import 'package:font_story/core/constants/enums/color_selection.dart';
import 'package:font_story/core/constants/ui.dart';
import 'package:font_story/core/extensions/index.dart'
    show PaddingExtension, SpacingExtension;
import 'package:font_story/features/font_story/presentation/cubit/color_selection/color_selection_cubit.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../cubit/highlight/highlight_cubit.dart';
import '../gradient/gradient_item.dart';
import 'color_item.dart';
import 'color_picker_item.dart';

class ColorList extends StatefulWidget {
  const ColorList({
    super.key,
    required this.pageStorageKey,
    required this.getSelectedValue,
    required this.onColorChanged,
    required this.onGradientChanged,
    this.hasHighlight = false,
  });

  final String pageStorageKey;
  final ({ColorSelectionType type, Color color, Gradient gradient}) Function(
    ColorSelectionState state,
  )
  getSelectedValue;
  final Function(ColorSelectionCubit cubit, Color color) onColorChanged;
  final Function(ColorSelectionCubit cubit, Gradient gradient)
  onGradientChanged;
  final bool hasHighlight;

  @override
  State<ColorList> createState() => _ColorListState();
}

class _ColorListState extends State<ColorList> {
  late AutoScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AutoScrollController(axis: Axis.horizontal);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.colorBox,
      child:
          BlocSelector<
            ColorSelectionCubit,
            ColorSelectionState,
            ({ColorSelectionType type, Color color, Gradient gradient})
          >(
            selector: widget.getSelectedValue,
            builder: (context, state) {
              final highlightState = widget.hasHighlight
                  ? context.select(
                      (HighlightCubit c) => (
                        type: c.state.selectionType,
                        color: c.state.color,
                        gradient: c.state.gradient,
                      ),
                    )
                  : null;

              final selectionType = widget.hasHighlight
                  ? highlightState!.type
                  : state.type;
              final selectedColor = widget.hasHighlight
                  ? highlightState!.color
                  : state.color;
              final selectedGradient = widget.hasHighlight
                  ? highlightState!.gradient
                  : state.gradient;

              return ListView.separated(
                key: PageStorageKey(widget.pageStorageKey),
                controller: _controller,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: 12.horizontal,
                itemCount: colorAndGradientList.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return ColorPickerItem(
                      defaultColor: selectedColor ?? Colors.white,
                      onColorChanged: (color) => widget.onColorChanged(
                        context.read<ColorSelectionCubit>(),
                        color,
                      ),
                    );
                  }

                  final itemIndex = index - 1;
                  final item = colorAndGradientList[itemIndex];

                  return AutoScrollTag(
                    key: ValueKey(itemIndex),
                    controller: _controller,
                    index: index,
                    child: item is Color
                        ? ColorItem(
                            color: item,
                            isSelected:
                                selectionType == ColorSelectionType.color &&
                                selectedColor == item,
                            onColorSelected: (color) {
                              widget.onColorChanged(
                                context.read<ColorSelectionCubit>(),
                                color,
                              );
                              _controller.scrollToIndex(
                                index,
                                preferPosition: AutoScrollPosition.middle,
                              );
                            },
                          )
                        : GradientItem(
                            gradient: item as Gradient,
                            isSelected:
                                selectionType == ColorSelectionType.gradient &&
                                selectedGradient == item,
                            onGradientSelected: (gradient) {
                              widget.onGradientChanged(
                                context.read<ColorSelectionCubit>(),
                                gradient,
                              );
                              _controller.scrollToIndex(
                                index,
                                preferPosition: AutoScrollPosition.middle,
                              );
                            },
                          ),
                  );
                },
                separatorBuilder: (context, index) =>
                    AppSpacing.md.horizontalSpace,
              );
            },
          ),
    );
  }
}
