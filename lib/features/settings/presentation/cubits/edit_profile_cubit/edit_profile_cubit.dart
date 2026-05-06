
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:thamara/core/models/user_model.dart';

import '../../../../../core/extentions/navigation.dart';
import '../../../../../core/extentions/show_toast.dart';
import '../../../data/params/edit_acc_param.dart';
import '../../../data/repos/profile_info_repo.dart';

part 'edit_profile_state.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  final ProfileInfoRepo profileInfoRepo;

  EditProfileCubit({
    required this.profileInfoRepo,
  }) : super(EditProfileInitial());


  UserModel? userInfo;
  final formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController = TextEditingController();
  late TextEditingController secondNameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();
  void getUserInfo() async {
    emit(GetProfileLoading());
    final result = await profileInfoRepo.getProfileInfo();
    result.fold(
      (failure) {
        emit(GetProfileFailure(errorMessage: failure.errMessage));
      },
      (user) {
        userInfo = user;
        firstNameController.text = user.firstName!;
        secondNameController.text = user.secondName ?? "";
        emailController.text = user.email!;
        phoneController.text = user.phoneNumber ?? '';

        emit(GetProfileSuccess());
      },
    );
  }

  void editProfile(BuildContext context) async {
    if (state is EditProfileLoading) return;
    emit(EditProfileLoading());
    final result = await profileInfoRepo.editProfile(
      param: EditAccParam(
        email: emailController.text,
        firstName: firstNameController.text,
        phone: phoneController.text,
        secondName: secondNameController.text,
      ),
    );
    result.fold(
      (failure) {
        context.pop();
        context.showToast(failure.errMessage, isError: true);
        emit(EditProfileFailure(errorMessage: failure.errMessage));
      },
      (message) {
        context.pop();
        context.showToast(message);
        emit(EditProfileSuccess());
      },
    );
  }
}
