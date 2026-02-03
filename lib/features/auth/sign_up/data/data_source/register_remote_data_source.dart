import '../../../../../core/models/user_model.dart';
import '../params/register_params.dart';

abstract class RegisterRemoteDataSource {
  Future<UserModel> register({
    required RegisterParams param,
  });
}