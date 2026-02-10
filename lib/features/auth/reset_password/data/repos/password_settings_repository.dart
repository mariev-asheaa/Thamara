import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../otp/data/params/email_param.dart';
import '../param/reset_password_param.dart';

abstract class PasswordSettingsRepository {
  Future<Either<Failure, String>> forgotPassword({required EmailParam param});
  Future<Either<Failure, String>> resetPassword(
      {required ResetPasswordParam param});
}
