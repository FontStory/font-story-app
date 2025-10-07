import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_story/config/values/index.dart';
import 'package:font_story/core/extensions/index.dart';

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({
    super.key,
    required this.content,
    this.animationCurve = Curves.easeInOut,
    this.hasFixedHeight = false,
    this.actions,
  });

  final Widget content;
  final Curve animationCurve;
  final bool hasFixedHeight;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: hasFixedHeight ? 0.5 : null,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: AppRadius.xlg),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: animationCurve,
            decoration: BoxDecoration(
              color: context.palette.surface,
              borderRadius: const BorderRadius.vertical(top: AppRadius.xlg),
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
                  height: 6,
                  margin: 12.top + 6.bottom,
                  decoration: BoxDecoration(
                    color: context.palette.onSurface.withValues(alpha: 0.6),
                    borderRadius: const BorderRadius.all(AppRadius.s),
                  ),
                ),

                Padding(
                  padding: 12.horizontal + 12.bottom,
                  child: Row(
                    children: [
                      // Actions
                      ...?actions,

                      const Spacer(),

                      // Close button
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => context.pop(),
                      ),
                    ],
                  ),
                ),

                // Main content
                Flexible(child: SingleChildScrollView(child: content)),
                if (!hasFixedHeight) AppSpacing.xxxl.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
