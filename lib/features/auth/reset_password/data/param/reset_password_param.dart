import 'package:json_annotation/json_annotation.dart';

part 'reset_password_param.g.dart';

@JsonSerializable(createFactory: false)
class ResetPasswordParam {
  final String email;
  final String password;
  @JsonKey(name: 'password_confirmation')
  final String confirmPassword;

  ResetPasswordParam({
    required this.password,
    required this.confirmPassword,
    required this.email,
  });

  Map<String, dynamic> toJson() => _$ResetPasswordParamToJson(this);
}
