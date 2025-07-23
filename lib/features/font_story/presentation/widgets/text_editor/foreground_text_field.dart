part of 'editor_field.dart';

/// The main, editable text field that is visible to the user.
class _ForegroundTextField extends StatelessWidget {
  const _ForegroundTextField({
    required this.state,
    required this.controller,
    required this.focusNode,
    required this.decoration,
  });

  final FontStoryState state;
  final TextEditingController controller;
  final FocusNode focusNode;
  final InputDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: TextField(
        scrollPhysics: const NeverScrollableScrollPhysics(),
        maxLines: null,
        controller: controller,
        focusNode: focusNode,
        autofocus: true,
        showCursor: true,
        autocorrect: true,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: context.palette.onSurface,
        style: _EditorFieldStyles.buildInputTextStyle(state),
        textAlign: state.textAlign,
        textDirection: state.isRTLDirection
            ? TextDirection.rtl
            : TextDirection.ltr,
        decoration: decoration,
        contextMenuBuilder: _buildContextMenu,
      ),
    );
  }

  Widget _buildContextMenu(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    // This is a specific workaround to hide the default context menu on iOS for web,
    // which can have rendering issues or undesirable behavior.
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
