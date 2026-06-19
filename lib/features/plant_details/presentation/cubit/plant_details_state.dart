part of 'plant_details_cubit.dart';

@immutable
sealed class PlantDetailsState {}

final class PlantDetailsInitial extends PlantDetailsState {}

final class PlantDetailsLoading extends PlantDetailsState {}

final class PlantDetailsSuccess extends PlantDetailsState {
  final List<PlantsModel> plantsModel;
  final Map<int, ScanRecord?> latestScans;
  PlantDetailsSuccess({required this.plantsModel,this.latestScans = const {}});
}

final class PlantDetailsByIdSuccess extends PlantDetailsState {
  final PlantsModel plant;

  PlantDetailsByIdSuccess({required this.plant});
}

final class PlantDetailsFailure extends PlantDetailsState {
  final String errorMessage;

  PlantDetailsFailure({required this.errorMessage});
}

// ── Analyze Progress ──────────────────────────────────────────────────────────

final class AnalyzeProgressLoading extends PlantDetailsState {}

final class AnalyzeProgressSuccess extends PlantDetailsState {
  final AiComparisonArguments result;
  final String newImagePath;

  AnalyzeProgressSuccess({required this.result, required this.newImagePath});
}

final class AnalyzeProgressFailure extends PlantDetailsState {
  final String errorMessage;

  AnalyzeProgressFailure({required this.errorMessage});
}

// ── Post Scan Result ──────────────────────────────────────────────────────────

final class PostScanLoading extends PlantDetailsState {}

final class PostScanSuccess extends PlantDetailsState {
  final String message;

  PostScanSuccess({required this.message});
}

final class PostScanFailure extends PlantDetailsState {
  final String errorMessage;

  PostScanFailure({required this.errorMessage});
}

// ── Get Scan History ──────────────────────────────────────────────────────────

final class GetScanHistoryLoading extends PlantDetailsState {}

final class GetScanHistorySuccess extends PlantDetailsState {
  final List<ScanRecord> records;

  GetScanHistorySuccess({required this.records});
}

final class GetScanHistoryFailure extends PlantDetailsState {
  final String errorMessage;

  GetScanHistoryFailure({required this.errorMessage});
}
// ── Delete Plant──────────────────────────────────────────────────────────
final class DeletePlantLoading extends PlantDetailsState {}

final class DeletePlantSuccess extends PlantDetailsState {}

final class DeletePlantFailure extends PlantDetailsState {
  final String errorMessage;
  DeletePlantFailure({required this.errorMessage});
}