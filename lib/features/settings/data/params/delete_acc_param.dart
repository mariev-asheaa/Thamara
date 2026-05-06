import 'package:json_annotation/json_annotation.dart';

part 'delete_acc_param.g.dart';

@JsonSerializable()
class DeleteAccParam {
  @JsonKey(name: 'current_password')
  final String? currentPassword;

  DeleteAccParam({this.currentPassword});

  Map<String, dynamic> toJson() => _$DeleteAccParamToJson(this);
}
