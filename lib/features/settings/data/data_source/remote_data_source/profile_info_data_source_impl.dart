import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:thamara/core/models/user_model.dart';
import 'package:thamara/features/settings/data/data_source/remote_data_source/profile_info_data_source.dart';

import '../../../../../core/api/api_consumer.dart';
import '../../../../../core/api/api_status_codes.dart';
import '../../../../../core/api/base_response.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../params/delete_acc_param.dart';
import '../../params/edit_acc_param.dart';

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

  @override
  Future<String> logOut() async {
    BaseResponse response = await apiConsumer.post(ApiConstants.logout);
    if (response.status == ApiStatusCodes.ok ||
        response.status == ApiStatusCodes.created) {
      return response.message.toString();
    } else {
      throw ServerException(response.message.toString());
    }
  }

  @override
  Future<String> editProfile({required EditAccParam param}) async {
    BaseResponse response = await apiConsumer.put(
      ApiConstants.profileInfo,
      body: {
        if (param.firstName != null) 'first_name': param.firstName,
        if (param.secondName != null) 'last_name': param.secondName,
        if (param.email != null) 'email': param.email,
        if (param.phone != null) 'phone_number': param.phone,
      },
    );
    if (response.status == ApiStatusCodes.ok ||
        response.status == ApiStatusCodes.created) {
      return response.message ?? "";
    } else {
      throw ServerException(response.message.toString());
    }
  }

  @override
  Future<String> deleteAcc({required DeleteAccParam param}) async {
    BaseResponse response = await apiConsumer.delete(
      ApiConstants.profileInfo,
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