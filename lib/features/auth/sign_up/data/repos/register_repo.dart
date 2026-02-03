import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/models/user_model.dart';
import '../params/register_params.dart';

abstract class RegisterRepository {
  Future<Either<Failure, UserModel>> register({
    required RegisterParams param,
  });
}