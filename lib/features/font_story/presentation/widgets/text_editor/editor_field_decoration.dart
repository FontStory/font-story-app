part of 'text_field_stack.dart';

/// Utility class for building scaled padding and decorations.
/// Keeps all transformations pure to avoid unnecessary widget rebuilds.
class _EditorFieldDecoration {
  const _EditorFieldDecoration._();

  /// Builds scaled padding from [TextEffectStyle] and [BoxDecorationState].
  static EdgeInsets? buildScaledPadding(
      TextEffectStyle? style,
      BoxDecorationState decoration,
      double scaleFactor,
      ) {
    if (style == null) return null;

    final base = style.boxPadding ?? EdgeInsets.zero;

    return EdgeInsets.only(
      top: (decoration.topPadding ?? base.top) * scaleFactor,
      bottom: (decoration.bottomPadding ?? base.bottom) * scaleFactor,
      left: (decoration.leftPadding ?? base.left) * scaleFactor,
      right: (decoration.rightPadding ?? base.right) * scaleFactor,
    );
  }

  /// Builds a scaled [BoxDecoration] including borders, shadows, and colors.
  static BoxDecoration? buildScaledBoxDecoration(
      FontSelectionState fontState,
      StyleSelectionState styleState,
      ColorSelectionState colorState,
      TextFormattingState formattingState,
      TextEffectStyle? style,
      BoxDecorationState decoration,
      double scaleFactor,
      ) {
    final base = style?.boxDecoration;
    if (style == null || base == null) return null;

    final hasImage = base.image != null;

    return base.copyWith(
      image: hasImage
          ? base.image?.copyWith(
        colorFilter: ColorFilter.mode(
          colorState.selectedStyleColor,
          BlendMode.srcIn,
        ),
      )
          : null,
      color: hasImage
          ? null
          : colorState.styleColorSelectionType == ColorSelectionType.color
          ? colorState.selectedStyleColor
          : null,
      gradient: hasImage
          ? null
          : colorState.styleColorSelectionType == ColorSelectionType.gradient
          ? colorState.selectedStyleGradient
          : null,
      border: base.border != null
          ? _buildScaledBorder(base.border as Border?, decoration, scaleFactor)
          : null,
      borderRadius: base.borderRadius != null
          ? _buildScaledBorderRadius(decoration, scaleFactor)
          : null,
      boxShadow: base.boxShadow != null
          ? _buildScaledBoxShadows(base, decoration, scaleFactor)
          : null,
    );
  }

  /// Scales border widths with optional overrides.
  static Border? _buildScaledBorder(
      Border? base,
      BoxDecorationState decoration,
      double scaleFactor,
      ) {
    if (base == null &&
        decoration.topBorderWidth == null &&
        decoration.rightBorderWidth == null &&
        decoration.bottomBorderWidth == null &&
        decoration.leftBorderWidth == null) {
      return null;
    }

    BorderSide scaleSide(BorderSide side, double? overrideWidth) {
      final scaledWidth = (overrideWidth ?? side.width) * scaleFactor;
      return scaledWidth > 0
          ? side.copyWith(
        width: scaledWidth,
        color: decoration.borderColor ?? side.color,
      )
          : BorderSide.none;
    }

    return Border(
      top: scaleSide(base?.top ?? BorderSide.none, decoration.topBorderWidth),
      right: scaleSide(
        base?.right ?? BorderSide.none,
        decoration.rightBorderWidth,
      ),
      bottom: scaleSide(
        base?.bottom ?? BorderSide.none,
        decoration.bottomBorderWidth,
      ),
      left: scaleSide(
        base?.left ?? BorderSide.none,
        decoration.leftBorderWidth,
      ),
    );
  }

  /// Scales border radius.
  static BorderRadius? _buildScaledBorderRadius(
      BoxDecorationState decoration,
      double scaleFactor,
      ) {
    if (decoration.topLeftRadius == null &&
        decoration.topRightRadius == null &&
        decoration.bottomLeftRadius == null &&
        decoration.bottomRightRadius == null) {
      return null;
    }

    return BorderRadius.only(
      topLeft: Radius.circular((decoration.topLeftRadius ?? 0)),
      topRight: Radius.circular((decoration.topRightRadius ?? 0)),
      bottomLeft: Radius.circular((decoration.bottomLeftRadius ?? 0)),
      bottomRight: Radius.circular((decoration.bottomRightRadius ?? 0)),
    );
  }

  /// Builds scaled shadows with overrides.
  static List<BoxShadow>? _buildScaledBoxShadows(
      BoxDecoration base,
      BoxDecorationState decoration,
      double scaleFactor,
      ) {
    if (decoration.shadowColor == null &&
        decoration.shadowBlurRadius == null &&
        decoration.shadowSpreadRadius == null &&
        decoration.shadowOffset == null) {
      return null;
    }

    final offset = decoration.shadowOffset ?? Offset.zero;

    return [
      BoxShadow(
        color:
        decoration.shadowColor ??
            base.boxShadow?.first.color ??
            Colors.black,
        blurRadius: (decoration.shadowBlurRadius ?? 0) * scaleFactor,
        spreadRadius: (decoration.shadowSpreadRadius ?? 0) * scaleFactor,
        offset: Offset(offset.dx * scaleFactor, offset.dy * scaleFactor),
      ),
    ];
  }
}