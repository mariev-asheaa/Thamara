import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/extentions/navigation.dart';
import '../../../../../core/extentions/show_toast.dart';
import '../../../../../core/models/user_model.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../data/params/email_param.dart';
import '../../data/params/otp_param.dart';
import '../../data/repos/otp_repository.dart';

part 'otp_state.dart';

@injectable
class OTPCubit extends Cubit<OTPState> {
  final OTPRepository otpRepository;

  final TextEditingController oTPController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final int otpLength = 6;
  late int userId;

  OTPCubit({required this.otpRepository}) : super(OTPInitial());

  void updateEmail(String email) {
    emailController.text = email;
  }
  void updateUserId(int id) {
    userId = id;
  }

  void clearErrorState() {
    if (state is OTPFailureState) {
      emit(OTPInitial());
    }
  }

  Future resendOTP(
    BuildContext context,
  ) async {
    emit(OTPResendLoadingState());
    var result = await otpRepository.resendOtp(
        param: EmailParam(email: emailController.text));
    result.fold((failure) {
      context.showToast(failure.errMessage, isError: true);
      emit(OTPResendFailureState(errorMessage: failure.errMessage));
    }, (message) {
      context.showToast(
        message,
      );
      emit(OTPResendSuccessState());
    });
  }

  Future<void> submitOtp(BuildContext context, bool isRegisterOTP) async {
    if (state is OTPLoadingState) return;
    if (oTPController.text.length != otpLength) {
      emit(OTPFailureState(errorMessage: LocaleKeys.enterFullOTP.tr()));
      context.showToast(LocaleKeys.enterFullOTP.tr(), isError: true);
      return;
    }
    emit(OTPLoadingState());
    //two otp cases one for register and one for forget password
    if (isRegisterOTP) {
      await _registerVerifyEmail(context);
    } else {
      await _forgetPasswordOTP(context);
    }
  }

  Future<void> _forgetPasswordOTP(BuildContext context) async {
    final result = await otpRepository.otpPassword(
      param: OTPParam(
        id: userId,
        otp: oTPController.text,
      ),
    );

    result.fold(
      (failure) {
        context.showToast(failure.errMessage, isError: true);
        emit(OTPFailureState(errorMessage: failure.errMessage));
      },
      (_) {
        emit(OTPSuccessState());
        if (context.mounted) {
          context.pushWithNamed(Routes.newPasswordView);
        }
      },
    );
  }

  Future<void> _registerVerifyEmail(BuildContext context) async {
    final result = await otpRepository.verifyEmail(
      param: OTPParam(
        id: userId,
        otp: oTPController.text,
      ),
    );

    result.fold(
      (failure) {
        context.showToast(failure.errMessage, isError: true);
        emit(OTPFailureState(errorMessage: failure.errMessage));
      },
      (authModel) async => saveToken(
        authModel,
        context,
      ),
    );
  }

  Future<void> saveToken(UserModel authModel, BuildContext context) async {
    final result = otpRepository.saveToken(token: authModel.token ?? '');

    result.fold(
      (failure) {
        context.showToast(failure.errMessage, isError: true);
        emit(OTPFailureState(errorMessage: failure.errMessage));
      },
      (_) async {
        if (context.mounted) {
          FocusScope.of(context).unfocus();
          context.pushAndRemoveUntilWithNamed(Routes.homeView);
        }
      },
    );
  }


  @override
  Future<void> close() {
    oTPController.dispose();
    emailController.dispose();
    return super.close();
  }
}
