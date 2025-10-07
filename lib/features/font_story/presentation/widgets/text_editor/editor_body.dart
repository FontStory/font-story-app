part of '../../screens/text_editor_screen.dart';

class _TextEditorBody extends StatelessWidget {
  const _TextEditorBody({
    required this.controller,
    required this.screenshotController,
    required this.focusNode,
    required this.onExportTap,
  });

  final HighlightController controller;
  final ScreenshotController screenshotController;
  final FocusNode focusNode;
  final VoidCallback onExportTap;

  @override
  Widget build(BuildContext context) {
    final gradient = context.select((ThemeCubit cubit) => cubit.state.gradient);

    return DecoratedBox(
      decoration: BoxDecoration(gradient: gradient),
      child: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Header
              Positioned(
                top: AppSpacing.xl,
                left: AppSpacing.xl,
                right: AppSpacing.xl,
                child: Header(onExportTap: onExportTap),
              ),

              // Main editor area
              Column(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Positioned.fill(
                          child: Center(
                            child: EditorField(
                              screenshotController: screenshotController,
                              controller: controller,
                              focusNode: focusNode,
                            ),
                          ),
                        ),
                        Positioned(
                          left: AppSpacing.lg,
                          right: AppSpacing.lg,
                          bottom: 128,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ValueListenableBuilder<TextEditingValue>(
                                valueListenable: controller,
                                builder: (context, value, _) => SizeSlider(
                                  hasHighlight: controller.hasSelection,
                                ),
                              ),
                              SideController(textEditingController: controller),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: controller,
                    builder: (context, value, _) =>
                        BottomToolbar(hasHighlight: controller.hasSelection),
                  ),
                  AppSpacing.xxxl.verticalSpace,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
