part of 'style_selection_cubit.dart';

class StyleSelectionState extends Equatable {
  final PaginatedListState<TextEffectStyle> styles;
  final TextEffectStyle? selectedStyle;

  const StyleSelectionState({
    this.styles = const PaginatedListState(),
    this.selectedStyle,
  });

  StyleSelectionState copyWith({
    PaginatedListState<TextEffectStyle>? styles,
    TextEffectStyle? selectedStyle,
  }) {
    return StyleSelectionState(
      styles: styles ?? this.styles,
      selectedStyle: selectedStyle ?? this.selectedStyle,
    );
  }

  @override
  List<Object?> get props => [styles, selectedStyle];
}
