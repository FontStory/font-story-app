part of 'editor_controller_cubit.dart';

class EditorControllerState extends Equatable {
  final bool isInitializing;
  final bool hasUnsavedChanges;
  final String? errorMessage;

  const EditorControllerState({
    this.isInitializing = false,
    this.hasUnsavedChanges = false,
    this.errorMessage,
  });

  EditorControllerState copyWith({
    bool? isInitializing,
    bool? hasUnsavedChanges,
    String? errorMessage,
  }) {
    return EditorControllerState(
      isInitializing: isInitializing ?? this.isInitializing,
      hasUnsavedChanges: hasUnsavedChanges ?? this.hasUnsavedChanges,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isInitializing, hasUnsavedChanges, errorMessage];
}
