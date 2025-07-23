part of 'main.dart';

class FontStory extends StatelessWidget {
  const FontStory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocalizationCubit, Language>(
      listener: (context, state) {
        context.setLocale(state.locale);
        context.read<ThemeCubit>().updateFontFamily(state.fontFamily);
      },
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Font Story',
            theme: theme.themeData,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            initialRoute: AppRoutes.initialRoute,
            routes: AppRoutes.routes,
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.ltr,
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
