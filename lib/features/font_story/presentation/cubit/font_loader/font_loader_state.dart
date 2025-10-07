part of 'font_loader_cubit.dart';

class FontLoaderState extends Equatable {
  final DataStatus status;
  final int progress;
  final String? errorMessage;

  const FontLoaderState({
    this.status = DataStatus.initial,
    this.progress = 0,
    this.errorMessage,
  });

  FontLoaderState copyWith({
    DataStatus? status,
    int? progress,
    String? errorMessage,
  }) {
    return FontLoaderState(
      status: status ?? this.status,
      progress: progress ?? this.progress,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, progress, errorMessage];
}
