import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/models/user_model.dart';
import '../params/login_params.dart';

abstract class LoginRepo {
  Future<Either<Failure, UserModel>> login({
    required LoginParams param,
  });
  Either<Failure, dynamic> saveToken({
    required String token,
  });
}