import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/typography.dart';
import 'package:font_story/core/constants/enums/color_selection.dart';
import 'package:font_story/core/constants/ui.dart';
import 'package:font_story/core/extensions/decoration_image.dart';
import 'package:font_story/core/extensions/index.dart';
import 'package:font_story/features/font_story/domain/entities/style.dart';

import '../../cubit/box_decoration/box_decoration_cubit.dart';
import '../../cubit/color_selection/color_selection_cubit.dart';
import '../../cubit/font_selection/font_selection_cubit.dart';
import '../../cubit/style_selection/style_selection_cubit.dart';
import '../../cubit/text_formatting/text_formatting_cubit.dart';
import 'highlight_controller.dart';

part 'editor_field_decoration.dart';
part 'editor_field_styles.dart';
part 'foreground_text_field.dart';
part 'styling_text_field.dart';

class TextFieldStack extends StatelessWidget {
  const TextFieldStack({
    super.key,
    required this.fontState,
    required this.styleState,
    required this.colorState,
    required this.formattingState,
    required this.controller,
    required this.focusNode,
    this.commonDecoration,
  });

  final FontSelectionState fontState;
  final StyleSelectionState styleState;
  final ColorSelectionState colorState;
  final TextFormattingState formattingState;
  final HighlightController controller;
  final FocusNode focusNode;
  final InputDecoration? commonDecoration;

  @override
  Widget build(BuildContext context) {
    final selectedStyle = styleState.selectedStyle;
    final layeredStyles = selectedStyle?.layeredTextStyles;
    final scaleFactor = formattingState.selectedFontSize / kBaseFontSize;

    return BlocBuilder<BoxDecorationCubit, BoxDecorationState>(
      buildWhen: (prev, curr) => prev != curr,
      builder: (context, decorationState) {
        final scaledDecoration =
            _EditorFieldDecoration.buildScaledBoxDecoration(
              fontState,
              styleState,
              colorState,
              formattingState,
              selectedStyle,
              decorationState,
              scaleFactor,
            );

        final padding = _EditorFieldDecoration.buildScaledPadding(
          selectedStyle,
          decorationState,
          scaleFactor,
        );

        return Container(
          padding: padding,
          decoration: scaledDecoration,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Layered background fields
              if (layeredStyles != null && layeredStyles.isNotEmpty)
                ..._buildLayeredFields(layeredStyles, scaleFactor),

              // Main styled field
              _StylingTextField(
                style: _EditorFieldStyles.buildEffectStyle(
                  fontState,
                  styleState,
                  colorState,
                  formattingState,
                ),
                fontState: fontState,
                styleState: styleState,
                colorState: colorState,
                formattingState: formattingState,
                controller: controller,
                decoration: commonDecoration,
              ),

              // Foreground editable field
              _ForegroundTextField(
                fontState: fontState,
                styleState: styleState,
                colorState: colorState,
                formattingState: formattingState,
                controller: controller,
                focusNode: focusNode,
                decoration: commonDecoration,
              ),
            ],
          ),
        );
      },
    );
  }

  /// Build all layered background fields efficiently
  List<Widget> _buildLayeredFields(
    List<TextLayerStyle> layeredStyles,
    double scaleFactor,
  ) {
    final widgets = <Widget>[];
    for (var i = 0; i < layeredStyles.length; i++) {
      final layerStyle = layeredStyles[i];
      final dx = (layerStyle.position?.dx ?? 0) * scaleFactor;
      final dy = (layerStyle.position?.dy ?? 0) * scaleFactor;

      widgets.add(
        Transform.translate(
          offset: Offset(dx, dy),
          child: _StylingTextField(
            style: _EditorFieldStyles.buildLayerStyle(
              fontState,
              styleState,
              colorState,
              formattingState,
              i,
            ),
            fontState: fontState,
            styleState: styleState,
            colorState: colorState,
            formattingState: formattingState,
            controller: controller,
            decoration: commonDecoration,
          ),
        ),
      );
    }
    return widgets;
  }
}
