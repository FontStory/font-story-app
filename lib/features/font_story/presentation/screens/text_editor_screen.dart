import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:font_story/config/values/index.dart' show AppSpacing;
import 'package:font_story/core/common/localization/cubit/localization_cubit.dart';
import 'package:font_story/core/common/localization/language.dart';
import 'package:font_story/core/common/theme/theme_cubit.dart';
import 'package:font_story/core/components/dialog.dart';
import 'package:font_story/core/constants/enums/status.dart';
import 'package:font_story/core/extensions/index.dart';

import '../cubit/export/export_cubit.dart';
import '../cubit/font_story_cubit.dart';
import '../widgets/index.dart';

class TextEditorScreen extends StatefulWidget {
  const TextEditorScreen({super.key});

  @override
  State<TextEditorScreen> createState() => _TextEditorScreenState();
}

class _TextEditorScreenState extends State<TextEditorScreen> {
  late final TextEditingController _controller;
  late final ScreenshotController _screenshotController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _screenshotController = ScreenshotController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _showExportSheet() {
    _focusNode.unfocus();
    context.showCustomBottomSheet(
      content: BlocProvider.value(
        value: context.read<ExportCubit>(),
        child: ExportSheet(
          screenshotController: _screenshotController,
          focusNode: _focusNode,
          isTextFieldEmpty: _controller.text.isEmpty,
        ),
      ),
    );
  }

  void _exportListener(BuildContext context, ExportState state) {
    if (state.message == null) return;

    context.showCustomDialog(
      content: AppDialog(
        text: state.message!,
        icon: switch (state.status) {
          DataStatus.success => Iconsax.tick_circle_copy,
          DataStatus.loading => Iconsax.info_circle_copy,
          _ => Iconsax.close_circle_copy,
        },
      ),
    );
    // Notify the cubit that the message has been handled to prevent re-showing.
    context.read<ExportCubit>().messageHandled();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LocalizationCubit, Language>(
          listener: (context, language) =>
              context.read<FontStoryCubit>().getFonts(language: language),
        ),
        BlocListener<ExportCubit, ExportState>(
          listenWhen: (prev, curr) => prev.message != curr.message,
          listener: _exportListener,
        ),
      ],
      child: GestureDetector(
        onTap: _focusNode.unfocus,
        child: Scaffold(
          body: _TextEditorBody(
            controller: _controller,
            screenshotController: _screenshotController,
            focusNode: _focusNode,
            onExportTap: _showExportSheet,
          ),
        ),
      ),
    );
  }
}

class _TextEditorBody extends StatelessWidget {
  const _TextEditorBody({
    required this.controller,
    required this.screenshotController,
    required this.focusNode,
    required this.onExportTap,
  });

  final TextEditingController controller;
  final ScreenshotController screenshotController;
  final FocusNode focusNode;
  final VoidCallback onExportTap;

  @override
  Widget build(BuildContext context) {
    final gradient = context.watch<ThemeCubit>().state.gradient;

    return DecoratedBox(
      decoration: BoxDecoration(gradient: gradient),
      child: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Header positioned at the top
              Positioned(
                top: AppSpacing.xl,
                left: AppSpacing.xl,
                right: AppSpacing.xl,
                child: Header(onExportTap: onExportTap),
              ),

              // Main content positioned at the center
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
                          left: 0,
                          right: AppSpacing.xl,
                          bottom: 128,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizeSlider(),
                              SideController(textEditingController: controller),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  BottomToolbar(),
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
