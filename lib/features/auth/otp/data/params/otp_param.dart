import 'package:json_annotation/json_annotation.dart';

part 'otp_param.g.dart';

@JsonSerializable(createFactory: false)
class OTPParam {
  @JsonKey(name: 'user_id')
  final int id;
  @JsonKey(name: 'otp_code')
  final String otp;
  OTPParam({
    required this.id,
    required this.otp,
  });

  Map<String, dynamic> toJson() => _$OTPParamToJson(this);
}
