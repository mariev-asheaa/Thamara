import  'package:injectable/injectable.dart';

import '../../../../../../core/api/api_consumer.dart';
import '../../../../../../core/api/api_status_codes.dart';
import '../../../../../../core/api/base_response.dart';
import '../../../../../../core/constants/api_constants.dart';
import '../../../../../../core/errors/exceptions.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../../../core/models/user_model.dart';
import '../../params/email_param.dart';
import '../../params/otp_param.dart';
import 'otp_remote_data_source.dart';

@Injectable(as: OTPRemoteDataSource)
class OTPRemoteDataSourceImpl extends OTPRemoteDataSource {
  final ApiConsumer apiConsumer;

  OTPRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<String> resendOtp({required EmailParam param}) async {
    BaseResponse response = await apiConsumer.post(ApiConstants.resendOtp,
        body: param.toJson(),
    );
    if (response.status == ApiStatusCodes.ok ||
        response.status == ApiStatusCodes.created) {
      return response.message.toString();
    } else {
      throw ServerFailure(response.message.toString());
    }
  }

  @override
  Future<String> otpPassword({required OTPParam param}) async {
    BaseResponse response = await apiConsumer.post(ApiConstants.otpPassword,
        body: param.toJson(),
    );
    if (response.status == ApiStatusCodes.ok ||
        response.status == ApiStatusCodes.created) {
      return response.message.toString();
    } else {
      throw ServerException(response.message.toString());
    }
  }

  @override
  Future<UserModel> verifyEmail({required OTPParam param}) async {
    BaseResponse response = await apiConsumer.post(ApiConstants.verifyEmail,
        body: param.toJson(),
    );
    if (response.status == ApiStatusCodes.ok ||
        response.status == ApiStatusCodes.created) {
      final user = UserModel.fromJson(response.data);

      return user;
    } else {
      throw ServerFailure(response.message.toString());
    }
  }
}
