part of 'editor_field.dart';

class _TextFieldStack extends StatelessWidget {
  const _TextFieldStack({
    required this.state,
    required this.controller,
    required this.focusNode,
    required this.commonDecoration,
  });

  final FontStoryState state;
  final TextEditingController controller;
  final FocusNode focusNode;
  final InputDecoration commonDecoration;

  @override
  Widget build(BuildContext context) {
    final selectedStyle = state.selectedStyle;
    final layeredStyles = selectedStyle?.layeredTextStyles;
    final scaleFactor = state.selectedFontSize / kBaseFontSize;

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (layeredStyles != null)
            for (final (index, layerStyle) in layeredStyles.indexed)
              Transform.translate(
                offset: Offset(
                  (layerStyle.position?.dx ?? 0) * scaleFactor,
                  (layerStyle.position?.dy ?? 0) * scaleFactor,
                ),
                child: _StylingTextField(
                  style: _EditorFieldStyles.buildLayerStyle(state, index),
                  state: state,
                  controller: controller,
                  decoration: commonDecoration,
                ),
              ),
          _StylingTextField(
            style: _EditorFieldStyles.buildEffectStyle(state),
            state: state,
            controller: controller,
            decoration: commonDecoration,
          ),
          _ForegroundTextField(
            state: state,
            controller: controller,
            focusNode: focusNode,
            decoration: commonDecoration,
          ),
        ],
      ),
    );
  }
}
