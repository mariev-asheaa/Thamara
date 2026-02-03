import 'package:json_annotation/json_annotation.dart';
part 'send_token_param.g.dart';

@JsonSerializable(createFactory: false)
class SendTokenParam {
  @JsonKey(name: 'fcm_token')
  final String fcmToken;
  // final String token;

  SendTokenParam({
    // required this.token,
    required this.fcmToken,
  });

  Map<String, dynamic> toJson() => _$SendTokenParamToJson(this);
}
