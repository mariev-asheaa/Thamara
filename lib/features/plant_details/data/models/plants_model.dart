import 'package:json_annotation/json_annotation.dart';
import 'package:thamara/features/plant_details/data/models/scan_record_model.dart';
part 'plants_model.g.dart';

@JsonSerializable()
class PlantsModel {
  final int id;
  @JsonKey(name: 'plant_name')
  final String name;
  @JsonKey(name: 'image_url')
  final String image;
  final String? status;
  final double? progress;
  @JsonKey(name: 'created_at')
  final String date;
  @JsonKey(name: 'confidence')
  final String confidenceLevel;
  @JsonKey(name: 'severity_level')
  final String severityLevel;
  @JsonKey(name: 'disease_name')
  final String diseaseName;
  @JsonKey(name: 'disease_description')
  final String description;
  final String treatment;
  final String? firstDetectionDate;
  final List<ScanRecord>? scanHistory;
  PlantsModel({
    required this.name,
    required this.image,
    this.status,
    this.progress,
    required this.date,
    required this.id,
    required this.confidenceLevel,
    required this.severityLevel,
    required this.diseaseName,
    required this.description,
    required this.treatment,
    this.firstDetectionDate,
    this.scanHistory,
  });

  factory PlantsModel.fromJson(Map<String, dynamic> json) =>
      _$PlantsModelFromJson(json);
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
