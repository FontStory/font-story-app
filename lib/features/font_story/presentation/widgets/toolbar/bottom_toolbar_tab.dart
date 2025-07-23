import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_story/config/values/index.dart' show AppRadius;
import 'package:font_story/core/extensions/index.dart'
    show PaddingExtension, ThemeExtension;

class BottomToolbarTab extends StatelessWidget {
  const BottomToolbarTab({super.key, required this.isColorMutable});

  final bool isColorMutable;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 8.vertical + 10.horizontal,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(AppRadius.circle),
        color: context.palette.onBackground,
      ),
      child: TabBar(
        labelPadding: 18.horizontal,
        tabAlignment: TabAlignment.center,
        dividerHeight: 0,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.all(AppRadius.circle),
          color: context.palette.primary,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: context.typography.paragraph,
        unselectedLabelStyle: context.typography.paragraph,
        unselectedLabelColor: context.palette.onSurface.withValues(alpha: 0.8),
        labelColor: context.palette.onPrimary,
        tabs: [
          Tab(text: 'ui.style'.tr()),
          Tab(text: 'ui.font'.tr()),
          Tab(text: 'ui.color'.tr()),
          if (isColorMutable) Tab(text: 'ui.style_color'.tr()),
        ],
      ),
    );
  }
}
