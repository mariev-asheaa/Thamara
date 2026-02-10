import 'package:json_annotation/json_annotation.dart';

part 'otp_param.g.dart';

@JsonSerializable(createFactory: false,includeIfNull: false)
class OTPParam {
  @JsonKey(name: 'user_id')
  final int? id;
  @JsonKey(name: 'otp_code')
  final String otp;
  final String?email;
  OTPParam({
     this.id,
     this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() => _$OTPParamToJson(this);
}
