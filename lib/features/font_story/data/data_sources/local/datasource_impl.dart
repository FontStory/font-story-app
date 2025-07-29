part of 'datasource.dart';

@Injectable(as: FontStoryLocalDatasource)
class FontStoryLocalDatasourceImpl implements FontStoryLocalDatasource {
  final HiveManager _hiveManager;

  FontStoryLocalDatasourceImpl(this._hiveManager);

  @override
  Future<String?> getStylesJson() async {
    return _hiveManager.read<String>(boxName, stylesKey);
  }

  @override
  Future<void> saveStylesJson(String json) async {
    await _hiveManager.create<String>(boxName, stylesKey, json);
  }

  @override
  Future<String?> getFontsJson() async {
    return _hiveManager.read<String>(boxName, fontsKey);
  }

  @override
  Future<void> saveFontsJson(String json) async {
    await _hiveManager.create<String>(boxName, fontsKey, json);
  }
}
