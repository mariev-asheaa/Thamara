// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanParams _$ScanParamsFromJson(Map<String, dynamic> json) => ScanParams(
  progressStatus: json['progress_status'] as String,
  confidence: json['confidence_level'] as String,
  image: json['image'] as String,
  progressLevel: (json['progress_level'] as num).toInt(),
);

Map<String, dynamic> _$ScanParamsToJson(ScanParams instance) =>
    <String, dynamic>{
      'progress_status': instance.progressStatus,
      'confidence_level': instance.confidence,
      'image': instance.image,
      'progress_level': instance.progressLevel,
    };
