import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/palette.dart';
import 'package:font_story/config/values/spacing.dart';
import 'package:font_story/core/components/expansion.dart';
import 'package:font_story/core/extensions/index.dart';

import '../../cubit/box_decoration/box_decoration_cubit.dart';
import '../toolbar/color/color_picker_item.dart';
import 'color_item.dart';
import 'slider.dart';

class ShadowOptions extends StatelessWidget {
  const ShadowOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Expansion(
      customTitle: Padding(
        padding: 8.vertical,
        child: BlocSelector<BoxDecorationCubit, BoxDecorationState, double?>(
          selector: (state) => state.shadowSpreadRadius,
          builder: (context, value) => SliderOption(
            label: 'ui.shadow'.tr(),
            value: value ?? 0,
            min: 0,
            max: 10,
            step: 1,
            roundValue: true,
            onChanged: (v) =>
                context.read<BoxDecorationCubit>().changeShadowSpreadRadius(v),
          ),
        ),
      ),
      children: [
        AppSpacing.sm.verticalSpace,
        BlocSelector<BoxDecorationCubit, BoxDecorationState, Color?>(
          selector: (state) => state.shadowColor,
          builder: (context, shadowColor) {
            return Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: [
                ColorPickerItem(
                  defaultColor: shadowColor ?? Colors.black,
                  isSmall: true,
                  onColorChanged: (color) => context
                      .read<BoxDecorationCubit>()
                      .changeShadowColor(color),
                ),
                ...List.generate(
                  AppPalette.colorOptionList.length,
                  (index) => ColorOptionItem(
                    color: AppPalette.colorOptionList[index],
                    isSelected:
                        shadowColor == AppPalette.colorOptionList[index],
                    onColorSelected: (color) => context
                        .read<BoxDecorationCubit>()
                        .changeShadowColor(color),
                  ),
                ),
              ],
            );
          },
        ),
        AppSpacing.xl.verticalSpace,
        BlocSelector<BoxDecorationCubit, BoxDecorationState, double?>(
          selector: (state) => state.shadowBlurRadius,
          builder: (context, value) => SliderOption(
            label: 'ui.shadow_values.blur_radius'.tr(),
            value: value ?? 0,
            min: 0,
            max: 10,
            step: 1,
            roundValue: true,
            smallValueText: true,
            smallTitleText: true,
            onChanged: (v) =>
                context.read<BoxDecorationCubit>().changeShadowBlurRadius(v),
          ),
        ),

        AppSpacing.lg.verticalSpace,
        BlocSelector<BoxDecorationCubit, BoxDecorationState, Offset?>(
          selector: (state) => state.shadowOffset,
          builder: (context, offset) {
            final dx = offset?.dx ?? 0;
            final dy = offset?.dy ?? 0;
            return Row(
              spacing: AppSpacing.xxl,
              children: [
                _buildOffsetSlider(
                  label: 'ui.shadow_values.x_offset'.tr(),
                  value: dx,
                  onChanged: (v) => context
                      .read<BoxDecorationCubit>()
                      .changeShadowOffset(x: v, y: dy),
                ),
                _buildOffsetSlider(
                  label: 'ui.shadow_values.y_offset'.tr(),
                  value: dy,
                  onChanged: (v) => context
                      .read<BoxDecorationCubit>()
                      .changeShadowOffset(x: dx, y: v),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildOffsetSlider({
    required String label,
    required double value,
    required void Function(double) onChanged,
  }) {
    return Expanded(
      child: SliderOption(
        label: label,
        value: value,
        min: -6,
        max: 6,
        step: 1,
        roundValue: true,
        smallValueText: true,
        smallTitleText: true,
        onChanged: onChanged,
      ),
    );
  }
}
