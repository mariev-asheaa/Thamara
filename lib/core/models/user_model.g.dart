// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  token: json['access_token'] as String?,
  name: json['name'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phone_number'] as String?,
  image: json['image'] as String?,
  id: (json['user_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'access_token': instance.token,
  'name': instance.name,
  'email': instance.email,
  'user_id': instance.id,
  'phone_number': instance.phoneNumber,
  'image': instance.image,
};
