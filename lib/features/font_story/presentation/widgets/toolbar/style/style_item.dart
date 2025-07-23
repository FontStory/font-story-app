import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_story/config/values/index.dart';
import 'package:font_story/core/extensions/index.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../domain/entities/style.dart';

class StyleItem extends StatelessWidget {
  const StyleItem({
    super.key,
    required this.style,
    this.isSelected = false,
    required this.onStyleSelected,
  });

  final TextEffectStyle style;
  final bool isSelected;
  final void Function(TextEffectStyle style) onStyleSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onStyleSelected(style),
      child: AspectRatio(
        aspectRatio: 1,
        child: CachedNetworkImage(
          imageUrl: style.thumbnail,
          fit: BoxFit.cover,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(AppRadius.s),
              border: isSelected
                  ? Border.all(
                      width: AppDimensions.selectedBorderWidth,
                      color: context.palette.onSurface,
                    )
                  : null,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              color: context.palette.surface,
            ),
          ),
          placeholder: (context, url) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(AppRadius.s),
              color: context.palette.surface,
            ),
            child: RepaintBoundary(
              child: LoadingAnimationWidget.hexagonDots(
                color: context.palette.onSurface,
                size: AppDimensions.icon,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(AppRadius.s),
              color: context.palette.surface,
            ),
            child: Icon(
              Iconsax.gallery_slash_copy,
              color: context.palette.error.withValues(alpha: 0.7),
              size: AppDimensions.icon,
            ),
          ),
        ),
      ),
    );
  }
}

/// Skeleton Placeholder for Style Item
class SkeletonStyleItem extends StatelessWidget {
  const SkeletonStyleItem({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(AppRadius.s),
          color: context.palette.surface,
        ),
      ),
    ).asSkeleton(true);
  }
}
