// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_comparison_arguments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AiComparisonArguments _$AiComparisonArgumentsFromJson(
  Map<String, dynamic> json,
) => AiComparisonArguments(
  progressStatus: json['progress_status'] as String,
  confidence: json['confidence'] as String,
);

Map<String, dynamic> _$AiComparisonArgumentsToJson(
  AiComparisonArguments instance,
) => <String, dynamic>{
  'progress_status': instance.progressStatus,
  'confidence': instance.confidence,
};
