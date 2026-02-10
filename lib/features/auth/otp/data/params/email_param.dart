import 'package:json_annotation/json_annotation.dart';

part 'email_param.g.dart';

@JsonSerializable(createFactory: false)
class EmailParam {
  final String email;

  EmailParam({
    required this.email,
  });

  Map<String, dynamic> toJson() => _$EmailParamToJson(this);
}
