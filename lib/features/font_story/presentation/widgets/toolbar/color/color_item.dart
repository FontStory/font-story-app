import 'package:flutter/material.dart';
import 'package:font_story/config/values/index.dart' show AppDimensions;
import 'package:font_story/core/extensions/index.dart';

class ColorItem extends StatelessWidget {
  const ColorItem({
    super.key,
    required this.color,
    required this.isSelected,
    required this.onColorSelected,
  });

  final Color color;
  final bool isSelected;
  final void Function(Color color) onColorSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => onColorSelected(color),
          child: isSelected
              ? Container(
                  width: AppDimensions.colorBox,
                  height: AppDimensions.colorBox,
                  padding: 4.all,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 3, color: color),
                    color: Colors.transparent,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                  ),
                )
              : Container(
                  width: AppDimensions.colorBox,
                  height: AppDimensions.colorBox,
                  padding: 4.all,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                ),
        ),
      ],
    );
  }
}
