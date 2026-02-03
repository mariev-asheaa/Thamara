import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thamara/core/routing/routes.dart';
import 'package:thamara/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:thamara/features/auth/login/presentation/login_view.dart';
import 'package:thamara/features/auth/sign_up/presentation/cubit/register_cubit.dart';
import 'package:thamara/features/auth/sign_up/presentation/sign_up_view.dart';
import 'package:thamara/features/splash/presentation/splash_view.dart';

import '../dependency_injection/di.dart';
import '../framework/navigation_animation.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.splashView:
        return _buildRoute(
            builder: (_) => const SplashView()
        );
      case Routes.loginView:
        return _buildRoute(
            builder: (_) =>  BlocProvider(
               create: (context) => getIt<LoginCubit>(),
              child: LoginView(),
               )
        );
      case Routes.registerView:
        return _buildRoute(
            builder: (_) =>  BlocProvider(
           create: (context) => getIt<RegisterCubit>(),
                 child: SignUpView(),
                )
        );

        //case Routes.otpView:
    //         final argument = arguments as OTPArgument;
    //         return _buildRoute(
    //           builder: (_) => BlocProvider(
    //             create: (context) => getIt<OTPCubit>(),
    //             child: OTPView(argument: argument),
    //           ),
    //         );
    //
    //       case Routes.resetPasswordView:
    //         return _buildRoute(
    //           builder: (_) => BlocProvider(
    //             create: (context) => getIt<ResetPasswordCubit>(),
    //             child: ResetPasswordView(),
    //           ),
    //         );
      default:
        return _buildRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
  PageRoute _buildRoute({required WidgetBuilder builder}) {
    return Platform.isAndroid
        ? FadePageRoute(builder: builder)
        : MaterialPageRoute(builder: builder);
  }
}