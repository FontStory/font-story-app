import 'dart:ui' show TextAlign;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:font_story/core/constants/ui.dart';

part 'text_formatting_state.dart';

class TextFormattingCubit extends Cubit<TextFormattingState> {
  TextFormattingCubit() : super(const TextFormattingState());

  void changeFontSize(double newFontSize) =>
      emit(state.copyWith(selectedFontSize: newFontSize));

  void changeLineHeight(double newLineHeight) =>
      emit(state.copyWith(lineHeight: newLineHeight));

  void changeLetterSpacing(double newLetterSpacing) =>
      emit(state.copyWith(letterSpacing: newLetterSpacing));

  void changeWordSpacing(double newWordSpacing) =>
      emit(state.copyWith(wordSpacing: newWordSpacing));

  void changeTextAlign(TextAlign newTextAlign) =>
      emit(state.copyWith(textAlign: newTextAlign));

  void toggleTextDirection() =>
      emit(state.copyWith(isRTLDirection: !state.isRTLDirection));

  void resetTextSpacing() => emit(
    state.copyWith(lineHeight: 1.0, letterSpacing: 0.0, wordSpacing: 0.0),
  );
}
