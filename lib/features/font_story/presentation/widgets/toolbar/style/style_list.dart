import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/index.dart';
import 'package:font_story/core/constants/enums/status.dart';
import 'package:font_story/core/extensions/index.dart';
import 'package:font_story/features/font_story/presentation/cubit/editor_controller/editor_controller_cubit.dart';
import 'package:font_story/features/font_story/presentation/cubit/style_selection/style_selection_cubit.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../../domain/entities/style.dart';
import 'style_item.dart';

class StyleList extends StatefulWidget {
  const StyleList({super.key});

  @override
  State<StyleList> createState() => _StyleListState();
}

class _StyleListState extends State<StyleList> {
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
      height: AppDimensions.cardBox,
      child:
          BlocSelector<
            StyleSelectionCubit,
            StyleSelectionState,
            ({
              List<TextEffectStyle> styles,
              int? selectedStyleId,
              bool isLoading,
              bool hasData,
            })
          >(
            selector: (state) => (
              styles: state.styles.data,
              selectedStyleId: state.selectedStyle?.id,
              isLoading:
                  (state.styles.status == DataStatus.loading ||
                  state.styles.status == DataStatus.initial),
              hasData: state.styles.data.isNotEmpty,
            ),
            builder: (context, state) {
              final styleCount = state.hasData ? state.styles.length : 20;
              return ListView.separated(
                key: const PageStorageKey<String>('style-list'),
                controller: _controller,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: 12.horizontal,
                itemCount: styleCount,
                itemBuilder: (context, index) {
                  if (!state.hasData) return const SkeletonStyleItem();
                  return AutoScrollTag(
                    key: ValueKey(index),
                    controller: _controller,
                    index: index,
                    child: StyleItem(
                      style: state.styles[index],
                      isSelected:
                          state.selectedStyleId == state.styles[index].id,
                      onStyleSelected: (style) {
                        // Use the coordinator cubit for complex operations
                        context
                            .read<EditorControllerCubit>()
                            .selectStyleWithEffects(style);
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
              ).asShimmer(context, state.isLoading);
            },
          ),
    );
  }
}
