import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/index.dart';
import 'package:font_story/core/components/buttons/icon_button.dart';
import 'package:font_story/core/extensions/index.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../cubit/font_story_cubit.dart';
import 'more_options_sheet.dart';

class SideController extends StatelessWidget {
  const SideController({super.key, required this.textEditingController});

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.md,
      children: [
        BlocSelector<FontStoryCubit, FontStoryState, TextAlign>(
          selector: (state) => state.textAlign,
          builder: (context, textAlignState) {
            final newTextAlign = _getNewTextAlign(textAlignState);
            final textAlignIcon = _getTextAlignIcon(textAlignState);
            return AppIconButton.tonal(
              context: context,
              icon: textAlignIcon,
              onPressed: () =>
                  context.read<FontStoryCubit>().changeTextAlign(newTextAlign),
            );
          },
        ),
        BlocSelector<FontStoryCubit, FontStoryState, bool>(
          selector: (state) => state.isRTLDirection,
          builder: (context, isRTL) {
            final textDirectionIcon = _getTextDirectionIcon(isRTL);
            return AppIconButton.tonal(
              context: context,
              icon: textDirectionIcon,
              onPressed: () =>
                  context.read<FontStoryCubit>().toggleTextDirection(),
            );
          },
        ),
        AppIconButton.tonal(
          context: context,
          icon: Iconsax.trash_copy,
          onPressed: () {
            textEditingController.clear();
          },
        ),
        AppIconButton.tonal(
          context: context,
          icon: Icons.more_horiz_rounded,
          onPressed: () {
            context.showCustomBottomSheet(
              content: BlocProvider.value(
                value: context.read<FontStoryCubit>(),
                child: MoreOptionsSheet(),
              ),
            );
          },
        ),
      ],
    );
  }

  TextAlign _getNewTextAlign(TextAlign currentAlign) {
    switch (currentAlign) {
      case TextAlign.center:
        return TextAlign.left;
      case TextAlign.left:
        return TextAlign.right;
      default:
        return TextAlign.center;
    }
  }

  IconData _getTextAlignIcon(TextAlign align) {
    switch (align) {
      case TextAlign.center:
        return Iconsax.textalign_center;
      case TextAlign.left:
        return Iconsax.textalign_left;
      default:
        return Iconsax.textalign_right;
    }
  }

  IconData _getTextDirectionIcon(bool isRTL) =>
      isRTL ? Iconsax.textalign_justifyright : Iconsax.textalign_justifyleft;
}
