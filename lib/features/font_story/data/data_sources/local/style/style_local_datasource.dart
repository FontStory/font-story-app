import 'package:flutter/services.dart' show rootBundle;
import 'package:font_story/core/error/local_exception.dart';
import 'package:font_story/core/helpers/log.dart';
import 'package:font_story/core/services/hive_manager.dart';
import 'package:injectable/injectable.dart';

part 'style_local_datasource_impl.dart';

abstract interface class StyleLocalDatasource {
  Future<String> getStylesJson();
}
