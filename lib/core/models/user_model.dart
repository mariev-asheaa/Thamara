import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'access_token')
  final String? token;
  final String? firstName;
  final String? secondName;
  final String? email;
  @JsonKey(name: 'user_id')
  final int? id;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? image;


  UserModel({
    this.token,
    required this.firstName,
    required this.secondName,
    required this.email,
    this.phoneNumber,
    this.image,
    this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
