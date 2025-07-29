import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/index.dart';
import 'package:font_story/core/common/localization/cubit/localization_cubit.dart';
import 'package:font_story/core/common/theme/theme_cubit.dart';
import 'package:font_story/core/components/buttons/button.dart';
import 'package:font_story/core/components/buttons/icon_button.dart';
import 'package:font_story/core/components/bottom_sheets/language_sheet.dart';
import 'package:font_story/core/constants/global.dart';
import 'package:font_story/core/extensions/index.dart';
import 'package:font_story/core/helpers/launch_url.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.onExportTap});

  final VoidCallback onExportTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: AppSpacing.md,
      children: [
        AppIconButton.tonal(
          context: context,
          icon: Iconsax.coffee_copy,
          onPressed: () {
            if (context.locale.languageCode == 'fa') {
              launchAppUrl(coffeeteUrl);
            } else {
              launchAppUrl(buyMeCoffeeUrl);
            }
          },
        ),
        Spacer(),
        AppIconButton.tonal(
          context: context,
          icon: Iconsax.global_copy,
          onPressed: () {
            context.showCustomBottomSheet(
              content: BlocProvider.value(
                value: context.read<LocalizationCubit>(),
                child: LanguageSheet(),
              ),
            );
          },
        ),
        AppIconButton.tonal(
          context: context,
          iconWidget: Container(
            width: AppDimensions.icon,
            height: AppDimensions.icon,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(AppRadius.s),
              border: Border.all(width: 1, color: context.palette.onSurface),
              gradient: context.watch<ThemeCubit>().state.gradient,
            ),
          ),
          onPressed: () => context.read<ThemeCubit>().changeToNextTheme(),
        ),
        AppButton.secondary(
          context: context,
          label: 'ui.export'.tr(),
          onTap: onExportTap,
        ),
      ],
    );
  }
}
