import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:thamara/core/models/user_model.dart';
import 'package:thamara/features/settings/data/repos/profile_info_repo.dart';

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
}
