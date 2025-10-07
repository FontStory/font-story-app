part of 'font_selection_cubit.dart';

class FontSelectionState extends Equatable {
  final PaginatedListState<FontEntity> fonts;
  final FontEntity? selectedFont;

  const FontSelectionState({
    this.fonts = const PaginatedListState(),
    this.selectedFont,
  });

  FontSelectionState copyWith({
    PaginatedListState<FontEntity>? fonts,
    FontEntity? selectedFont,
  }) {
    return FontSelectionState(
      fonts: fonts ?? this.fonts,
      selectedFont: selectedFont ?? this.selectedFont,
    );
  }

  @override
  List<Object?> get props => [fonts, selectedFont];
}
