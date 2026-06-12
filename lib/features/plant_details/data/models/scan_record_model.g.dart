// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanRecord _$ScanRecordFromJson(Map<String, dynamic> json) => ScanRecord(
  date: json['scanned_at']?.toString() ?? '',
  image: json['image_url']?.toString() ?? '',
  progressLevel: (double.tryParse(json['progress_level']?.toString() ?? '0') ?? 0.0).toInt(),
  confidence: json['confidence_level']?.toString() ?? '',
  progressStatus: json['progress_status']?.toString() ?? '',
);

Map<String, dynamic> _$ScanRecordToJson(ScanRecord instance) =>
    <String, dynamic>{
      'scanned_at': instance.date,
      'progress_status': instance.progressStatus,
      'confidence_level': instance.confidence,
      'image_url': instance.image,
      'progress_level': instance.progressLevel,
    };
