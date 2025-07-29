import 'package:flutter/material.dart';
import 'package:font_story/config/values/index.dart';
import 'package:font_story/core/extensions/index.dart';

class ColorPickerItem extends StatelessWidget {
  const ColorPickerItem({
    super.key,
    required this.defaultColor,
    required this.onColorChanged,
  });

  final Color defaultColor;
  final Function(Color) onColorChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            context.showColorPickerDialog(
              defaultColor: defaultColor,
              onColorChanged: onColorChanged,
            );
          },
          child: Container(
            width: AppDimensions.colorBox,
            height: AppDimensions.colorBox,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/color_wheel.png'),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}