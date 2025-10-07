import 'package:flutter/material.dart';
import 'package:font_story/core/constants/enums/color_selection.dart';

class HighlightController extends TextEditingController {
  final List<HighlightRange> highlights = [];

  bool get hasSelection =>
      selection.isValid && !selection.isCollapsed && text.isNotEmpty;

  @override
  void clear() {
    if (highlights.isNotEmpty) {
      highlights.clear();
      notifyListeners();
    }
    super.clear();
  }

  void colorize(
    Color? color,
    Gradient? gradient,
    String? fontFamily,
    double? fontSize,
    ColorSelectionType type,
  ) {
    final sel = value.selection;
    final maxLen = text.length;

    if (!hasSelection) {
      if (highlights.isNotEmpty) {
        highlights.clear();
        notifyListeners();
      }
      return;
    }

    final start = sel.start.clamp(0, maxLen);
    final end = sel.end.clamp(0, maxLen);

    if (end <= start) return;

    // حذف highlight های قبلی که overlap دارن
    highlights.removeWhere((h) => start < h.end && end > h.start);

    _insertHighlight(
      HighlightRange(start, end, color, fontFamily, fontSize, gradient, type),
    );

    notifyListeners();
  }

  void _insertHighlight(HighlightRange range) {
    final index = highlights.indexWhere((h) => h.start > range.start);
    if (index == -1) {
      highlights.add(range);
    } else {
      highlights.insert(index, range);
    }
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    bool? withComposing,
  }) {
    if (highlights.isEmpty) {
      return TextSpan(text: text, style: style);
    }

    final List<TextSpan> children = [];
    final maxLen = text.length;
    var pointer = 0;

    for (final hl in highlights) {
      final safeStart = hl.start.clamp(0, maxLen);
      final safeEnd = hl.end.clamp(0, maxLen);

      if (safeStart > pointer) {
        children.add(
          TextSpan(text: text.substring(pointer, safeStart), style: style),
        );
      }

      if (safeEnd > safeStart) {
        final spanText = text.substring(safeStart, safeEnd);
        children.add(
          TextSpan(
            text: spanText,
            style: _applyHighlightStyle(style, hl, spanText),
          ),
        );
      }
      pointer = safeEnd;
    }

    if (pointer < text.length) {
      children.add(TextSpan(text: text.substring(pointer), style: style));
    }

    return TextSpan(children: children);
  }

  TextStyle? _applyHighlightStyle(
    TextStyle? base,
    HighlightRange hl,
    String spanText,
  ) {
    if (hl.type == ColorSelectionType.color) {
      return base?.copyWith(
        color: hl.color,
        fontFamily: hl.fontFamily,
        fontSize: hl.fontSize,
      );
    } else if (hl.type == ColorSelectionType.gradient && hl.gradient != null) {
      final fontSize = hl.fontSize ?? base?.fontSize ?? 14;
      return base?.copyWith(
        fontFamily: hl.fontFamily,
        fontSize: fontSize,
        foreground: Paint()
          ..shader = hl.gradient!.createShader(
            Rect.fromLTWH(0, 0, spanText.length * fontSize * 0.6, fontSize),
          ),
      );
    }
    return base;
  }
}

class HighlightRange {
  final int start, end;
  final Color? color;
  final String? fontFamily;
  final double? fontSize;
  final Gradient? gradient;
  final ColorSelectionType type;

  HighlightRange(
    this.start,
    this.end,
    this.color,
    this.fontFamily,
    this.fontSize,
    this.gradient,
    this.type,
  );
}
