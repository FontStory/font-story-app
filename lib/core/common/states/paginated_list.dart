import 'package:equatable/equatable.dart';

import '../../constants/enums/status.dart';

class PaginatedListState<T> extends Equatable {
  final DataStatus status;
  final List<T> data;
  final bool hasReachedMax;
  final int currentPage;
  final int total;
  final String? errorMessage;

  const PaginatedListState({
    this.status = DataStatus.initial,
    this.data = const [],
    this.hasReachedMax = false,
    this.currentPage = 1,
    this.total = 0,
    this.errorMessage,
  });

  PaginatedListState<T> copyWith({
    DataStatus? status,
    List<T>? data,
    bool? hasReachedMax,
    int? currentPage,
    int? total,
    String? errorMessage,
  }) {
    return PaginatedListState<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      total: total ?? this.total,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    data,
    hasReachedMax,
    currentPage,
    total,
    errorMessage,
  ];
}