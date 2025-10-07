import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/index.dart' show AppSpacing;
import 'package:font_story/core/common/localization/cubit/localization_cubit.dart';
import 'package:font_story/core/common/localization/language.dart';
import 'package:font_story/core/common/theme/theme_cubit.dart';
import 'package:font_story/core/components/dialog.dart';
import 'package:font_story/core/constants/enums/status.dart';
import 'package:font_story/core/extensions/index.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../cubit/editor_controller/editor_controller_cubit.dart';
import '../cubit/export/export_cubit.dart';
import '../cubit/highlight/highlight_cubit.dart';
import '../cubit/text_formatting/text_formatting_cubit.dart';
import '../widgets/index.dart';
import '../widgets/text_editor/highlight_controller.dart';

part '../widgets/text_editor/editor_body.dart';

class TextEditorScreen extends StatefulWidget {
  const TextEditorScreen({super.key});

  @override
  State<TextEditorScreen> createState() => _TextEditorScreenState();
}

class _TextEditorScreenState extends State<TextEditorScreen> {
  late final HighlightController _controller;
  late final ScreenshotController _screenshotController;
  late final FocusNode _focusNode;
  late TextSelection _previousSelection;

  @override
  void initState() {
    super.initState();
    _controller = HighlightController();
    _previousSelection = _controller.selection;
    _controller.addListener(_onTextChanged);
    _screenshotController = ScreenshotController();
    _focusNode = FocusNode();
  }

  void _onTextChanged() {
    if (_controller.text.isEmpty) {
      _controller.highlights.clear();
    }
    final currentSelection = _controller.selection;
    // Check if the selection has changed (not just cursor movement)
    if (currentSelection != _previousSelection &&
        currentSelection.start != currentSelection.end) {
      context.read<HighlightCubit>().clear();
      _previousSelection = currentSelection;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
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
    context.read<ExportCubit>().messageHandled();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LocalizationCubit, Language>(
          listener: (context, language) => context
              .read<EditorControllerCubit>()
              .initializeEditor(language: language),
        ),
        BlocListener<ExportCubit, ExportState>(
          listenWhen: (prev, curr) => prev.message != curr.message,
          listener: _exportListener,
        ),
        BlocListener<TextFormattingCubit, TextFormattingState>(
          listenWhen: (prev, curr) => prev.letterSpacing != curr.letterSpacing,
          listener: (context, state) {
            _controller.text = _controller.text
                .applyKeshide(state.letterSpacing)
                .adjustKeshide(state.letterSpacing);
          },
        ),
        BlocListener<HighlightCubit, HighlightState>(
          listener: (context, state) {
            _controller.colorize(
              state.color,
              state.gradient,
              state.font?.fontFamily,
              state.fontSize,
              state.selectionType,
            );
          },
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
