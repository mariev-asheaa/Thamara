import 'package:thamara/core/models/user_model.dart';

abstract class ProfileInfoDataSource {
  Future<UserModel> getProfileInfo();
}