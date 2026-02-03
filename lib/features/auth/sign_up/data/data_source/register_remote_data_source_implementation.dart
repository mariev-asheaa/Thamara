import 'package:injectable/injectable.dart';
import 'package:thamara/core/models/user_model.dart';
import 'package:thamara/features/auth/sign_up/data/data_source/register_remote_data_source.dart';
import 'package:thamara/features/auth/sign_up/data/params/register_params.dart';

import '../../../../../core/api/api_consumer.dart';
import '../../../../../core/api/api_status_codes.dart';
import '../../../../../core/api/base_response.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/errors/failure.dart';

@Injectable(as: RegisterRemoteDataSource)
class RegisterRemoteDataSourceImplementation extends RegisterRemoteDataSource{
  final ApiConsumer apiConsumer;

  RegisterRemoteDataSourceImplementation({required this.apiConsumer});

  @override
  Future<UserModel> register({required RegisterParams param}) async{
    BaseResponse response = await apiConsumer.post(
      ApiConstants.register,
      body: param.toJson(),
    );
    if (response.status == ApiStatusCodes.ok ||
        response.status == ApiStatusCodes.created) {
      return UserModel.fromJson(response.data);
    } else {
      throw ServerFailure(response.message.toString());
    }
  }
  
}