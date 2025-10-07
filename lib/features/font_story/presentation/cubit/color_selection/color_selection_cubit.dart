import 'dart:ui' show Color;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show Gradient, LinearGradient;
import 'package:font_story/config/values/palette.dart';
import 'package:font_story/core/constants/enums/color_selection.dart';

part 'color_selection_state.dart';

class ColorSelectionCubit extends Cubit<ColorSelectionState> {
  ColorSelectionCubit() : super(const ColorSelectionState());

  void selectColor(Color newColor) {
    emit(
      state.copyWith(
        selectedColor: newColor,
        colorSelectionType: ColorSelectionType.color,
      ),
    );
  }

  void selectGradient(Gradient newGradient) {
    emit(
      state.copyWith(
        selectedGradient: newGradient,
        colorSelectionType: ColorSelectionType.gradient,
      ),
    );
  }

  void selectStyleColor(Color? newColor) {
    emit(
      state.copyWith(
        selectedStyleColor: newColor,
        styleColorSelectionType: ColorSelectionType.color,
      ),
    );
  }

  void selectStyleGradient(Gradient newGradient) {
    emit(
      state.copyWith(
        selectedStyleGradient: newGradient,
        styleColorSelectionType: ColorSelectionType.gradient,
      ),
    );
  }
}
