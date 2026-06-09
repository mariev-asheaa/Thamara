import '../../../../../../core/models/user_model.dart';
import '../../params/login_params.dart';
import '../../params/social_auth_params.dart';

abstract class LoginDataSource {
  Future<UserModel> login({
    required LoginParams param,
  });

  Future<UserModel> socialLogin({
    required SocialAuthParams param,
  });
}