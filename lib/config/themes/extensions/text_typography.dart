import 'package:flutter/material.dart' show TextStyle, ThemeExtension;

class TextTypography extends ThemeExtension<TextTypography> {
  const TextTypography({
    required this.tiny,
    required this.small,
    required this.paragraph,
    required this.heading6,
    required this.heading5,
    required this.heading4,
    required this.heading3,
    required this.heading2,
    required this.heading1,
  });

  final TextStyle tiny;
  final TextStyle small;
  final TextStyle paragraph;
  final TextStyle heading6;
  final TextStyle heading5;
  final TextStyle heading4;
  final TextStyle heading3;
  final TextStyle heading2;
  final TextStyle heading1;

  @override
  ThemeExtension<TextTypography> copyWith({
    TextStyle? tiny,
    TextStyle? small,
    TextStyle? paragraph,
    TextStyle? heading6,
    TextStyle? heading5,
    TextStyle? heading4,
    TextStyle? heading3,
    TextStyle? heading2,
    TextStyle? heading1,
  }) {
    return TextTypography(
      tiny: tiny ?? this.tiny,
      small: small ?? this.small,
      paragraph: paragraph ?? this.paragraph,
      heading6: heading6 ?? this.heading6,
      heading5: heading5 ?? this.heading5,
      heading4: heading4 ?? this.heading4,
      heading3: heading3 ?? this.heading3,
      heading2: heading2 ?? this.heading2,
      heading1: heading1 ?? this.heading1,
    );
  }

  @override
  ThemeExtension<TextTypography> lerp(
    covariant ThemeExtension<TextTypography>? other,
    double t,
  ) {
    if (other is! TextTypography) return this;
    return TextTypography(
      tiny: TextStyle.lerp(tiny, other.tiny, t)!,
      small: TextStyle.lerp(small, other.small, t)!,
      paragraph: TextStyle.lerp(paragraph, other.paragraph, t)!,
      heading6: TextStyle.lerp(heading6, other.heading6, t)!,
      heading5: TextStyle.lerp(heading5, other.heading5, t)!,
      heading4: TextStyle.lerp(heading4, other.heading4, t)!,
      heading3: TextStyle.lerp(heading3, other.heading3, t)!,
      heading2: TextStyle.lerp(heading2, other.heading2, t)!,
      heading1: TextStyle.lerp(heading1, other.heading1, t)!,
    );
  }
}
