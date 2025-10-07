part of 'highlight_cubit.dart';

class HighlightState extends Equatable {
  final double? fontSize;
  final FontEntity? font;
  final Color? color;
  final Gradient? gradient;
  final ColorSelectionType selectionType;

  const HighlightState({
    this.fontSize,
    this.font,
    this.color,
    this.gradient,
    this.selectionType = ColorSelectionType.color,
  });

  HighlightState copyWith({
    double? fontSize,
    FontEntity? font,
    Color? color,
    Gradient? gradient,
    ColorSelectionType? selectionType,
  }) {
    return HighlightState(
      fontSize: fontSize ?? this.fontSize,
      font: font ?? this.font,
      color: color ?? this.color,
      gradient: gradient ?? this.gradient,
      selectionType: selectionType ?? this.selectionType,
    );
  }

  @override
  List<Object?> get props => [fontSize, font, color, gradient, selectionType];
}
