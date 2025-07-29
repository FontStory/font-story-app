import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/values/spacing.dart';
import 'package:font_story/core/common/localization/language.dart';
import 'package:font_story/core/extensions/index.dart';

import '../../common/localization/cubit/localization_cubit.dart';

class LanguageSheet extends StatelessWidget {
  const LanguageSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Language.values.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: AppSpacing.xl.horizontal,
      itemBuilder: (context, index) {
        final language = Language.values[index];

        return Theme(
          data: context.theme.copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: RadioListTile<Language>(
            value: language,
            groupValue: context.watch<LocalizationCubit>().state,
            contentPadding: EdgeInsets.zero,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  language.nativeName,
                  style: context.typography.heading6.copyWith(
                    color: context.palette.onSurface,
                  ),
                ),
                Text(
                  language.name,
                  style: context.typography.paragraph.copyWith(
                    color: context.palette.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
            onChanged: (Language? value) {
              if (value != null) {
                context.read<LocalizationCubit>().changeLanguage(value);
                context.pop();
              }
            },
          ),
        );
      },
    );
  }
}
