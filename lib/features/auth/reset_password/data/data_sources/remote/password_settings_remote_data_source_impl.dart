import 'package:injectable/injectable.dart';
import 'package:thamara/features/auth/reset_password/data/data_sources/remote/password_settings_remote_data_source.dart';

import '../../../../../../core/api/api_consumer.dart';
import '../../../../../../core/api/api_status_codes.dart';
import '../../../../../../core/api/base_response.dart';
import '../../../../../../core/constants/api_constants.dart';
import '../../../../../../core/errors/exceptions.dart';
import '../../../../otp/data/params/email_param.dart';
import '../../param/reset_password_param.dart';

@Injectable(as: PasswordSettingsRemoteDataSource)
class PasswordSettingsRemoteDataSourceImpl
    extends PasswordSettingsRemoteDataSource {
  final ApiConsumer apiConsumer;
  PasswordSettingsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<String> forgotPassword({required EmailParam param}) async {
    BaseResponse response = await apiConsumer.post(
      ApiConstants.forgotPassword,
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
  Future<String> resetPassword({required ResetPasswordParam param}) async {
    BaseResponse response = await apiConsumer.post(
      ApiConstants.resetPassword,
      body: param.toJson(),
    );
    if (response.status == ApiStatusCodes.ok ||
        response.status == ApiStatusCodes.created) {
      return response.message.toString();
    } else {
      throw ServerException(response.message.toString());
    }
  }
}
