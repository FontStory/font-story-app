part of 'color_selection_cubit.dart';

class ColorSelectionState extends Equatable {
  final Color selectedColor;
  final Gradient selectedGradient;
  final Color selectedStyleColor;
  final Gradient selectedStyleGradient;
  final ColorSelectionType colorSelectionType;
  final ColorSelectionType styleColorSelectionType;

  const ColorSelectionState({
    this.selectedColor = AppPalette.white,
    this.selectedGradient = const LinearGradient(colors: []),
    this.selectedStyleColor = AppPalette.white,
    this.selectedStyleGradient = const LinearGradient(colors: []),
    this.colorSelectionType = ColorSelectionType.color,
    this.styleColorSelectionType = ColorSelectionType.color,
  });

  ColorSelectionState copyWith({
    Color? selectedColor,
    Gradient? selectedGradient,
    Color? selectedStyleColor,
    Gradient? selectedStyleGradient,
    ColorSelectionType? colorSelectionType,
    ColorSelectionType? styleColorSelectionType,
  }) {
    return ColorSelectionState(
      selectedColor: selectedColor ?? this.selectedColor,
      selectedGradient: selectedGradient ?? this.selectedGradient,
      selectedStyleColor: selectedStyleColor ?? this.selectedStyleColor,
      selectedStyleGradient:
          selectedStyleGradient ?? this.selectedStyleGradient,
      colorSelectionType: colorSelectionType ?? this.colorSelectionType,
      styleColorSelectionType:
          styleColorSelectionType ?? this.styleColorSelectionType,
    );
  }

  @override
  List<Object?> get props => [
    selectedColor,
    selectedGradient,
    selectedStyleColor,
    selectedStyleGradient,
    colorSelectionType,
    styleColorSelectionType,
  ];
}
