import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/extentions/navigation.dart';
import '../../../../../../core/extentions/show_toast.dart';
import '../../../../../../core/routing/routes.dart';
import '../../../data/param/reset_password_param.dart';
import '../../../data/repos/password_settings_repository.dart';

part 'new_password_state.dart';

@injectable
class NewPasswordCubit extends Cubit<NewPasswordState> {
  final PasswordSettingsRepository passwordSettingsRepo;
  NewPasswordCubit({required this.passwordSettingsRepo})
      : super(NewPasswordInitialState());

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  GlobalKey<FormState> formKeyController = GlobalKey<FormState>();

  Future newPassword(BuildContext context) async {
    emit(NewPasswordLoadingState());
    var result = await passwordSettingsRepo.resetPassword(
      param: ResetPasswordParam(
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text),
    );
    result.fold((failure) {
      context.showToast(failure.errMessage, isError: true);
      emit(NewPasswordFailureState(errorMessage: failure.errMessage));
    }, (message) {
      context.showToast(
        message,
      );
      context.pushAndRemoveUntilWithNamed(
        Routes.loginView,
      );
      emit(NewPasswordSuccessState());
    });
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
