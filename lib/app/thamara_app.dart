import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/routing/app_router.dart';
import '../core/routing/routes.dart';

class Thamara extends StatelessWidget {
  const Thamara({super.key});
  static final GlobalKey<NavigatorState> appNavigatorKey =
  GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: appNavigatorKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          onGenerateRoute: AppRouter().generateRoute,
          initialRoute: Routes.splashView,
          themeMode: ThemeMode.dark,
        );
      },
    );
  }
}