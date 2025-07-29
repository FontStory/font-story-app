import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:font_story/core/constants/enums/status.dart';

import '../../../domain/entities/font.dart';
import '../../../domain/usecases/load_font.dart';

part 'font_loader_state.dart';

class FontLoaderCubit extends Cubit<FontLoaderState> {
  final LoadFont _loadFont;

  FontLoaderCubit(this._loadFont) : super(FontLoaderState());

  void loadFont(FontEntity font) async {
    if (state.status == DataStatus.loading) return;

    emit(state.copyWith(status: DataStatus.loading));

    final result = await _loadFont(font);

    // Check if the Cubit was closed during the await call.
    if (isClosed) return;

    result.fold(
      (failure) {
        emit(state.copyWith(status: DataStatus.error));
      },
      (data) {
        emit(state.copyWith(status: DataStatus.success));
      },
    );
  }
}
