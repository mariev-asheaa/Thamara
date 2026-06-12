import 'package:json_annotation/json_annotation.dart';

part 'scan_record_model.g.dart';

@JsonSerializable()
class ScanRecord {
  @JsonKey(name: 'scanned_at')
  final String date;
  @JsonKey(name: 'progress_status')
  final String progressStatus;
  @JsonKey(name: 'confidence_level')
  final String confidence;
  @JsonKey(name: 'image_url')
  final String image;
  @JsonKey(name: 'progress_level')
  final int progressLevel;

  ScanRecord({
    required this.date,
    required this.image,
    required this.progressLevel,
    required this.confidence,
    required this.progressStatus,
  });

  factory ScanRecord.fromJson(Map<String, dynamic> json) =>
      _$ScanRecordFromJson(json);

}