part of 'font_remote_datasource.dart';

@Injectable(as: FontRemoteDatasource)
class FontDatasourceImpl implements FontRemoteDatasource {
  final DioService _dioService;

  FontDatasourceImpl(this._dioService);

  @override
  Future<String> fetchFontsJson() async {
    try {
      final response = await _dioService.get(fontsUrl);
      if (response.statusCode != 200) {
        throw ApiException(code: response.statusCode);
      }
      return response.data is String
          ? response.data as String
          : jsonEncode(response.data);
    } on DioException catch (e) {
      LogManager.instance.e('Failed to fetch fonts JSON', e, e.stackTrace);
      throw ApiException(message: 'Could not fetch fonts JSON.');
    }
  }

  @override
  Future<Uint8List> downloadFont(String url) async {
    try {
      final response = await _dioService.download(url);
      return Uint8List.fromList(response.data!);
    } on DioException catch (e) {
      LogManager.instance.e('Font download failed from $url', e, e.stackTrace);
      throw ApiException(
        message: 'Could not download font file.',
        code: e.response?.statusCode,
      );
    }
  }
}
