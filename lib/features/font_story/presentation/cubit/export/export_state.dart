part of 'export_cubit.dart';

class ExportState extends Equatable {
  final DataStatus status;
  final String? message;

  const ExportState({this.status = DataStatus.initial, this.message});

  ExportState copyWith({
    DataStatus? status,
    String? message,
    bool clearMessage = false,
  }) {
    return ExportState(
      status: status ?? this.status,
      message: clearMessage ? null : message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
