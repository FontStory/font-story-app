part of 'editor_field.dart';

class _EditorFieldStyles {
  /// Resolves and scales the text style for the main background layer.
  static TextStyle buildEffectStyle(FontStoryState state) {
    final baseStyle =
        state.selectedStyle?.effectStyle ??
        AppTypography.heading5.copyWith(fontWeight: null);
    final scaleFactor = state.selectedFontSize / kBaseFontSize;

    Paint? newBackground;
    if (baseStyle.background is Paint) {
      final oldPaint = baseStyle.background as Paint;
      newBackground = Paint()
        ..color = state.selectedStyleColor
        ..strokeWidth = oldPaint.strokeWidth
        ..style = oldPaint.style
        ..maskFilter = oldPaint.maskFilter
        ..filterQuality = oldPaint.filterQuality
        ..strokeCap = oldPaint.strokeCap
        ..strokeJoin = oldPaint.strokeJoin;
    }

    Paint? newForeground;
    if (baseStyle.foreground is Paint) {
      final oldPaint = baseStyle.foreground as Paint;
      newForeground = Paint()
        ..color = oldPaint.color
        ..strokeWidth = oldPaint.strokeWidth * scaleFactor
        ..style = oldPaint.style
        ..maskFilter = oldPaint.maskFilter
        ..filterQuality = oldPaint.filterQuality
        ..strokeCap = oldPaint.strokeCap
        ..strokeJoin = oldPaint.strokeJoin;

      if (state.selectedStyle?.canChangeColor ?? false) {
        newForeground.color = state.selectedStyleColor;
      }
    }

    return baseStyle.copyWith(
      fontFamily: state.selectedFont?.fontFamily ?? baseStyle.fontFamily,
      fontSize: state.selectedFontSize,
      color: baseStyle.foreground == null ? Colors.transparent : null,
      decorationColor: state.selectedStyleColor,
      background: newBackground,
      foreground: newForeground,
      height: state.lineHeight,
      letterSpacing: state.letterSpacing,
      wordSpacing: state.wordSpacing,
      shadows: _scaleShadows(
        baseStyle.shadows ?? const [],
        state.selectedFontSize,
        state.selectedStyleColor,
      ),
    );
  }

  /// Resolves and scales the text style for additional background layers.
  static TextStyle buildLayerStyle(FontStoryState state, int index) {
    final baseStyle =
        state.selectedStyle?.layeredTextStyles?[index].style ??
        AppTypography.heading5.copyWith(fontWeight: null);
    final scaleFactor = state.selectedFontSize / kBaseFontSize;

    Paint? newForeground;
    if (baseStyle.foreground is Paint) {
      final oldPaint = baseStyle.foreground as Paint;
      newForeground = Paint()
        ..color = oldPaint.color
        ..strokeWidth = oldPaint.strokeWidth * scaleFactor
        ..style = oldPaint.style
        ..maskFilter = oldPaint.maskFilter
        ..filterQuality = oldPaint.filterQuality
        ..strokeCap = oldPaint.strokeCap
        ..strokeJoin = oldPaint.strokeJoin;
    }

    return baseStyle.copyWith(
      fontFamily: state.selectedFont?.fontFamily ?? baseStyle.fontFamily,
      fontSize: state.selectedFontSize,
      color: baseStyle.foreground == null ? Colors.transparent : null,
      foreground: newForeground,
      height: state.lineHeight,
      letterSpacing: state.letterSpacing,
      wordSpacing: state.wordSpacing,
      shadows: _scaleShadows(
        baseStyle.shadows,
        state.selectedFontSize,
        state.selectedStyleColor,
      ),
    );
  }

  /// Resolves the text style for the main, editable text layer.
  static TextStyle buildInputTextStyle(FontStoryState state) {
    final baseStyle =
        state.selectedStyle?.baseTextStyle ??
        AppTypography.heading5.copyWith(fontWeight: null);

    return baseStyle.copyWith(
      fontFamily: state.selectedFont?.fontFamily ?? baseStyle.fontFamily,
      fontSize: state.selectedFontSize,
      color: state.selectedColor,
      height: state.lineHeight,
      letterSpacing: state.letterSpacing,
      wordSpacing: state.wordSpacing,
      shadows: _scaleShadows(
        baseStyle.shadows,
        state.selectedFontSize,
        state.selectedStyleColor,
      ),
    );
  }

  /// Scales a list of shadows based on the current font size.
  static List<Shadow> _scaleShadows(
    List<Shadow>? shadows,
    double fontSize,
    Color newShadowColor,
  ) {
    if (shadows == null) return [];
    final scaleFactor = fontSize / kBaseFontSize;
    return shadows
        .map(
          (shadow) => Shadow(
            color: shadow.color == Colors.transparent
                ? newShadowColor
                : shadow.color,
            blurRadius: shadow.blurRadius * scaleFactor,
            offset: shadow.offset * scaleFactor,
          ),
        )
        .toList();
  }
}
