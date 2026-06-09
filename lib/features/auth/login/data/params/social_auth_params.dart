import 'package:json_annotation/json_annotation.dart';

part 'social_auth_params.g.dart';

@JsonSerializable(createFactory: false)
class SocialAuthParams {
  final String provider;

  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'fcm_token')
  final String? fcmToken;

  final double? latitude;
  final double? longitude;

  SocialAuthParams({
    required this.provider,
    required this.accessToken,
    this.fcmToken,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() => _$SocialAuthParamsToJson(this);
}
