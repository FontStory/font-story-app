import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/dimensions.dart';
import 'package:font_story/config/values/index.dart';
import 'package:font_story/core/constants/enums/status.dart';
import 'package:font_story/core/extensions/index.dart';

import '../../../../domain/entities/font.dart';
import '../../../cubit/font_story_cubit.dart';
import 'font_item.dart';

class FontList extends StatelessWidget {
  const FontList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.cardBox,
      child:
          BlocSelector<
            FontStoryCubit,
            FontStoryState,
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
              final fontCount = state.hasData ? state.fonts.length : 20;
              return ListView.separated(
                key: PageStorageKey<String>('font-list'),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: 12.horizontal,
                itemCount: fontCount,
                itemBuilder: (context, index) {
                  if (!state.hasData) return SkeletonFontItem();
                  return FontItem(
                    font: state.fonts[index],
                    isSelected: state.selectedFontId == state.fonts[index].id,
                    onFontSelected: (font) =>
                        context.read<FontStoryCubit>().selectFont(font),
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
