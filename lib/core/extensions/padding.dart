import 'package:flutter/widgets.dart' show EdgeInsets, EdgeInsetsDirectional;

extension PaddingExtension on num {
  EdgeInsets get all => EdgeInsets.all(toDouble());

  EdgeInsets get top => EdgeInsets.only(top: toDouble());

  EdgeInsets get bottom => EdgeInsets.only(bottom: toDouble());

  EdgeInsets get left => EdgeInsets.only(left: toDouble());

  EdgeInsets get right => EdgeInsets.only(right: toDouble());

  EdgeInsetsDirectional get end => EdgeInsetsDirectional.only(end: toDouble());

  EdgeInsetsDirectional get start =>
      EdgeInsetsDirectional.only(start: toDouble());

  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: toDouble());

  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: toDouble());
}
