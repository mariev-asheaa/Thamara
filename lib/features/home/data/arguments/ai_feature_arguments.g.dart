// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_feature_arguments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AiFeatureArguments _$AiFeatureArgumentsFromJson(Map<String, dynamic> json) =>
    AiFeatureArguments(
      diseaseName: json['predicted_class'] as String,
      confidenceLevel: json['confidence'] as num,
      severityLevel: json['severity_level'] as String,
      diseaseDescription: json['disease_description'] as String,
      treatment: json['treatment'] as String,
    );

Map<String, dynamic> _$AiFeatureArgumentsToJson(AiFeatureArguments instance) =>
    <String, dynamic>{
      'disease_name': instance.diseaseName,
      'disease_description': instance.diseaseDescription,
      'confidence': instance.confidenceLevel,
      'severity_level': instance.severityLevel,
      'treatment': instance.treatment,
    };
