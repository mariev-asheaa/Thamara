import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:thamara/core/errors/failure.dart';
import 'package:thamara/core/models/user_model.dart';
import 'package:thamara/features/settings/data/data_source/remote_data_source/profile_info_data_source.dart';
import 'package:thamara/features/settings/data/params/delete_acc_param.dart';
import 'package:thamara/features/settings/data/params/edit_acc_param.dart';
import 'package:thamara/features/settings/data/repos/profile_info_repo.dart';

import '../data_source/local/setting_local_data_source.dart';

@Injectable(as: ProfileInfoRepo)
class ProfileInfoRepoImpl implements ProfileInfoRepo{
  final ProfileInfoDataSource profileInfoDataSource;
  final SettingLocalDataSource settingLocalDataSource;
  ProfileInfoRepoImpl({required this.profileInfoDataSource, required this.settingLocalDataSource});

  @override
  Future<Either<Failure, UserModel>> getProfileInfo()async{
    try {
      UserModel model = await profileInfoDataSource.getProfileInfo();
      return Right(model);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Either<Failure, dynamic> clearDataUser() {
    try {
      settingLocalDataSource.clearDataUser();
      return const Right('Done');
    } catch (error) {
      throw Exception('Failed to clear data: $error');
    }
  }

  @override
  Future<Either<Failure, String>> logOut() async {
    try {
      String message = await profileInfoDataSource.logOut();
      return Right(message);
    }  catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> editProfile({
    required EditAccParam param,
  }) async {
    try {
      String message = await profileInfoDataSource.editProfile(param: param);
      return Right(message);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteAcc({
    required DeleteAccParam param,
  }) async {
    try {
      String message = await profileInfoDataSource.deleteAcc(param: param);
      return Right(message);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}