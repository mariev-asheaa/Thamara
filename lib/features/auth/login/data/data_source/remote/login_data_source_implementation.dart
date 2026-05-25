import 'package:injectable/injectable.dart';
import 'package:thamara/core/api/api_consumer.dart';
import 'package:thamara/core/models/user_model.dart';

import 'package:thamara/features/auth/login/data/params/login_params.dart';

import '../../../../../../core/api/api_status_codes.dart';
import '../../../../../../core/api/base_response.dart';
import '../../../../../../core/constants/api_constants.dart';
import '../../../../../../core/errors/exceptions.dart';
import 'login_data_source.dart';

@Injectable(as: LoginDataSource)
class LoginDataSourceImplementation implements LoginDataSource{
  final ApiConsumer apiConsumer;

  LoginDataSourceImplementation({required this.apiConsumer});

  @override
  Future<UserModel> login({required LoginParams param}) async{
    BaseResponse response = await apiConsumer.post(
      ApiConstants.login,
      body: param.toJson(),
    );
    if (response.status == ApiStatusCodes.ok ||
        response.status == ApiStatusCodes.created) {
      final user = UserModel.fromJson(response.data);

      return user;
    } else {
      throw ServerException(response.message);
    }
  }
}