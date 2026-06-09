import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/extentions/navigation.dart';
import '../../../../../core/extentions/show_toast.dart';
import '../../../../../core/services/firebase_service.dart';
import '../../../../../core/services/Location_Service.dart';
import '../../../../../core/services/social_auth_service.dart';
import '../../../../../core/locals/shared_preferences.dart';
import '../../../../../core/models/user_model.dart';
import '../../../../../core/routing/routes.dart';
import '../../data/params/login_params.dart';
import '../../data/params/social_auth_params.dart';
import '../../data/repos/login_repo.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepository;
  final SharedPrefServices sharedPrefServices;
  final FirebaseService firebaseService;
  final LocationService locationService;

  LoginCubit({
    required this.loginRepository,
    required this.sharedPrefServices,
    required this.firebaseService,
    required this.locationService,
  }) : super(LoginInitial());

  final GlobalKey<FormState> loginFormKeyController = GlobalKey<FormState>();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    emit(LoginLoadingState());

    final String? fcmToken = await getFcmToken();
    double? lat;
    double? long;
    try {
      final position = locationService.currentPosition;
      if (position != null) {
        lat = position.latitude;
        long = position.longitude;
      }
    } catch (_) {}

    // 3. Send all data in a single login request
    final result = await loginRepository.login(
      param: LoginParams(
        email: loginEmailController.text,
        password: loginPasswordController.text,
        fcmToken: fcmToken,
        latitude: lat,
        longitude: long,
      ),
    );

    result.fold(
      (failure) {
        if (context.mounted) {
          context.showToast(failure.errMessage, isError: true);
        }
        emit(LoginFailureState(errorMessage: failure.errMessage));
      },
      (authModel) {
        if (context.mounted) {
          _saveTokenAndNavigate(context: context, authModel: authModel);
        }
      },
    );
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    emit(LoginLoadingState());
    try {
      final socialAuthService = SocialAuthService.instance;
      final result = await socialAuthService.signInWithGoogle();
      if (result == null) {
        emit(LoginInitial());
        return;
      }
      await _socialLogin(context: context, authResult: result);
    } catch (e) {
      if (context.mounted) {
        context.showToast(e.toString(), isError: true);
      }
      emit(LoginFailureState(errorMessage: e.toString()));
    }
  }

  Future<void> loginWithFacebook(BuildContext context) async {
    emit(LoginLoadingState());
    try {
      final socialAuthService = SocialAuthService.instance;
      final result = await socialAuthService.signInWithFacebook();
      if (result == null) {
        emit(LoginInitial());
        return;
      }
      await _socialLogin(context: context, authResult: result);
    } catch (e) {
      if (context.mounted) {
        context.showToast(e.toString(), isError: true);
      }
      emit(LoginFailureState(errorMessage: e.toString()));
    }
  }

  Future<void> _socialLogin({
    required BuildContext context,
    required SocialAuthResult authResult,
  }) async {
    final String? fcmToken = await getFcmToken();
    double? lat;
    double? long;
    try {
      final position = locationService.currentPosition;
      if (position != null) {
        lat = position.latitude;
        long = position.longitude;
      }
    } catch (_) {}

    final result = await loginRepository.socialLogin(
      param: SocialAuthParams(
        provider: authResult.provider,
        accessToken: authResult.token,
        fcmToken: fcmToken,
        latitude: lat,
        longitude: long,
      ),
    );

    result.fold(
      (failure) {
        if (context.mounted) {
          context.showToast(failure.errMessage, isError: true);
        }
        emit(LoginFailureState(errorMessage: failure.errMessage));
      },
      (authModel) {
        if (context.mounted) {
          _saveTokenAndNavigate(context: context, authModel: authModel);
        }
      },
    );
  }

  Future<String?> getFcmToken() async {
    try {
      return await firebaseService.getFirebaseToken();
    } catch (_) {
      return null;
    }
  }

  Future<void> _saveTokenAndNavigate({
    required BuildContext context,
    required UserModel authModel,
  }) async {
    final result = loginRepository.saveToken(
      token: authModel.token ?? '',
    );

    result.fold(
      (failure) {
        if (context.mounted) {
          context.showToast(failure.errMessage, isError: true);
        }
        emit(LoginFailureState(errorMessage: failure.errMessage));
      },
      (_) {
        if (context.mounted) {
          context.pushAndRemoveUntilWithNamed(Routes.homeView);
        }
      },
    );
  }
}
