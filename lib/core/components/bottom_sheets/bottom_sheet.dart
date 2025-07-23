import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_story/config/values/index.dart';
import 'package:font_story/core/extensions/index.dart';

class BottomSheetContent extends StatelessWidget {
  final Widget content;
  final Curve animationCurve;

  const BottomSheetContent({
    super.key,
    required this.content,
    this.animationCurve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: AppRadius.lg),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: animationCurve,
          decoration: BoxDecoration(
            color: context.palette.surface,
            borderRadius: BorderRadius.vertical(top: AppRadius.lg),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 4,
                margin: 8.vertical,
                decoration: BoxDecoration(
                  color: context.palette.onSurface.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.all(AppRadius.s),
                ),
              ),
              // Close button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: 12.right + 24.bottom,
                  child: IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => context.pop(),
                  ),
                ),
              ),
              // Main content
              content,
              AppSpacing.xxxl.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
