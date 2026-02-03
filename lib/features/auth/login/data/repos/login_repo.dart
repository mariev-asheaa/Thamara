import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/models/user_model.dart';
import '../params/login_params.dart';
import '../params/send_token_param.dart';

abstract class LoginRepo {
  Future<Either<Failure, UserModel>> login({
    required LoginParams param,
  });
  Either<Failure, dynamic> saveToken({
    required String token,
  });
  Future<Either<Failure, dynamic>> sendToken({
    required SendTokenParam param,
  });
}