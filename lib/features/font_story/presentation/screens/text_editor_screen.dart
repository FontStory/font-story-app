import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/index.dart' show AppSpacing;
import 'package:font_story/core/common/localization/cubit/localization_cubit.dart';
import 'package:font_story/core/common/localization/language.dart';
import 'package:font_story/core/common/theme/theme_cubit.dart';
import 'package:font_story/core/components/dialog.dart';
import 'package:font_story/core/constants/enums/status.dart';
import 'package:font_story/core/extensions/index.dart';
import 'package:font_story/features/font_story/presentation/widgets/toolbar/bottom_toolbar.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../cubit/export/export_cubit.dart';
import '../cubit/font_story_cubit.dart';
import '../widgets/export_sheet.dart';
import '../widgets/header.dart';
import '../widgets/side_controller.dart';
import '../widgets/size_slider.dart';
import '../widgets/text_editor/editor_field.dart';

class TextEditorScreen extends StatefulWidget {
  const TextEditorScreen({super.key});

  @override
  State<TextEditorScreen> createState() => _TextEditorScreenState();
}

class _TextEditorScreenState extends State<TextEditorScreen> {
  late TextEditingController _controller;
  late ScreenshotController _screenshotController;
  late FocusNode _focusNode;
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

  void _toggleFocus() {
    if (_focusNode.hasFocus && _controller.text.isNotEmpty) {
      _focusNode.unfocus();
    } else {
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LocalizationCubit, Language>(
          listener: (context, state) {
            context.read<FontStoryCubit>().getFonts(language: state);
          },
        ),
        BlocListener<ExportCubit, ExportState>(
          listenWhen: (previous, current) =>
              previous.message != current.message && current.message != null,
          listener: (context, state) {
            context.showCustomDialog(
              content: AppDialog(
                text: state.message!,
                icon: state.status == DataStatus.success
                    ? Iconsax.tick_circle_copy
                    : Iconsax.close_circle_copy,
              ),
            );
            context.read<ExportCubit>().messageHandled();
          },
        ),
      ],
      child: GestureDetector(
        onTap: () => _toggleFocus(),
        child: Scaffold(
          body: DecoratedBox(
            decoration: BoxDecoration(
              gradient: context.watch<ThemeCubit>().state.gradient,
            ),
            child: SafeArea(
              child: Center(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Positioned(
                      top: AppSpacing.xl,
                      left: AppSpacing.xl,
                      right: AppSpacing.xl,
                      child: Header(
                        onExportTap: () {
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
                        },
                      ),
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Positioned.fill(
                                child: Center(
                                  child: EditorField(
                                    screenshotController: _screenshotController,
                                    controller: _controller,
                                    focusNode: _focusNode,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: AppSpacing.xl,
                                bottom: 128,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizeSlider(),
                                    SideController(
                                      textEditingController: _controller,
                                    ),
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
          ),
        ),
      ),
    );
  }
}
