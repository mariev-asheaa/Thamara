import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thamara/core/routing/routes.dart';
import 'package:thamara/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:thamara/features/auth/login/presentation/login_view.dart';
import 'package:thamara/features/auth/sign_up/presentation/cubit/register_cubit.dart';
import 'package:thamara/features/auth/sign_up/presentation/sign_up_view.dart';
import 'package:thamara/features/splash/presentation/splash_view.dart';

import '../../features/auth/otp/data/arguments/otp_argument.dart';
import '../../features/auth/otp/presentation/cubits/otp_cubit.dart';
import '../../features/auth/otp/presentation/otp_view.dart';
import '../../features/auth/reset_password/data/arguments/password_arguments.dart';
import '../../features/auth/reset_password/presentation/cubits/new_password_cubit/new_password_cubit.dart';
import '../../features/auth/reset_password/presentation/cubits/reset_password_cubit/reset_password_cubit.dart';
import '../../features/auth/reset_password/presentation/views/passwprd_recovery_view.dart';
import '../../features/auth/reset_password/presentation/views/reset_password_view.dart';
import '../../features/home/presentation/cubit/ai_feature_cubit.dart';
import '../../features/layout/presentation/main_layout_view.dart';
import '../../features/plant_details/presentation/cubit/plant_details_cubit.dart';
import '../../features/plant_details/presentation/views/plant_details_view.dart';
import '../../features/settings/presentation/cubits/edit_profile_cubit/edit_profile_cubit.dart';
import '../../features/settings/presentation/cubits/profile_cubit/profile_cubit.dart';
import '../../features/settings/presentation/views/personal_information_view.dart';
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
               create: (context) => getIt<LoginCubit>()..locationService.getLocation(),
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

        case Routes.otpView:
            final argument = arguments as OTPArgument;
            return _buildRoute(
              builder: (_) => BlocProvider(
                create: (context) => getIt<OTPCubit>(),
                child: OtpView(argument: argument),
              ),
            );

          case Routes.resetPasswordView:
            return _buildRoute(
              builder: (_) => BlocProvider(
                create: (context) => getIt<ResetPasswordCubit>(),
                child: PasswordRecoveryView(),
              ),
            );
      case Routes.newPasswordView:
        final argument = arguments as PasswordArguments;
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<NewPasswordCubit>(),
            child: ResetPasswordView(argument: argument),
          ),
        );
      case Routes.homeView:
        return _buildRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<NewPasswordCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<AiFeatureCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<ProfileCubit>()..getProfileInfo(),
              ),
              BlocProvider(
                create: (context) => getIt<PlantDetailsCubit>()..getAllPlants(),
              ),
            ],
            child: const MainLayoutView(),
          ),
        );
      case Routes.profileView:
        return _buildRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<ProfileCubit>()..getProfileInfo(),
              ),
              BlocProvider(
                create: (context) => getIt<EditProfileCubit>(),
              ),
            ],
            child: const PersonalInformationView(),
          ),
        );
      case Routes.plantDetailsView:
        final plantId = arguments as int;
        return _buildRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<PlantDetailsCubit>(),
            child: PlantDetailsView(plantId: plantId),
          ),
        );
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