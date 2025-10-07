import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:font_story/core/common/localization/language.dart';
import 'package:font_story/features/font_story/domain/entities/style.dart';

import '../box_decoration/box_decoration_cubit.dart';
import '../color_selection/color_selection_cubit.dart';
import '../font_selection/font_selection_cubit.dart';
import '../style_selection/style_selection_cubit.dart';
import '../text_formatting/text_formatting_cubit.dart';

part 'editor_controller_state.dart';

/// Coordinator cubit that manages interactions between different cubits
/// and provides a unified interface for complex operations
class EditorControllerCubit extends Cubit<EditorControllerState> {
  final FontSelectionCubit _fontSelectionCubit;
  final StyleSelectionCubit _styleSelectionCubit;
  final ColorSelectionCubit _colorSelectionCubit;
  final TextFormattingCubit _textFormattingCubit;
  final BoxDecorationCubit _boxDecorationCubit;

  EditorControllerCubit({
    required FontSelectionCubit fontSelectionCubit,
    required StyleSelectionCubit styleSelectionCubit,
    required ColorSelectionCubit colorSelectionCubit,
    required TextFormattingCubit textFormattingCubit,
    required BoxDecorationCubit boxDecorationCubit,
  }) : _fontSelectionCubit = fontSelectionCubit,
       _styleSelectionCubit = styleSelectionCubit,
       _colorSelectionCubit = colorSelectionCubit,
       _textFormattingCubit = textFormattingCubit,
       _boxDecorationCubit = boxDecorationCubit,
       super(const EditorControllerState());

  /// Initialize the editor with default data
  void initializeEditor({Language? language}) {
    emit(state.copyWith(isInitializing: true));

    _fontSelectionCubit.getFonts(language: language);
    _styleSelectionCubit.getStyles();

    emit(state.copyWith(isInitializing: false));
  }

  /// Handle style selection with side effects
  void selectStyleWithEffects(TextEffectStyle style) {
    _styleSelectionCubit.selectStyle(style);

    // Apply style-specific effects
    if (style.defaultTextColor != null) {
      _colorSelectionCubit.selectColor(style.defaultTextColor!);
    }
    if (style.defaultStyleColor != null) {
      _colorSelectionCubit.selectStyleColor(style.defaultStyleColor!);
    }

    // Update box decoration based on style
    _boxDecorationCubit.setDefaultPadding(style.boxPadding);

    final decoration = style.boxDecoration;
    if (decoration != null) {
      _boxDecorationCubit
        ..setDefaultBorder(decoration.border as Border?)
        ..setDefaultBorderRadius(decoration.borderRadius as BorderRadius?)
        ..setDefaultShadow(decoration.boxShadow);

      if (decoration.color != null) {
        _colorSelectionCubit.selectStyleColor(decoration.color!);
      }
    }
  }

  /// Reset all settings to default
  void resetToDefaults() {
    _textFormattingCubit.resetTextSpacing();
    // _boxDecorationCubit.resetToDefaults();
    // Add more reset operations as needed

    emit(state.copyWith(hasUnsavedChanges: false));
  }

  /// Mark that changes have been made
  void markAsChanged() {
    if (!state.hasUnsavedChanges) {
      emit(state.copyWith(hasUnsavedChanges: true));
    }
  }

  /// Mark changes as saved
  void markAsSaved() {
    emit(state.copyWith(hasUnsavedChanges: false));
  }
}
