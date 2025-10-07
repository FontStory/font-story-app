import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/index.dart';
import 'package:font_story/core/constants/enums/status.dart';
import 'package:font_story/core/extensions/index.dart';
import 'package:font_story/features/font_story/presentation/cubit/font_selection/font_selection_cubit.dart';
import 'package:font_story/features/font_story/presentation/cubit/highlight/highlight_cubit.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../../domain/entities/font.dart';
import 'font_item.dart';

class FontList extends StatefulWidget {
  const FontList({super.key, this.hasHighlight = false});

  final bool hasHighlight;

  @override
  State<FontList> createState() => _FontListState();
}

class _FontListState extends State<FontList> {
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
            FontSelectionCubit,
            FontSelectionState,
            ({
              List<FontEntity> fonts,
              int? selectedFontId,
              bool isLoading,
              bool hasData,
            })
          >(
            selector: (state) => (
              fonts: state.fonts.data,
              selectedFontId: state.selectedFont?.id,
              isLoading:
                  (state.fonts.status == DataStatus.loading ||
                  state.fonts.status == DataStatus.initial),
              hasData: state.fonts.data.isNotEmpty,
            ),
            builder: (context, state) {
              // If highlight mode → listen separately to HighlightCubit
              final highlightFontId = widget.hasHighlight
                  ? context.select((HighlightCubit c) => c.state.font?.id)
                  : null;

              final selectedFontId = widget.hasHighlight
                  ? highlightFontId
                  : state.selectedFontId;

              final fontCount = state.fonts.isNotEmpty
                  ? state.fonts.length
                  : 20;

              return ListView.separated(
                key: const PageStorageKey<String>('font-list'),
                controller: _controller,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: 12.horizontal,
                itemCount: fontCount,
                itemBuilder: (context, index) {
                  if (state.fonts.isEmpty) return const SkeletonFontItem();

                  final font = state.fonts[index];
                  return AutoScrollTag(
                    key: ValueKey(font.id),
                    controller: _controller,
                    index: index,
                    child: FontItem(
                      font: font,
                      isSelected: font.id == selectedFontId,
                      onFontSelected: (selected) {
                        if (widget.hasHighlight) {
                          context.read<HighlightCubit>().changeFont(selected);
                        } else {
                          context.read<FontSelectionCubit>().selectFont(
                            selected,
                          );
                        }

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
