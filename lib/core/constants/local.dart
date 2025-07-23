import '../common/localization/language.dart';

const kTranslatesPath = 'assets/translations';

final kFallbackLocale = Language.english.locale;

final kSupportedLocales = Language.values.map((lang) => lang.locale).toList();
