import 'package:json_annotation/json_annotation.dart';

part 'login_params.g.dart';

@JsonSerializable(createFactory: false)
class LoginParams {
  final String email;
  final String password;

  @JsonKey(name: 'fcm_token')
  final String? fcmToken;

  final double? latitude;
  final double? longitude;

  LoginParams({
    required this.email,
    required this.password,
    this.fcmToken,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() => _$LoginParamsToJson(this);
}