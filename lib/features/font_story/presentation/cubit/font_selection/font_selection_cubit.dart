import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:font_story/core/common/localization/language.dart';
import 'package:font_story/core/common/states/paginated_list.dart';
import 'package:font_story/core/constants/enums/status.dart';

import '../../../domain/entities/font.dart';
import '../../../domain/usecases/get_fonts.dart';

part 'font_selection_state.dart';

class FontSelectionCubit extends Cubit<FontSelectionState> {
  final GetFonts _fetchFonts;

  FontSelectionCubit(this._fetchFonts) : super(const FontSelectionState());

  void selectFont(FontEntity newFont) =>
      emit(state.copyWith(selectedFont: newFont));

  void getFonts({Language? language}) async {
    emit(
      state.copyWith(fonts: state.fonts.copyWith(status: DataStatus.loading)),
    );
    final result = await _fetchFonts.call(language);
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
