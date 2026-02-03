import '../../../../../../core/models/user_model.dart';
import '../../params/login_params.dart';
import '../../params/send_token_param.dart';

abstract class LoginDataSource {
  Future<UserModel> login({
    required LoginParams param,
  });
  Future<String> sendToken({
    required SendTokenParam param,
  });
}