import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../language.dart';

class LocalizationCubit extends HydratedCubit<Language> {
  LocalizationCubit() : super(Language.english);

  void changeLanguage(Language newLanguage) => emit(newLanguage);

  @override
  Language? fromJson(Map<String, dynamic> json) {
    return Language.values[json['selectedLanguage'] as int];
  }

  @override
  Map<String, dynamic>? toJson(Language state) {
    return {'selectedLanguage': state.index};
  }
}
