import 'package:dartz/dartz.dart';
import 'package:thamara/core/models/user_model.dart';

import '../../../../core/errors/failure.dart';

abstract class ProfileInfoRepo {
  Future<Either<Failure, UserModel>> getProfileInfo();
}