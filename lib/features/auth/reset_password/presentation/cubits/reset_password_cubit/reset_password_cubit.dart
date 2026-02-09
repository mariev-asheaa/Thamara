import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/extentions/show_toast.dart';
import '../../../../otp/data/params/email_param.dart';
import '../../../data/repos/password_settings_repository.dart';

part 'reset_password_state.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final PasswordSettingsRepository passwordSettingsRepository;
  ResetPasswordCubit({required this.passwordSettingsRepository})
      : super(ResetPasswordInitialState());

  final TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKeyController = GlobalKey<FormState>();

  Future forgetPassword(BuildContext context) async {
    emit(ResetPasswordLoadingState());
    var result = await passwordSettingsRepository.forgotPassword(
      param: EmailParam(email: emailController.text),
    );
    result.fold(
      (failure) {
        context.showToast(failure.errMessage, isError: true);
        emit(ResetPasswordFailureState(errorMessage: failure.errMessage));
      },
      (message) {
        // context.pushWithNamed(Routes.otpView,
        //     arguments:OTPArgument(email: emailController.text, isRegisterOTP: false, userId: null));
         emit(ResetPasswordSuccessState());
      },
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
