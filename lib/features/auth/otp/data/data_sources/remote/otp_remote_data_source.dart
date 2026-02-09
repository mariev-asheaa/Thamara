
import '../../../../../../core/models/user_model.dart';
import '../../params/email_param.dart';
import '../../params/otp_param.dart';

abstract class OTPRemoteDataSource {
  Future<UserModel> verifyEmail({
    required OTPParam param,
  });
  Future<String> resendOtp({
    required EmailParam param,
  });
  Future<String> otpPassword({required OTPParam param});
}
