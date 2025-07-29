import 'package:font_story/core/constants/database.dart';
import 'package:font_story/core/services/hive_manager.dart';
import 'package:injectable/injectable.dart';

part 'datasource_impl.dart';

abstract interface class FontStoryLocalDatasource {
  Future<String?> getStylesJson();
  Future<void> saveStylesJson(String json);
  Future<String?> getFontsJson();
  Future<void> saveFontsJson(String json);
}
