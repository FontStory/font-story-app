import 'package:font_story/core/helpers/parser.dart';

import '../../domain/entities/style.dart';
import '../models/style.dart';

extension RelativePositionMapper on RelativePositionModel {
  RelativePosition toEntity() => RelativePosition(dx: dx, dy: dy);
}

extension TextLayerStyleMapper on TextLayerStyleModel {
  TextLayerStyle toEntity() {
    final style = StyleParser.parseTextStyle(this.style);
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
    defaultTextColor: StyleParser.parseColor(defaultTextColor),
    defaultStyleColor: StyleParser.parseColor(defaultStyleColor),
    canChangeColor: canChangeColor ?? false,
    baseTextStyle: StyleParser.parseTextStyle(baseTextStyle),
    effectStyle: StyleParser.parseTextStyle(effectStyle),
    layeredTextStyles: layeredTextStyles?.map((e) => e.toEntity()).toList(),
  );
}

extension StyleListMapper on List<TextEffectStyleModel> {
  List<TextEffectStyle> toEntityList() => map((m) => m.toEntity()).toList();
}
