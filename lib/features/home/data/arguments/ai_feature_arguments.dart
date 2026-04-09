import 'package:json_annotation/json_annotation.dart';

part 'ai_feature_arguments.g.dart';

@JsonSerializable()
class AiFeatureArguments {
  @JsonKey(name: 'predicted_class')
  final String diseaseName;
  @JsonKey(name: 'disease_description')
  final String diseaseDescription;
  @JsonKey(name: 'confidence')
  final num confidenceLevel;
  @JsonKey(name: 'severity_level')
  final String severityLevel;
  final String treatment;

  AiFeatureArguments({
    required this.diseaseName,
    required this.confidenceLevel,
    required this.severityLevel,
    required this.diseaseDescription,
    required this.treatment,
  });

  factory AiFeatureArguments.fromJson(Map<String, dynamic> json) =>
      _$AiFeatureArgumentsFromJson(json);

  Map<String, dynamic> toJson() => _$AiFeatureArgumentsToJson(this);

  // Computed properties to split treatment logic
  String get treatmentTitle {
    if (treatment.contains('- Usage:')) {
      return treatment.split('- Usage:')[0].trim();
    } else if (treatment.contains('Usage:')) {
      var title = treatment.split('Usage:')[0].trim();
      if (title.endsWith('-')) {
        title = title.substring(0, title.length - 1).trim();
      }
      return title;
    }
    return treatment;
  }

  String get treatmentUsage {
    if (treatment.contains('- Usage:')) {
      final parts = treatment.split('- Usage:');
      return parts.length > 1 ? parts[1].trim() : '';
    } else if (treatment.contains('Usage:')) {
      final parts = treatment.split('Usage:');
      return parts.length > 1 ? parts[1].trim() : '';
    }
    return '';
  }
}