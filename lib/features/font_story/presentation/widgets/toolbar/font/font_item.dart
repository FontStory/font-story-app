import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/dimensions.dart';
import 'package:font_story/config/values/radius.dart';
import 'package:font_story/core/constants/enums/status.dart';
import 'package:font_story/core/extensions/index.dart';
import 'package:font_story/locator/service_locator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../domain/entities/font.dart';
import '../../../cubit/font_loader/font_loader_cubit.dart';

class FontItem extends StatefulWidget {
  const FontItem({
    super.key,
    required this.font,
    this.isSelected = false,
    this.onLongPress,
    required this.onFontSelected,
  });

  final FontEntity font;
  final bool isSelected;
  final Function()? onLongPress;
  final void Function(FontEntity font) onFontSelected;

  @override
  State<FontItem> createState() => _FontItemState();
}

class _FontItemState extends State<FontItem>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
      create: (context) =>
          FontLoaderCubit(locator.get())..loadFont(widget.font),
      child: BlocBuilder<FontLoaderCubit, FontLoaderState>(
        builder: (context, loadState) {
          return GestureDetector(
            onTap: () => widget.onFontSelected(widget.font),
            onLongPress: widget.onLongPress,
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: (widget.font.language != null)
                        ? 18.top + 4.horizontal
                        : 4.horizontal,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(AppRadius.s),
                      border: widget.isSelected
                          ? Border.all(
                              width: AppDimensions.selectedBorderWidth,
                              color: context.palette.onSurface,
                            )
                          : null,
                      color: context.palette.surface,
                    ),
                    child: Center(
                      child: (loadState.status == DataStatus.loading)
                          ? RepaintBoundary(
                              child: LoadingAnimationWidget.hexagonDots(
                                color: context.palette.onSurface,
                                size: AppDimensions.icon,
                              ),
                            )
                          : Text(
                              widget.font.title,
                              style: context.typography.paragraph.copyWith(
                                fontFamily: widget.font.fontFamily,
                                color: context.palette.onSurface,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                            ),
                    ),
                  ),
                  _buildBadge(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBadge(BuildContext context) {
    String? badgeText;
    if (widget.font.language != null) {
      badgeText = widget.font.language!.capitalize();
    }

    if (badgeText == null) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: 6,
      right: 6,
      child: Container(
        padding: 2.vertical + 4.horizontal,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(AppRadius.xs),
          color: context.palette.onSurface.withValues(alpha: 0.2),
        ),
        child: Text(
          badgeText,
          style: context.typography.tiny.copyWith(
            color: context.palette.onSurface,
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

/// Skeleton Placeholder for Font Item
class SkeletonFontItem extends StatelessWidget {
  const SkeletonFontItem({super.key});

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
