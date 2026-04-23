import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:thamara/core/errors/failure.dart';
import 'package:thamara/core/models/user_model.dart';
import 'package:thamara/features/settings/data/data_source/remote_data_source/profile_info_data_source.dart';
import 'package:thamara/features/settings/data/repos/profile_info_repo.dart';

@Injectable(as: ProfileInfoRepo)
class ProfileInfoRepoImpl implements ProfileInfoRepo{
  final ProfileInfoDataSource profileInfoDataSource;

  ProfileInfoRepoImpl({required this.profileInfoDataSource});

  @override
  Future<Either<Failure, UserModel>> getProfileInfo()async{
    try {
      UserModel model = await profileInfoDataSource.getProfileInfo();
      return Right(model);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

}