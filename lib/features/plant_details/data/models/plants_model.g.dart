// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plants_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlantsModel _$PlantsModelFromJson(Map<String, dynamic> json) => PlantsModel(
  name: json['plant_name'] as String,
  image: json['image_url'] as String,
  status: json['status'] as String?,
  progress: (json['progress'] as num?)?.toDouble(),
  date: json['created_at'] as String,
  id: (json['id'] as num).toInt(),
  confidenceLevel: json['confidence'] as String,
  severityLevel: json['severity_level'] as String,
  diseaseName: json['disease_name'] as String,
  description: json['disease_description'] as String,
  treatment: json['treatment'] as String,
  firstDetectionDate: json['firstDetectionDate'] as String?,
  scanHistory: (json['scanHistory'] as List<dynamic>?)
      ?.map((e) => ScanRecord.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PlantsModelToJson(PlantsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plant_name': instance.name,
      'image_url': instance.image,
      'status': instance.status,
      'progress': instance.progress,
      'created_at': instance.date,
      'confidence': instance.confidenceLevel,
      'severity_level': instance.severityLevel,
      'disease_name': instance.diseaseName,
      'disease_description': instance.description,
      'treatment': instance.treatment,
      'firstDetectionDate': instance.firstDetectionDate,
      'scanHistory': instance.scanHistory,
    };
