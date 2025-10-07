import 'dart:ui' show Color;

extension StringExtension on String {
  String get capitalize {
    if (isEmpty) {
      return "";
    }
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  /// Parses a hex string (e.g., "#RRGGBB" or "#AARRGGBB") into a [Color].
  Color? get parseColor {
    if (isEmpty) return null;
    final colorString = replaceFirst('#', '');
    if (colorString.length == 6) {
      return Color(int.parse('ff$colorString', radix: 16));
    } else if (colorString.length == 8) {
      return Color(int.parse(colorString, radix: 16));
    }
    return null;
  }

  static const keshideChar = '\u0640';

  // حروف مجاز برای کشیدگی
  static const keshideAllowed = [
    'ب',
    'پ',
    'ت',
    'ث',
    'ج',
    'چ',
    'ح',
    'خ',
    'س',
    'ش',
    'ص',
    'ض',
    'ط',
    'ظ',
    'ف',
    'ق',
    'ک',
    'گ',
    'ل',
    'م',
    'ن',
    'ی',
  ];

  /// اضافه کردن کشیدگی بر اساس spacing
  String applyKeshide(double spacing) {
    if (spacing <= 0) return this;

    final buffer = StringBuffer();
    for (int i = 0; i < length; i++) {
      buffer.write(this[i]);
      if (i < length - 1 &&
          keshideAllowed.contains(this[i]) &&
          this[i + 1] != ' ') {
        buffer.write(keshideChar * spacing.toInt());
      }
    }
    return buffer.toString();
  }

  /// تنظیم کشیدگی روی متن موجود (کم یا زیاد کردن)
  String adjustKeshide(double spacing) {
    final regex = RegExp('$keshideChar+');
    final targetLength = spacing.toInt();

    return replaceAllMapped(regex, (match) {
      if (targetLength <= 0) {
        return ''; // حذف کشیدگی
      } else {
        return keshideChar * targetLength; // تنظیم دقیق
      }
    });
  }
}
