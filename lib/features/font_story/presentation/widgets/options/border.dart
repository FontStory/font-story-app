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

class BorderWidthOptions extends StatelessWidget {
  const BorderWidthOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Expansion(
      customTitle: Padding(
        padding: 8.vertical,
        child: BlocSelector<BoxDecorationCubit, BoxDecorationState, double?>(
          selector: (state) => state.allBorderWidth,
          builder: (context, value) => SliderOption(
            label: 'ui.border'.tr(),
            value: value ?? 0,
            min: 0,
            max: 20,
            step: 1,
            roundValue: true,
            onChanged: (v) =>
                context.read<BoxDecorationCubit>().changeAllBorderWidth(v),
          ),
        ),
      ),
      children: [
        AppSpacing.sm.verticalSpace,
        BlocSelector<BoxDecorationCubit, BoxDecorationState, Color?>(
          selector: (state) => state.borderColor,
          builder: (context, borderColor) {
            return Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: [
                ColorPickerItem(
                  defaultColor: borderColor ?? Colors.black,
                  isSmall: true,
                  onColorChanged: (color) => context
                      .read<BoxDecorationCubit>()
                      .changeBorderColor(color),
                ),
                ...List.generate(
                  AppPalette.colorOptionList.length,
                  (index) => ColorOptionItem(
                    color: AppPalette.colorOptionList[index],
                    isSelected: borderColor == AppPalette.colorOptionList[index],
                    onColorSelected: (color) => context
                        .read<BoxDecorationCubit>()
                        .changeBorderColor(color),
                  ),
                ),
              ],
            );
          },
        ),
        AppSpacing.xl.verticalSpace,
        Row(
          spacing: AppSpacing.xxl,
          children: [
            _buildSideSlider(
              context,
              'top',
              (v) => context.read<BoxDecorationCubit>().changeTopBorderWidth(v),
            ),
            _buildSideSlider(
              context,
              'bottom',
              (v) =>
                  context.read<BoxDecorationCubit>().changeBottomBorderWidth(v),
            ),
          ],
        ),
        AppSpacing.lg.verticalSpace,
        Row(
          spacing: AppSpacing.xxl,
          children: [
            _buildSideSlider(
              context,
              'left',
              (v) =>
                  context.read<BoxDecorationCubit>().changeLeftBorderWidth(v),
            ),
            _buildSideSlider(
              context,
              'right',
              (v) =>
                  context.read<BoxDecorationCubit>().changeRightBorderWidth(v),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSideSlider(
    BuildContext context,
    String side,
    ValueChanged<double> onChanged,
  ) {
    return Expanded(
      child: BlocSelector<BoxDecorationCubit, BoxDecorationState, double?>(
        selector: (state) => switch (side) {
          'top' => state.topBorderWidth,
          'bottom' => state.bottomBorderWidth,
          'left' => state.leftBorderWidth,
          'right' => state.rightBorderWidth,
          _ => 0.0,
        },
        builder: (context, value) => SliderOption(
          label: 'ui.border_width.$side'.tr(),
          value: value ?? 0,
          min: 0,
          max: 20,
          step: 1,
          roundValue: true,
          smallValueText: true,
          smallTitleText: true,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
