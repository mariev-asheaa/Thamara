import 'package:json_annotation/json_annotation.dart';

part 'scan_record_model.g.dart';

@JsonSerializable()
class ScanRecord {
  final String date;
  final String image;
  final String severityLevel;
  final double confidenceLevel;
  final double progress;

  ScanRecord({
    required this.date,
    required this.image,
    required this.severityLevel,
    required this.confidenceLevel,
    required this.progress,
  });

  factory ScanRecord.fromJson(Map<String, dynamic> json) =>
      _$ScanRecordFromJson(json);

}