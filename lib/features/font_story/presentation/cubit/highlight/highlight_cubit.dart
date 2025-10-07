import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show Color, Gradient;
import 'package:font_story/core/constants/enums/color_selection.dart';
import 'package:font_story/features/font_story/domain/entities/font.dart';

part 'highlight_state.dart';

class HighlightCubit extends Cubit<HighlightState> {
  HighlightCubit() : super(const HighlightState());

  void clear() => emit(const HighlightState());

  void changeFontSize(double fontSize) =>
      emit(state.copyWith(fontSize: fontSize));

  void changeFont(FontEntity font) => emit(state.copyWith(font: font));

  void changeColor(Color color) => emit(
    state.copyWith(color: color, selectionType: ColorSelectionType.color),
  );

  void changeGradient(Gradient gradient) => emit(
    state.copyWith(
      gradient: gradient,
      selectionType: ColorSelectionType.gradient,
    ),
  );
}
