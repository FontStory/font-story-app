part of 'font_local_datasource.dart';

@Injectable(as: FontLocalDatasource)
class FontLocalDatasourceImpl implements FontLocalDatasource {
  final HiveManager _hiveManager;

  FontLocalDatasourceImpl(this._hiveManager);
}
