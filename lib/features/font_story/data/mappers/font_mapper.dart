import 'package:font_story/core/extensions/string.dart';

import '../../domain/entities/font.dart';
import '../models/font.dart';

extension FontMapper on FontModel {
  FontEntity toEntity() {
    return FontEntity(
      id: id,
      title: title,
      fontFamily: fontFamily,
      path: path,
      language: language?.capitalize(),
    );
  }
}

extension FontEntityMapper on FontEntity {
  FontModel toModel() {
    return FontModel(
      id: id,
      title: title,
      fontFamily: fontFamily,
      path: path,
      language: language,
    );
  }
}

extension FontListMapper on List<FontModel> {
  List<FontEntity> toEntityList() => map((m) => m.toEntity()).toList();
}
