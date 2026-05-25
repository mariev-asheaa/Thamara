import '../../../../../../core/models/user_model.dart';
import '../../params/login_params.dart';

abstract class LoginDataSource {
  Future<UserModel> login({
    required LoginParams param,
  });
}