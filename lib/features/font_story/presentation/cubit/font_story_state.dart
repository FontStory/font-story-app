part of 'font_story_cubit.dart';

class FontStoryState extends Equatable {
  final PaginatedListState<FontEntity> fonts;
  final PaginatedListState<TextEffectStyle> styles;

  final double lineHeight;
  final double letterSpacing;
  final double wordSpacing;
  final bool isRTLDirection;
  final TextAlign textAlign;

  // Selection
  final FontEntity? selectedFont;
  final TextEffectStyle? selectedStyle;
  final Color selectedColor;
  final double selectedFontSize;
  final Color selectedStyleColor;

  const FontStoryState({
    this.fonts = const PaginatedListState(),
    this.styles = const PaginatedListState(),
    this.lineHeight = 1.0,
    this.letterSpacing = 0.0,
    this.wordSpacing = 0.0,
    this.isRTLDirection = false,
    this.textAlign = TextAlign.center,
    this.selectedFont,
    this.selectedStyle,
    this.selectedColor = AppPalette.white,
    this.selectedFontSize = kBaseFontSize,
    this.selectedStyleColor = AppPalette.white,
  });

  FontStoryState copyWith({
    PaginatedListState<FontEntity>? fonts,
    PaginatedListState<TextEffectStyle>? styles,
    double? lineHeight,
    double? letterSpacing,
    double? wordSpacing,
    bool? isRTLDirection,
    TextAlign? textAlign,
    FontEntity? selectedFont,
    TextEffectStyle? selectedStyle,
    Color? selectedColor,
    double? selectedFontSize,
    Color? selectedStyleColor,
  }) {
    return FontStoryState(
      fonts: fonts ?? this.fonts,
      styles: styles ?? this.styles,
      lineHeight: lineHeight ?? this.lineHeight,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      isRTLDirection: isRTLDirection ?? this.isRTLDirection,
      textAlign: textAlign ?? this.textAlign,
      selectedFont: selectedFont ?? this.selectedFont,
      selectedStyle: selectedStyle ?? this.selectedStyle,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedFontSize: selectedFontSize ?? this.selectedFontSize,
      selectedStyleColor: selectedStyleColor ?? this.selectedStyleColor,
    );
  }

  @override
  List<Object?> get props => [
    fonts,
    styles,
    lineHeight,
    letterSpacing,
    wordSpacing,
    isRTLDirection,
    textAlign,
    selectedFont,
    selectedStyle,
    selectedColor,
    selectedFontSize,
    selectedStyleColor,
  ];
}
