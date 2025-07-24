import 'package:easy_localization/easy_localization.dart'
    show BuildContextEasyLocalizationExtension, StringTranslateExtension;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_story/config/routes/routes.dart';
import 'package:font_story/config/values/index.dart';
import 'package:font_story/core/components/buttons/button.dart';
import 'package:font_story/core/constants/enums/status.dart';
import 'package:font_story/core/extensions/index.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'core/common/sync/sync_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (context.read<SyncCubit>().state == DataStatus.success) {
          context.pushAndRemoveAll(AppRoutePaths.main);
        }
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.splash,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * 0.85,
                ),
                child: Image.asset('assets/images/splash.png'),
              ),
              const Spacer(),
              BlocConsumer<SyncCubit, DataStatus>(
                listener: (context, state) {
                  if (state == DataStatus.success) {
                    if (_animationController.isCompleted) {
                      context.pushAndRemoveAll(AppRoutePaths.main);
                    }
                  }
                },
                builder: (context, state) {
                  if (state == DataStatus.error) {
                    return Padding(
                      padding: AppSpacing.xl.horizontal,
                      child: AppButton.secondary(
                        context: context,
                        label: 'ui.try_again'.tr(),
                        isExpanded: true,
                        appButtonSize: AppButtonSize.large,
                        onTap: () => context.read<SyncCubit>().syncData(),
                      ),
                    );
                  }
                  return Column(
                    children: [
                      RepaintBoundary(
                        child: LoadingAnimationWidget.progressiveDots(
                          color: AppPalette.white,
                          size: 32,
                        ),
                      ),
                      AppSpacing.md.verticalSpace,
                      Text(
                        'ui.syncing'.tr(),
                        style: context.typography.paragraph.copyWith(
                          color: AppPalette.white,
                        ),
                        textDirection: context.locale.languageCode == 'fa'
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                      ),
                    ],
                  );
                },
              ),
              kBottomNavigationBarHeight.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
