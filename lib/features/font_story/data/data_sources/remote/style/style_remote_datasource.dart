import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:font_story/core/constants/api.dart';
import 'package:font_story/core/error/api_exception.dart';
import 'package:font_story/core/helpers/log.dart';
import 'package:font_story/core/services/api/dio.dart';
import 'package:injectable/injectable.dart';

part 'style_remote_datasource_impl.dart';

abstract interface class StyleRemoteDatasource {
  Future<String> fetchStylesJson();
}
