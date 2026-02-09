import 'package:json_annotation/json_annotation.dart';

part 'reset_password_param.g.dart';

@JsonSerializable(createFactory: false)
class ResetPasswordParam {
  final String password;
  @JsonKey(name: 'password_confirmation')
  final String confirmPassword;

  ResetPasswordParam({
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => _$ResetPasswordParamToJson(this);
}
