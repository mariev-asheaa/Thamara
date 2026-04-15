class PlantModel {
  final String name;
  final String image;
  final String status;
  final double progress;
  final String date;

  final String firstDetectionDate;
  final double confidenceLevel;
  final String severityLevel;
  final String diseaseName;
  final String description;
  final String treatmentTitle;
  final String treatmentUsage;
  final List<ScanRecord> scanHistory;

  PlantModel({
    required this.name,
    required this.image,
    required this.status,
    required this.progress,
    required this.date,
    required this.firstDetectionDate,
    required this.confidenceLevel,
    required this.severityLevel,
    required this.diseaseName,
    required this.description,
    required this.treatmentTitle,
    required this.treatmentUsage,
    required this.scanHistory,
  });
}




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
}