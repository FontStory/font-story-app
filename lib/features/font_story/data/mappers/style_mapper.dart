import 'package:font_story/core/extensions/string.dart';
import 'package:font_story/core/helpers/parsers/box_decoration_parser.dart';
import 'package:font_story/core/helpers/parsers/text_style_parser.dart';

import '../../domain/entities/style.dart';
import '../models/style.dart';

extension RelativePositionMapper on RelativePositionModel {
  RelativePosition toEntity() => RelativePosition(dx: dx, dy: dy);
}

extension TextLayerStyleMapper on TextLayerStyleModel {
  TextLayerStyle toEntity() {
    final style = TextStyleParser.parseTextStyle(this.style);
    if (style == null) {
      throw const FormatException('TextLayerStyle has no valid style.');
    }
    return TextLayerStyle(style: style, position: position?.toEntity());
  }
}

extension TextEffectStyleMapper on TextEffectStyleModel {
  TextEffectStyle toEntity() => TextEffectStyle(
    id: name.hashCode,
    name: name,
    thumbnail: thumbnail,
    defaultTextColor: (defaultTextColor)?.parseColor,
    defaultStyleColor: (defaultStyleColor)?.parseColor,
    baseTextStyle: TextStyleParser.parseTextStyle(baseTextStyle),
    effectStyle: TextStyleParser.parseTextStyle(effectStyle),
    layeredTextStyles: layeredTextStyles?.map((e) => e.toEntity()).toList(),
    boxDecoration: BoxDecorationParser.parseBoxDecoration(
      containerDecoration?['boxDecoration'],
    ),
    boxPadding: BoxDecorationParser.parsePadding(
      containerDecoration?['padding'],
    ),
    topImage: topImage,
    bottomImage: bottomImage,
    canChangeColor: canChangeColor ?? false,
    canChangeDecoration: canChangeDecoration ?? false,
  );
}

@pragma('vm:entry-point')
List<TextEffectStyle> mapTextEffectStyles(List<TextEffectStyleModel> models) {
  return models.map((m) => m.toEntity()).toList();
}
