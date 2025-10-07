import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:font_story/core/constants/enums/status.dart';

import '../../../domain/entities/font.dart';
import '../../../domain/usecases/load_font.dart';

part 'font_loader_state.dart';

class FontLoaderCubit extends Cubit<FontLoaderState> {
  final LoadFont _loadFont;

  FontLoaderCubit(this._loadFont) : super(const FontLoaderState());

  void loadFont(FontEntity font) async {
    if (state.status == DataStatus.loading) return;

    emit(state.copyWith(status: DataStatus.loading, progress: 0));

    final result = await _loadFont.callWithProgress(
      font,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          final percent = ((received / total) * 100).floor();
          emit(state.copyWith(progress: percent));
        }
      },
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(state.copyWith(status: DataStatus.error)),
      (_) => emit(state.copyWith(status: DataStatus.success, progress: 100)),
    );
  }
}
