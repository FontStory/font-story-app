part of 'export_sheet.dart';

class ExportOptionButton extends StatelessWidget {
  const ExportOptionButton({super.key, required this.option});

  final ExportOption option;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: option.onTap,
        behavior: HitTestBehavior.translucent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: option.backgroundColor,
              child: option.icon,
            ),
            AppSpacing.lg.verticalSpace,
            Text(
              option.labelKey.tr(),
              textDirection: context.locale.languageCode == 'fa'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
            ),
          ],
        ),
      ),
    );
  }
}
