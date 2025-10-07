part of 'style_remote_datasource.dart';

@Injectable(as: StyleRemoteDatasource)
class StyleDatasourceImpl implements StyleRemoteDatasource {
  final DioService _dioService;

  StyleDatasourceImpl(this._dioService);

  @override
  Future<String> fetchStylesJson() async {
    try {
      final response = await _dioService.get(stylesUrl);
      if (response.statusCode != 200) {
        throw ApiException(code: response.statusCode);
      }
      return response.data is String
          ? response.data as String
          : jsonEncode(response.data);
    } on DioException catch (e) {
      LogManager.instance.e('Failed to fetch styles JSON', e, e.stackTrace);
      throw const ApiException(message: 'Could not fetch styles JSON.');
    }
  }
}
