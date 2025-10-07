part of 'text_field_stack.dart';

class _EditorFieldStyles {
  const _EditorFieldStyles._();

  /// Main background layer style.
  static TextStyle buildEffectStyle(
    FontSelectionState fontState,
    StyleSelectionState styleState,
    ColorSelectionState colorState,
    TextFormattingState formattingState,
  ) {
    final baseStyle =
        styleState.selectedStyle?.effectStyle ??
        AppTypography.heading5.copyWith(fontWeight: null);

    return _applyCommonStyle(
      baseStyle: baseStyle,
      fontState: fontState,
      styleState: styleState,
      colorState: colorState,
      formattingState: formattingState,
      allowColorChange: styleState.selectedStyle?.canChangeColor ?? false,
      backgroundColor: colorState.selectedStyleColor,
    );
  }

  /// Additional layered text styles.
  static TextStyle buildLayerStyle(
    FontSelectionState fontState,
    StyleSelectionState styleState,
    ColorSelectionState colorState,
    TextFormattingState formattingState,
    int index,
  ) {
    final baseStyle =
        styleState.selectedStyle?.layeredTextStyles?[index].style ??
        AppTypography.heading5.copyWith(fontWeight: null);

    return _applyCommonStyle(
      baseStyle: baseStyle,
      fontState: fontState,
      styleState: styleState,
      colorState: colorState,
      formattingState: formattingState,
    );
  }

  /// Editable input text (supports gradient).
  static TextStyle buildInputTextStyle(
    FontSelectionState fontState,
    StyleSelectionState styleState,
    ColorSelectionState colorState,
    TextFormattingState formattingState,
    String text,
  ) {
    final baseStyle =
        styleState.selectedStyle?.baseTextStyle ??
        AppTypography.heading5.copyWith(fontWeight: null);

    Paint? gradientPaint;
    if (colorState.colorSelectionType == ColorSelectionType.gradient) {
      final textSize = _measureTextSize(
        text: text,
        style: baseStyle.copyWith(fontSize: formattingState.selectedFontSize),
        isRTL: formattingState.isRTLDirection,
      );
      gradientPaint = Paint()
        ..shader = colorState.selectedGradient.createShader(
          Rect.fromLTWH(0, 0, textSize.width, textSize.height),
        )
        ..style = PaintingStyle.fill;
    }

    return baseStyle.copyWith(
      fontFamily: fontState.selectedFont?.fontFamily ?? baseStyle.fontFamily,
      fontSize: formattingState.selectedFontSize,
      color: gradientPaint == null ? colorState.selectedColor : null,
      foreground: gradientPaint,
      height: formattingState.lineHeight,
      letterSpacing: formattingState.letterSpacing < 0
          ? formattingState.letterSpacing
          : 0,
      wordSpacing: formattingState.wordSpacing,
      shadows: _scaleShadows(
        baseStyle.shadows?.cast<BoxShadow>(),
        formattingState.selectedFontSize,
        colorState.selectedColor,
      ),
    );
  }

  /// --- Helpers ---
  static TextStyle _applyCommonStyle({
    required TextStyle baseStyle,
    required FontSelectionState fontState,
    required StyleSelectionState styleState,
    required ColorSelectionState colorState,
    required TextFormattingState formattingState,
    bool allowColorChange = false,
    Color? backgroundColor,
  }) {
    final scaleFactor = formattingState.selectedFontSize / kBaseFontSize;

    final newBackground = _clonePaint(
      baseStyle.background,
      color: backgroundColor,
    );
    final newForeground = _clonePaint(
      baseStyle.foreground,
      scaleFactor: scaleFactor,
      overrideColor: allowColorChange ? colorState.selectedStyleColor : null,
    );

    return baseStyle.copyWith(
      fontFamily: fontState.selectedFont?.fontFamily ?? baseStyle.fontFamily,
      fontSize: formattingState.selectedFontSize,
      color: baseStyle.foreground == null ? Colors.transparent : null,
      decorationColor: colorState.selectedStyleColor,
      background: newBackground,
      foreground: newForeground,
      height: formattingState.lineHeight,
      letterSpacing: formattingState.letterSpacing < 0
          ? formattingState.letterSpacing
          : 0,
      wordSpacing: formattingState.wordSpacing,
      shadows: _scaleShadows(
        baseStyle.shadows?.cast<BoxShadow>(),
        formattingState.selectedFontSize,
        colorState.selectedStyleColor,
      ),
    );
  }

  static Paint? _clonePaint(
    Paint? paint, {
    double scaleFactor = 1.0,
    Color? color,
    Color? overrideColor,
  }) {
    if (paint == null) return null;
    return Paint()
      ..color = overrideColor ?? color ?? paint.color
      ..strokeWidth = paint.strokeWidth * scaleFactor
      ..style = paint.style
      ..maskFilter = paint.maskFilter
      ..filterQuality = paint.filterQuality
      ..strokeCap = paint.strokeCap
      ..strokeJoin = paint.strokeJoin;
  }

  static Size _measureTextSize({
    required String text,
    required TextStyle style,
    required bool isRTL,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
    )..layout();
    return textPainter.size;
  }

  static List<Shadow> _scaleShadows(
    List<BoxShadow>? shadows,
    double fontSize,
    Color newShadowColor,
  ) {
    if (shadows == null || shadows.isEmpty) return const [];
    final scaleFactor = fontSize / kBaseFontSize;
    return shadows
        .map(
          (shadow) => BoxShadow(
            color: shadow.color == Colors.transparent
                ? newShadowColor
                : shadow.color,
            blurRadius: shadow.blurRadius * scaleFactor,
            spreadRadius: shadow.spreadRadius * scaleFactor,
            offset: shadow.offset * scaleFactor,
          ),
        )
        .toList(growable: false);
  }
}
