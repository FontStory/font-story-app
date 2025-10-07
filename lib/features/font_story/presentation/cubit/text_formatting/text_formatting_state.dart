part of 'text_formatting_cubit.dart';

class TextFormattingState extends Equatable {
  final double lineHeight;
  final double letterSpacing;
  final double wordSpacing;
  final bool isRTLDirection;
  final TextAlign textAlign;
  final double selectedFontSize;

  const TextFormattingState({
    this.lineHeight = 1.0,
    this.letterSpacing = 0.0,
    this.wordSpacing = 0.0,
    this.isRTLDirection = false,
    this.textAlign = TextAlign.center,
    this.selectedFontSize = kBaseFontSize,
  });

  TextFormattingState copyWith({
    double? lineHeight,
    double? letterSpacing,
    double? wordSpacing,
    bool? isRTLDirection,
    TextAlign? textAlign,
    double? selectedFontSize,
  }) {
    return TextFormattingState(
      lineHeight: lineHeight ?? this.lineHeight,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      isRTLDirection: isRTLDirection ?? this.isRTLDirection,
      textAlign: textAlign ?? this.textAlign,
      selectedFontSize: selectedFontSize ?? this.selectedFontSize,
    );
  }

  @override
  List<Object?> get props => [
    lineHeight,
    letterSpacing,
    wordSpacing,
    isRTLDirection,
    textAlign,
    selectedFontSize,
  ];
}
