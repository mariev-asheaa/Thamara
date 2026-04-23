// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanRecord _$ScanRecordFromJson(Map<String, dynamic> json) => ScanRecord(
  date: json['date'] as String,
  image: json['image'] as String,
  severityLevel: json['severityLevel'] as String,
  confidenceLevel: (json['confidenceLevel'] as num).toDouble(),
  progress: (json['progress'] as num).toDouble(),
);

Map<String, dynamic> _$ScanRecordToJson(ScanRecord instance) =>
    <String, dynamic>{
      'date': instance.date,
      'image': instance.image,
      'severityLevel': instance.severityLevel,
      'confidenceLevel': instance.confidenceLevel,
      'progress': instance.progress,
    };
