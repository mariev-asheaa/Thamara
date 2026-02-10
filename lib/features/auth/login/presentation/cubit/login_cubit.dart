import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/extentions/navigation.dart';
import '../../../../../core/extentions/show_toast.dart';
import '../../../../../core/locals/shared_preferences.dart';
import '../../../../../core/models/user_model.dart';
import '../../../../../core/routing/routes.dart';
import '../../data/params/login_params.dart';
import '../../data/params/send_token_param.dart';
import '../../data/repos/login_repo.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepository, this.sharedPrefServices) : super(LoginInitial());
  final LoginRepo loginRepository;
  final SharedPrefServices sharedPrefServices;

  final GlobalKey<FormState> loginFormKeyController = GlobalKey<FormState>();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    emit(LoginLoadingState());

    final result = await loginRepository.login(
      param: LoginParams(
        email: loginEmailController.text,
        password: loginPasswordController.text,
      ),
    );
    result.fold(
          (failure) {
        context.showToast(failure.errMessage, isError: true);
        emit(LoginFailureState(errorMessage: failure.errMessage));
      },
          (authModel) async {
        if (context.mounted) {
          saveToken(
            context: context,
            authModel: authModel,
          );
        }
      },
    );
  }

  Future<void> saveToken({
    required BuildContext context,
    required UserModel authModel,
  }) async {
    final result = loginRepository.saveToken(
      token: authModel.token ?? '',
    );

    result.fold(
          (failure) {
        context.showToast(failure.errMessage, isError: true);
        emit(LoginFailureState(errorMessage: failure.errMessage));
      },
          (_) async {
            context.pushAndRemoveUntilWithNamed(Routes.homeView);
      },
    );
  }

  // Future<void> sendToken({
  //   required BuildContext context,
  //   required UserModel authModel,
  // }) async {
  //   String? fcmToken;
  //   final result = await loginRepository.sendToken(
  //     param: SendTokenParam(fcmToken: fcmToken ?? 'fcm'),
  //   );
  //   result.fold(
  //         (failure) {
  //       context.showToast(failure.errMessage, isError: true);
  //       emit(LoginFailureState(errorMessage: failure.errMessage));
  //     },
  //         (_) async {
  //           context.pushAndRemoveUntilWithNamed(Routes.homeView);
  //     },
  //   );
  // }
}
