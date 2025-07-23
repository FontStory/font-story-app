part of 'editor_field.dart';

/// A read-only text field used for background styling effects.
class _StylingTextField extends StatelessWidget {
  const _StylingTextField({
    required this.style,
    required this.state,
    required this.controller,
    required this.decoration,
  });

  final TextStyle style;
  final FontStoryState state;
  final TextEditingController controller;
  final InputDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: TextField(
        scrollPhysics: const NeverScrollableScrollPhysics(),
        maxLines: null,
        readOnly: true,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        style: style,
        textAlign: state.textAlign,
        textDirection: state.isRTLDirection
            ? TextDirection.rtl
            : TextDirection.ltr,
        decoration: decoration,
      ),
    );
  }
}
