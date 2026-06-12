// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plants_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlantsModel _$PlantsModelFromJson(Map<String, dynamic> json) => PlantsModel(
  name: json['plant_name'] as String,
  image: json['image_url'] as String,
  status: json['progress_status'] as String?,
  progress: double.tryParse(json['progress_level']?.toString() ?? ''),
  date: json['created_at']?.toString() ?? '',
  id: (double.tryParse(json['id']?.toString() ?? '0') ?? 0.0).toInt(),
  confidenceLevel: json['confidence'] as String,
  severityLevel: json['severity_level'] as String,
  diseaseName: json['disease_name'] as String,
  description: json['disease_description'] as String,
  treatment: json['treatment'] as String,
  firstDetectionDate: json['firstDetectionDate'] as String?,
  scanHistory: (json['scans'] as List<dynamic>?)
      ?.map((e) => ScanRecord.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PlantsModelToJson(PlantsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plant_name': instance.name,
      'image_url': instance.image,
      'progress_status': instance.status,
      'progress_level': instance.progress,
      'created_at': instance.date,
      'confidence': instance.confidenceLevel,
      'severity_level': instance.severityLevel,
      'disease_name': instance.diseaseName,
      'disease_description': instance.description,
      'treatment': instance.treatment,
      'firstDetectionDate': instance.firstDetectionDate,
      'scanHistory': instance.scanHistory,
    };
