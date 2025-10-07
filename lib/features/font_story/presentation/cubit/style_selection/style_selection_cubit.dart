import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:font_story/core/common/states/paginated_list.dart';
import 'package:font_story/core/constants/enums/status.dart';

import '../../../domain/entities/style.dart';
import '../../../domain/usecases/get_styles.dart';

part 'style_selection_state.dart';

class StyleSelectionCubit extends Cubit<StyleSelectionState> {
  final GetStyles _fetchStyles;

  StyleSelectionCubit(this._fetchStyles) : super(const StyleSelectionState());

  void selectStyle(TextEffectStyle newStyle) {
    emit(state.copyWith(selectedStyle: newStyle));
  }

  void getStyles() async {
    emit(
      state.copyWith(styles: state.styles.copyWith(status: DataStatus.loading)),
    );
    final result = await _fetchStyles.call();
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
}
