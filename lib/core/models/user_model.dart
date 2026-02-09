import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String? token;
  final String? name;
  final String? email;
  @JsonKey(name: 'user_id')
  final int? id;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? image;


  UserModel({
    this.token,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.image,
    this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
