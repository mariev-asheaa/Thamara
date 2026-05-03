import 'package:thamara/core/models/user_model.dart';

import '../../params/edit_acc_param.dart';

abstract class ProfileInfoDataSource {
  Future<UserModel> getProfileInfo();
  Future<String> logOut();
  Future<String> editProfile({required EditAccParam param});
}