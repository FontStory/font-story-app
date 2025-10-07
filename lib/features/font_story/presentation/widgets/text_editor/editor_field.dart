import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart'
    show BuildContextEasyLocalizationExtension, StringTranslateExtension;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/core/extensions/index.dart';
import 'package:screenshot/screenshot.dart';

import '../../cubit/box_decoration/box_decoration_cubit.dart';
import '../../cubit/color_selection/color_selection_cubit.dart';
import '../../cubit/font_selection/font_selection_cubit.dart';
import '../../cubit/highlight/highlight_cubit.dart';
import '../../cubit/style_selection/style_selection_cubit.dart';
import '../../cubit/text_formatting/text_formatting_cubit.dart';
import 'highlight_controller.dart';
import 'text_field_stack.dart';

class EditorField extends StatelessWidget {
  const EditorField({
    super.key,
    required this.screenshotController,
    required this.controller,
    required this.focusNode,
  });

  final HighlightController controller;
  final ScreenshotController screenshotController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    // Listen to style changes
    return BlocListener<StyleSelectionCubit, StyleSelectionState>(
      listenWhen: (prev, curr) => prev.selectedStyle != curr.selectedStyle,
      listener: _onStyleChangedListener,
      child: Builder(
        builder: (context) {
          // Select states directly (widget rebuilds only when relevant changes happen)
          final fontState = context.select((FontSelectionCubit c) => c.state);
          final styleState = context.select((StyleSelectionCubit c) => c.state);
          final colorState = context.select((ColorSelectionCubit c) => c.state);
          final formattingState = context.select(
            (TextFormattingCubit c) => c.state,
          );
          final highlightState = context.select((HighlightCubit c) => c.state);

          final paddingValue = formattingState.selectedFontSize * 0.85;

          return SingleChildScrollView(
            child: Screenshot(
              controller: screenshotController,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: paddingValue,
                  horizontal: 52,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: screenWidth - 104),
                  child: RepaintBoundary(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Column(
                        key: ValueKey(
                          styleState.selectedStyle?.id ?? 'default',
                        ),
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (styleState.selectedStyle?.topImage != null)
                            _buildImage(styleState.selectedStyle!.topImage!),
                          if (styleState.selectedStyle?.topImage != null ||
                              styleState.selectedStyle?.bottomImage !=
                                  null) ...{
                            _buildTextField(
                              fontState,
                              styleState,
                              colorState,
                              formattingState,
                              highlightState,
                            ),
                          } else ...{
                            IntrinsicWidth(
                              child: _buildTextField(
                                fontState,
                                styleState,
                                colorState,
                                formattingState,
                                highlightState,
                              ),
                            ),
                          },
                          if (styleState.selectedStyle?.bottomImage != null)
                            _buildImage(styleState.selectedStyle!.bottomImage!),
                        ],
                      ),
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

  Widget _buildImage(String assetPath) {
    return LayoutBuilder(
      builder: (context, constraints) => CachedNetworkImage(
        imageUrl: assetPath,
        width: constraints.maxWidth,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildTextField(
    FontSelectionState fontState,
    StyleSelectionState styleState,
    ColorSelectionState colorState,
    TextFormattingState formattingState,
    HighlightState highlightState,
  ) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final showHint = value.text.isEmpty;
        return TextFieldStack(
          fontState: fontState,
          styleState: styleState,
          colorState: colorState,
          formattingState: formattingState,
          controller: controller,
          focusNode: focusNode,
          commonDecoration: showHint
              ? InputDecoration.collapsed(
                  hintText: 'ui.type_text'.tr(),
                  hintStyle: TextStyle(color: context.palette.surface),
                  hintTextDirection: context.locale.languageCode == 'fa'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                )
              : null,
        );
      },
    );
  }

  void _onStyleChangedListener(
    BuildContext context,
    StyleSelectionState styleState,
  ) {
    final style = styleState.selectedStyle;
    if (style == null) return;

    final colorCubit = context.read<ColorSelectionCubit>();
    final boxCubit = context.read<BoxDecorationCubit>();

    // Set colors
    if (style.defaultTextColor != null) {
      colorCubit.selectColor(style.defaultTextColor!);
    }
    if (style.defaultStyleColor != null) {
      colorCubit.selectStyleColor(style.defaultStyleColor!);
    }

    // Apply all box decoration values at once
    boxCubit.resetFromDecoration(
      borderRadius: style.boxDecoration?.borderRadius as BorderRadius?,
      border: style.boxDecoration?.border as Border?,
      padding: style.boxPadding,
      shadows: style.boxDecoration?.boxShadow,
    );

    // Set background color
    if (style.boxDecoration?.color != null) {
      colorCubit.selectStyleColor(style.boxDecoration!.color!);
    }
  }
}
