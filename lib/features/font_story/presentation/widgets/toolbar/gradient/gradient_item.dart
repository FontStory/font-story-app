import 'package:flutter/material.dart';
import 'package:font_story/config/values/index.dart' show AppDimensions;
import 'package:font_story/core/extensions/index.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart'
    show GradientBoxBorder;

class GradientItem extends StatelessWidget {
  const GradientItem({
    super.key,
    required this.gradient,
    this.isSelected = false,
    required this.onGradientSelected,
  });

  final Gradient gradient;
  final bool isSelected;
  final void Function(Gradient gradient) onGradientSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => onGradientSelected(gradient),
          child: isSelected
              ? Container(
                width: AppDimensions.colorBox,
                height: AppDimensions.colorBox,
                padding: 4.all,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: GradientBoxBorder(gradient: gradient, width: 3),
                  color: Colors.transparent,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: gradient,
                  ),
                ),
              )
              : Container(
                  width: AppDimensions.colorBox,
                  height: AppDimensions.colorBox,
                  padding: 4.all,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: gradient,
                  ),
                ),
        ),
      ],
    );
  }
}
