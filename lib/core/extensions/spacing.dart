import 'package:flutter/material.dart' show SizedBox;

extension SpacingExtension on num {
  SizedBox get verticalSpace => SizedBox(height: toDouble());

  SizedBox get horizontalSpace => SizedBox(width: toDouble());
}
