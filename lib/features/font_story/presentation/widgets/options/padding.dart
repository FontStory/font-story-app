import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/spacing.dart';
import 'package:font_story/core/components/expansion.dart';
import 'package:font_story/core/extensions/index.dart';

import '../../cubit/box_decoration/box_decoration_cubit.dart';
import 'slider.dart';

class PaddingOptions extends StatelessWidget {
  const PaddingOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Expansion(
      customTitle: Padding(
        padding: 8.vertical,
        child: BlocSelector<BoxDecorationCubit, BoxDecorationState, double?>(
          selector: (state) => state.allPadding,
          builder: (context, value) => SliderOption(
            label: 'ui.padding'.tr(),
            value: value ?? 0,
            min: 0,
            max: 32,
            step: 2,
            roundValue: true,
            onChanged: (v) =>
                context.read<BoxDecorationCubit>().changeAllPadding(v),
          ),
        ),
      ),
      children: [
        Row(
          spacing: AppSpacing.xxl,
          children: [
            _buildRadiusSlider(
              context,
              'top',
              (v) => context.read<BoxDecorationCubit>().changeTopPadding(v),
            ),
            _buildRadiusSlider(
              context,
              'bottom',
              (v) => context.read<BoxDecorationCubit>().changeBottomPadding(v),
            ),
          ],
        ),
        AppSpacing.lg.verticalSpace,
        Row(
          spacing: AppSpacing.xxl,
          children: [
            _buildRadiusSlider(
              context,
              'left',
              (v) => context.read<BoxDecorationCubit>().changeLeftPadding(v),
            ),
            _buildRadiusSlider(
              context,
              'right',
              (v) => context.read<BoxDecorationCubit>().changeRightPadding(v),
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
          'top' => state.topPadding,
          'bottom' => state.bottomPadding,
          'left' => state.leftPadding,
          'right' => state.rightPadding,
          _ => 0.0,
        },
        builder: (context, value) => SliderOption(
          label: 'ui.padding_values.$corner'.tr(),
          value: value ?? 0,
          min: 0,
          max: 32,
          step: 2,
          roundValue: true,
          smallValueText: true,
          smallTitleText: true,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
