import 'package:json_annotation/json_annotation.dart';
part 'scan_params.g.dart';

@JsonSerializable()
class ScanParams {
  @JsonKey(name: 'progress_status')
  final String progressStatus;
  @JsonKey(name: 'confidence_level')
  final String confidence;
  final String image;
  @JsonKey(name: 'progress_level')
  final int progressLevel;

  ScanParams({required this.progressStatus, required this.confidence, required this.image, required this.progressLevel});
  Map<String, dynamic> toJson() => _$ScanParamsToJson(this);
}