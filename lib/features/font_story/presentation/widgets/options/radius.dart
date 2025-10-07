import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/spacing.dart';
import 'package:font_story/core/components/expansion.dart';
import 'package:font_story/core/extensions/index.dart';

import '../../cubit/box_decoration/box_decoration_cubit.dart';
import 'slider.dart';

class BorderRadiusOptions extends StatelessWidget {
  const BorderRadiusOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Expansion(
      customTitle: Padding(
        padding: 8.vertical,
        child: BlocSelector<BoxDecorationCubit, BoxDecorationState, double?>(
          selector: (state) => state.allRadius,
          builder: (context, value) => SliderOption(
            label: 'ui.radius'.tr(),
            value: value ?? 0,
            min: 0,
            max: 56,
            step: 4,
            roundValue: true,
            onChanged: (v) =>
                context.read<BoxDecorationCubit>().changeAllBorderRadius(v),
          ),
        ),
      ),
      children: [
        Row(
          spacing: AppSpacing.xxl,
          children: [
            _buildRadiusSlider(
              context,
              'top_left',
              (v) => context.read<BoxDecorationCubit>().changeTopLeftRadius(v),
            ),
            _buildRadiusSlider(
              context,
              'top_right',
              (v) => context.read<BoxDecorationCubit>().changeTopRightRadius(v),
            ),
          ],
        ),
        AppSpacing.lg.verticalSpace,
        Row(
          spacing: AppSpacing.xxl,
          children: [
            _buildRadiusSlider(
              context,
              'bottom_left',
              (v) =>
                  context.read<BoxDecorationCubit>().changeBottomLeftRadius(v),
            ),
            _buildRadiusSlider(
              context,
              'bottom_right',
              (v) =>
                  context.read<BoxDecorationCubit>().changeBottomRightRadius(v),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRadiusSlider(
    BuildContext context,
    String corner,
    ValueChanged<double> onChanged,
  ) {
    return Expanded(
      child: BlocSelector<BoxDecorationCubit, BoxDecorationState, double?>(
        selector: (state) => switch (corner) {
          'top_left' => state.topLeftRadius,
          'top_right' => state.topRightRadius,
          'bottom_left' => state.bottomLeftRadius,
          'bottom_right' => state.bottomRightRadius,
          _ => 0.0,
        },
        builder: (context, value) => SliderOption(
          label: 'ui.border_radius.$corner'.tr(),
          value: value ?? 0,
          min: 0,
          max: 56,
          step: 4,
          roundValue: true,
          smallValueText: true,
          smallTitleText: true,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
