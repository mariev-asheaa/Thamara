
import '../../../../otp/data/params/email_param.dart';
import '../../param/reset_password_param.dart';

abstract class PasswordSettingsRemoteDataSource {
  Future<String> forgotPassword({required EmailParam param});
  Future<String> resetPassword({required ResetPasswordParam param});
}
