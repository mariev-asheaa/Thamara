import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/extentions/navigation.dart';
import '../../../../../core/extentions/show_toast.dart';
import '../../../../../core/models/user_model.dart';
import '../../../../../core/routing/routes.dart';
import '../../../otp/data/arguments/otp_argument.dart';
import '../../data/params/register_params.dart';
import '../../data/repos/register_repo.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepository registerRepository;

  RegisterCubit({
    required this.registerRepository,
  }) : super(RegisterInitial());

  final GlobalKey<FormState> registerFormKeyController = GlobalKey<FormState>();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();
  final TextEditingController registerConfirmPasswordController =
      TextEditingController();
  final TextEditingController registerFirstNameController =
      TextEditingController();
  final TextEditingController registerLastNameController =
      TextEditingController();
  final TextEditingController registerPhoneController =
  TextEditingController();

  Future register(BuildContext context) async {
    emit(RegisterLoadingState());
    var result = await registerRepository.register(
      param: RegisterParams(
          email: registerEmailController.text,
          password: registerPasswordController.text,
          firstName: registerFirstNameController.text,
          confirmPassword: registerConfirmPasswordController.text,
          lastName: registerLastNameController.text,
          phone: registerPhoneController.text
      ),
    );
    result.fold((failure) {
      context.showToast(failure.errMessage, isError: true);
      emit(RegisterFailureState(errorMessage: failure.errMessage));
    }, (authModel) {
      saveToken(context: context, authModel: authModel);
    });
  }

  Future<void> saveToken({
    required BuildContext context,
    required UserModel authModel,
  }) async {
    final result = registerRepository.saveToken(
      token: authModel.token ?? '',
    );

    result.fold(
      (failure) {
        context.showToast(failure.errMessage, isError: true);
        emit(RegisterFailureState(errorMessage: failure.errMessage));
      },
      (_) async {
        context.pushWithNamed(Routes.otpView,
            arguments: OTPArgument(
                email: authModel.email ?? '',
                isRegisterOTP: true,
                userId: authModel.id!));
        emit(RegisterSuccessState());
      },
    );
  }

  @override
  Future<void> close() {
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    registerFirstNameController.dispose();
    registerLastNameController.dispose();
    registerPhoneController.dispose();
    return super.close();
  }
}