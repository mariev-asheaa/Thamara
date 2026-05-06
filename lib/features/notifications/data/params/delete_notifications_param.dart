import 'package:json_annotation/json_annotation.dart';

part 'delete_notifications_param.g.dart';

@JsonSerializable()
class DeleteNotificationsParam {
  final List<String> ids;

  const DeleteNotificationsParam({required this.ids});

  Map<String, dynamic> toJson() => _$DeleteNotificationsParamToJson(this);
}
