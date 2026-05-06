import 'package:dartz/dartz.dart';
import 'package:thamara/core/models/user_model.dart';

import '../../../../core/errors/failure.dart';
import '../params/delete_acc_param.dart';
import '../params/edit_acc_param.dart';

abstract class ProfileInfoRepo {
  Future<Either<Failure, UserModel>> getProfileInfo();
  Future<Either<Failure, String>> logOut();
  Either<Failure, dynamic> clearDataUser();
  Future<Either<Failure, String>> editProfile({required EditAccParam param});
  Future<Either<Failure, String>> deleteAcc({required DeleteAccParam param});
}