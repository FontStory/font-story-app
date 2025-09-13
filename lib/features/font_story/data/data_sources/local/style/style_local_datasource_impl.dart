part of 'style_local_datasource.dart';

@Injectable(as: StyleLocalDatasource)
class StyleLocalDatasourceImpl implements StyleLocalDatasource {
  final HiveManager _hiveManager;

  StyleLocalDatasourceImpl(this._hiveManager);

  @override
  Future<String> getStylesJson() async {
    try {
      /// Load styles from assets for testing
      final jsonString = await rootBundle.loadString('assets/test_style.json');
      return jsonString;
    } catch (e) {
      LogManager.instance.e('Failed to get styles JSON', e);
      throw LocaleException(message: 'Could not get styles JSON.');
    }
  }
}
