import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension, BuildContextEasyLocalizationExtension;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/typography.dart';
import 'package:font_story/core/constants/ui.dart';
import 'package:font_story/core/extensions/index.dart';
import 'package:font_story/features/font_story/presentation/cubit/font_story_cubit.dart';
import 'package:screenshot/screenshot.dart';

part 'text_field_stack.dart';
part 'styling_text_field.dart';
part 'editor_field_styles.dart';
part 'foreground_text_field.dart';

class EditorField extends StatelessWidget {
  const EditorField({
    super.key,
    required this.screenshotController,
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final ScreenshotController screenshotController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocListener<FontStoryCubit, FontStoryState>(
      listenWhen: (previous, current) =>
          previous.selectedStyle != current.selectedStyle,
      listener: (context, state) {
        final selectedStyle = state.selectedStyle;
        if (selectedStyle == null) return;

        // Apply default colors from the newly selected background style.
        final cubit = context.read<FontStoryCubit>();
        if (selectedStyle.defaultTextColor != null) {
          cubit.selectColor(selectedStyle.defaultTextColor!);
        }
        if (selectedStyle.defaultStyleColor != null) {
          cubit.selectStyleColor(selectedStyle.defaultStyleColor!);
        }
      },
      child: BlocSelector<FontStoryCubit, FontStoryState, dynamic>(
        selector: (state) => (
          state.selectedFont,
          state.selectedColor,
          state.selectedStyle,
          state.selectedStyleColor,
          state.selectedFontSize,
          state.isRTLDirection,
          state.textAlign,
          state.lineHeight,
          state.letterSpacing,
          state.wordSpacing,
        ),
        builder: (context, _) {
          final state = context.read<FontStoryCubit>().state;
          final double dynamicPadding = state.selectedFontSize * 0.5;

          return SingleChildScrollView(
            child: Screenshot(
              controller: screenshotController,
              child: Padding(
                padding: dynamicPadding.vertical + 52.horizontal,
                child: RepaintBoundary(
                  child: _TextFieldStack(
                    state: state,
                    controller: controller,
                    focusNode: focusNode,
                    commonDecoration: InputDecoration.collapsed(
                      hintText: 'ui.type_text'.tr(),
                      hintStyle: TextStyle(color: context.palette.surface),
                      hintTextDirection: context.locale.languageCode == 'fa'
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
