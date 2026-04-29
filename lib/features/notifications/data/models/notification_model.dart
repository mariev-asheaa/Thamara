import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String date;

  @JsonKey(name: 'is_read')
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    required this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}

