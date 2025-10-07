part of 'text_field_stack.dart';

/// A read-only text field used for background styling effects.
class _StylingTextField extends StatelessWidget {
  const _StylingTextField({
    required this.style,
    required this.fontState,
    required this.styleState,
    required this.colorState,
    required this.formattingState,
    required this.controller,
    this.decoration,
  });

  final TextStyle style;
  final FontSelectionState fontState;
  final StyleSelectionState styleState;
  final ColorSelectionState colorState;
  final TextFormattingState formattingState;
  final HighlightController controller;
  final InputDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return TextField(
      scrollPhysics: const NeverScrollableScrollPhysics(),
      maxLines: null,
      readOnly: true,
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      style: style,
      textAlign: formattingState.textAlign,
      textDirection: formattingState.isRTLDirection
          ? TextDirection.rtl
          : TextDirection.ltr,
      decoration: decoration,
    );
  }
}
