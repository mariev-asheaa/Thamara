import 'package:json_annotation/json_annotation.dart';
part 'register_params.g.dart';

@JsonSerializable(createFactory: false)
class RegisterParams {
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String email;
  @JsonKey(name: 'phone_number')
  final String phone;
  final String password;
  @JsonKey(name: 'password_confirmation')
  final String confirmPassword;

  RegisterParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phone});

  Map<String, dynamic> toJson() => _$RegisterParamsToJson(this);
}