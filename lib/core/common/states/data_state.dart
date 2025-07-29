import 'package:equatable/equatable.dart';

import '../../constants/enums/status.dart';

class DataState<T> extends Equatable {
  final DataStatus status;
  final T? data;
  final String? errorMessage;

  const DataState({
    this.status = DataStatus.initial,
    this.data,
    this.errorMessage,
  });

  DataState<T> copyWith({DataStatus? status, T? data, String? errorMessage}) {
    return DataState<T>(
      status: status ?? this.status,
      data: data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
