import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'theme.dart';

extension ShimmerExtension on Widget {
  Skeletonizer asShimmer(BuildContext context, bool enabled) => Skeletonizer(
    enabled: enabled,
    effect: PulseEffect(
      from: context.palette.onSurface.withValues(alpha: 0.1),
      to: context.palette.onSurface.withValues(alpha: 0.2),
    ),
    child: this,
  );

  Skeleton asSkeleton(bool enabled) =>
      Skeleton.leaf(enabled: enabled, child: this);
}
