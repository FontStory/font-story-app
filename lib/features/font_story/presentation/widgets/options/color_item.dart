import 'package:flutter/material.dart';
import 'package:font_story/config/values/dimensions.dart';
import 'package:font_story/core/extensions/index.dart';

class ColorOptionItem extends StatelessWidget {
  const ColorOptionItem({
    super.key,
    required this.color,
    this.isSelected = false,
    required this.onColorSelected,
  });

  final Color color;
  final bool isSelected;
  final void Function(Color color) onColorSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onColorSelected(color),
      child: isSelected
          ? Container(
              width: AppDimensions.iconLarge,
              height: AppDimensions.iconLarge,
              padding: 4.all,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: color),
                color: Colors.transparent,
              ),
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              ),
            )
          : Container(
              width: AppDimensions.iconLarge,
              height: AppDimensions.iconLarge,
              padding: 4.all,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
    );
  }
}
