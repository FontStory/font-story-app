import 'dart:ui' show Locale;

enum Language {
  english(Locale('en', 'US'), 'English', 'English', 'Poppins'),
  persian(Locale('fa', 'IR'), 'Persian', 'فارسی', 'Vazirmatn');

  final Locale locale;
  final String name;
  final String nativeName;
  final String fontFamily;

  const Language(this.locale, this.name, this.nativeName, this.fontFamily);
}
