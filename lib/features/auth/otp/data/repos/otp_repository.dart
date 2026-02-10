import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/models/user_model.dart';
import '../params/email_param.dart';
import '../params/otp_param.dart';

abstract class OTPRepository {
  Future<Either<Failure, UserModel>> verifyEmail({
    required OTPParam param,
  });
  Future<Either<Failure, String>> resendOtp({
    required EmailParam param,
  });
  Either<Failure, dynamic> saveToken({
    required String token,
  });
  Future<Either<Failure, String>> otpPassword({required OTPParam param});
}
