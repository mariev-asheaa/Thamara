import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/widgets/app_logo.dart';
import 'package:thamara/core/widgets/thamara_text.dart';

import '../../../core/extentions/navigation.dart';
import '../../../core/routing/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        context.pushAndRemoveUntilWithNamed(Routes.loginView);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(tag: 'logo', child: AppLogo())
                .animate()
                .scale(
                  delay: 500.ms,
                  begin: const Offset(1.66, 1.66),
                  end: const Offset(1, 1),
                  duration: 1000.ms,
                  curve: Curves.easeInOut,
                )
                .moveY(
                  delay: 500.ms,
                  begin: 0,
                  end: -80.h,
                  duration: 1000.ms,
                  curve: Curves.easeInOut,
                ),

            SizedBox(height: 20.h),

            Hero(tag: 'app_logo_text', child: ThamaraText())
                .animate(delay: 600.ms)
                .fadeIn(duration: 400.ms)
                .moveY(
                  begin: -100.h,
                  end: -80.h,
                  duration: 600.ms,
                  curve: Curves.easeOut,
                ),
          ],
        ),
      ),
    );
  }
}
