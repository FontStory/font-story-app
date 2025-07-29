part of 'font_loader_cubit.dart';

class FontLoaderState extends Equatable {
  final DataStatus status;
  final String? errorMessage;

  const FontLoaderState({this.status = DataStatus.initial, this.errorMessage});

  FontLoaderState copyWith({DataStatus? status, String? errorMessage}) {
    return FontLoaderState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
