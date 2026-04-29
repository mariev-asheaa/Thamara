// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_notifications_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteNotificationsParam _$DeleteNotificationsParamFromJson(
  Map<String, dynamic> json,
) => DeleteNotificationsParam(
  ids: (json['ids'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$DeleteNotificationsParamToJson(
  DeleteNotificationsParam instance,
) => <String, dynamic>{'ids': instance.ids};
