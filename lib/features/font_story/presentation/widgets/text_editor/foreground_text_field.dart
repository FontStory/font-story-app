part of 'text_field_stack.dart';

/// The main, editable text field that is visible to the user.
class _ForegroundTextField extends StatelessWidget {
  const _ForegroundTextField({
    required this.fontState,
    required this.styleState,
    required this.colorState,
    required this.formattingState,
    required this.controller,
    required this.focusNode,
    this.decoration,
  });

  final FontSelectionState fontState;
  final StyleSelectionState styleState;
  final ColorSelectionState colorState;
  final TextFormattingState formattingState;
  final HighlightController controller;
  final FocusNode focusNode;
  final InputDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return TextField(
      scrollPhysics: const NeverScrollableScrollPhysics(),
      maxLines: null,
      controller: controller,
      focusNode: focusNode,
      autofocus: true,
      showCursor: true,
      autocorrect: true,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: context.palette.onSurface,
      style: _EditorFieldStyles.buildInputTextStyle(
        fontState,
        styleState,
        colorState,
        formattingState,
        controller.text,
      ),
      textAlign: formattingState.textAlign,
      textDirection: formattingState.isRTLDirection
          ? TextDirection.rtl
          : TextDirection.ltr,
      decoration: decoration,
      contextMenuBuilder: _buildContextMenu,
    );
  }

  Widget _buildContextMenu(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    // Workaround for iOS Web default context menu issues.
    if (kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      return const SizedBox.shrink();
    }

    return AdaptiveTextSelectionToolbar.buttonItems(
      anchors: editableTextState.contextMenuAnchors,
      buttonItems: [
        if (editableTextState.pasteEnabled)
          ContextMenuButtonItem(
            label: 'ui.paste'.tr(),
            onPressed: () =>
                editableTextState.pasteText(SelectionChangedCause.toolbar),
          ),
        if (editableTextState.copyEnabled)
          ContextMenuButtonItem(
            label: 'ui.copy'.tr(),
            onPressed: () =>
                editableTextState.copySelection(SelectionChangedCause.toolbar),
          ),
        if (editableTextState.cutEnabled)
          ContextMenuButtonItem(
            label: 'ui.cut'.tr(),
            onPressed: () =>
                editableTextState.cutSelection(SelectionChangedCause.toolbar),
          ),
        if (editableTextState.selectAllEnabled)
          ContextMenuButtonItem(
            label: 'ui.select_all'.tr(),
            onPressed: () =>
                editableTextState.selectAll(SelectionChangedCause.toolbar),
          ),
      ],
    );
  }
}
