import 'package:flutter/material.dart' show DecorationImage, ColorFilter;

extension DecorationImageCopy on DecorationImage {
  DecorationImage copyWith({ColorFilter? colorFilter}) {
    return DecorationImage(
      image: image,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      scale: scale,
      filterQuality: filterQuality,
      colorFilter: colorFilter ?? this.colorFilter,
    );
  }
}
