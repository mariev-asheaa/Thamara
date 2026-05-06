import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:thamara/core/models/user_model.dart';
import 'package:thamara/features/settings/data/repos/profile_info_repo.dart';

import '../../../../../core/extentions/navigation.dart';
import '../../../../../core/extentions/show_toast.dart';
import '../../../../../core/routing/routes.dart';
import '../../../data/params/delete_acc_param.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileInfoRepo profileInfoRepo;
  ProfileCubit(this.profileInfoRepo) : super(ProfileInitial());

  Future<void> getProfileInfo() async {
    emit(ProfileLoading());

    final result = await profileInfoRepo.getProfileInfo();
    result.fold(
          (failure) {
        emit(ProfileFailure(errorMessage: failure.errMessage));
      },
          (user) {
            emit(ProfileSuccess(userModel: user));
      },
    );
  }

  void logOut({required BuildContext context}) async {
    if (state is LogOutLoading) return;

    emit(LogOutLoading());
    var result = await profileInfoRepo.logOut();
    result.fold(
          (failure) {
        context.pop();
        context.showToast(failure.errMessage, isError: true);
        emit(LogOutFailure());
      },
          (message) {
        clearUserData(context: context, message: message);
      },
    );
  }
  final TextEditingController passwordField = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void deleteAccount(BuildContext context) async {
    if (state is DeleteAccountLoading) return;
    emit(DeleteAccountLoading());
    final result = await profileInfoRepo.deleteAcc(
      param: DeleteAccParam(currentPassword: passwordField.text),
    );
    result.fold(
          (failure) {
        context.pop();
        context.showToast(failure.errMessage, isError: true);
        emit(DeleteAccountFailure(errorMessage: failure.errMessage));
      },
          (message) {
        clearUserData(context: context, message: message);
      },
    );
  }
  void clearUserData({
    required BuildContext context,
    required String message,
  }) async {
    var result = profileInfoRepo.clearDataUser();
    result.fold(
          (failure) {
        context.pop();
        context.showToast(failure.errMessage, isError: true);
        emit(LogOutFailure());
      },
          (r) {
        context.pushAndRemoveUntilWithNamed(Routes.loginView);
        emit(LogOutSuccess());
      },
    );
  }
}
