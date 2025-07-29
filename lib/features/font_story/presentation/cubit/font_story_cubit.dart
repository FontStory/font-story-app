import 'dart:ui' show Color, TextAlign;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:font_story/config/values/palette.dart';
import 'package:font_story/core/common/localization/language.dart';
import 'package:font_story/core/common/states/paginated_list.dart';
import 'package:font_story/core/constants/enums/status.dart';
import 'package:font_story/core/constants/ui.dart';
import 'package:font_story/features/font_story/domain/entities/index.dart';

import '../../domain/usecases/get_fonts.dart';
import '../../domain/usecases/get_styles.dart';

part 'font_story_state.dart';

class FontStoryCubit extends Cubit<FontStoryState> {
  final GetFonts _fetchFonts;
  final GetStyles _fetchStyles;

  FontStoryCubit(this._fetchFonts, this._fetchStyles) : super(FontStoryState());

  void selectFont(FontEntity newFont) =>
      emit(state.copyWith(selectedFont: newFont));

  void selectColor(Color newColor) =>
      emit(state.copyWith(selectedColor: newColor));

  void changeFontSize(double newFontSize) =>
      emit(state.copyWith(selectedFontSize: newFontSize));

  void resetTextSpacing() => emit(
    state.copyWith(lineHeight: 1.0, letterSpacing: 0.0, wordSpacing: 0.0),
  );

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

  void selectStyleColor(Color newColor) =>
      emit(state.copyWith(selectedStyleColor: newColor));

  void selectStyle(TextEffectStyle newStyle) {
    if (state.selectedFont == null) return;
    emit(state.copyWith(selectedStyle: newStyle));
  }

  void getStyles() async {
    emit(
      state.copyWith(styles: state.styles.copyWith(status: DataStatus.loading)),
    );
    final result = await _fetchStyles();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            styles: state.styles.copyWith(status: DataStatus.error),
          ),
        );
      },
      (styles) {
        emit(
          state.copyWith(
            styles: state.styles.copyWith(
              status: DataStatus.success,
              data: styles,
            ),
          ),
        );
      },
    );
  }

  void getFonts({Language? language}) async {
    emit(
      state.copyWith(fonts: state.fonts.copyWith(status: DataStatus.loading)),
    );
    final result = await _fetchFonts(language);
    result.fold(
      (failure) {
        emit(
          state.copyWith(fonts: state.fonts.copyWith(status: DataStatus.error)),
        );
      },
      (fonts) {
        emit(
          state.copyWith(
            selectedFont: fonts.isNotEmpty ? fonts.first : null,
            selectedStyle: state.selectedStyle,
            fonts: state.fonts.copyWith(
              status: DataStatus.success,
              data: fonts,
            ),
          ),
        );
      },
    );
  }
}
