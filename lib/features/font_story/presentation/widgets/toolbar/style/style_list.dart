import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/index.dart';
import 'package:font_story/core/constants/enums/status.dart';
import 'package:font_story/core/extensions/index.dart';
import 'package:font_story/features/font_story/domain/entities/index.dart';

import '../../../cubit/font_story_cubit.dart';
import 'style_item.dart';

class StyleList extends StatelessWidget {
  const StyleList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.cardBox,
      child:
          BlocSelector<
            FontStoryCubit,
            FontStoryState,
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
                key: PageStorageKey<String>('style-list'),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: 12.horizontal,
                itemCount: styleCount,
                itemBuilder: (context, index) {
                  if (!state.hasData) return SkeletonStyleItem();
                  return StyleItem(
                    style: state.styles[index],
                    isSelected: state.selectedStyleId == state.styles[index].id,
                    onStyleSelected: (style) =>
                        context.read<FontStoryCubit>().selectStyle(style),
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
