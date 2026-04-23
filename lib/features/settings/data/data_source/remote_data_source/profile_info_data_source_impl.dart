import 'package:injectable/injectable.dart';
import 'package:thamara/core/models/user_model.dart';
import 'package:thamara/features/settings/data/data_source/remote_data_source/profile_info_data_source.dart';

import '../../../../../core/api/api_consumer.dart';
import '../../../../../core/api/api_status_codes.dart';
import '../../../../../core/api/base_response.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/errors/exceptions.dart';

@Injectable(as: ProfileInfoDataSource)
class ProfileInfoDataSourceImpl implements ProfileInfoDataSource{
  final ApiConsumer apiConsumer;
  ProfileInfoDataSourceImpl({required this.apiConsumer});

  @override
  Future<UserModel> getProfileInfo() async{
    BaseResponse response = await apiConsumer.get(ApiConstants.profileInfo);
    if (response.status == ApiStatusCodes.ok ||
        response.status == ApiStatusCodes.created) {
      return UserModel.fromJson(response.data['user']);
    } else {
      throw ServerException(response.message.toString());
    }
  }
}