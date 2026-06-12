import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/arguments/ai_comparison_arguments.dart';
import '../../data/models/plants_model.dart';
import '../../data/models/scan_record_model.dart';
import '../../data/params/ai_comparison_params.dart';
import '../../data/params/scan_params.dart';
import '../../data/repos/plant_details_repo.dart';

part 'plant_details_state.dart';

@injectable
class PlantDetailsCubit extends Cubit<PlantDetailsState> {
  final PlantDetailsRepo plantDetailsRepo;
  PlantDetailsCubit(this.plantDetailsRepo) : super(PlantDetailsInitial());

  Future<void> getAllPlants() async {
    emit(PlantDetailsLoading());

    final result = await plantDetailsRepo.getAllPlants();
    result.fold(
      (failure) {
        emit(PlantDetailsFailure(errorMessage: failure.errMessage));
      },
      (plants) {
        emit(PlantDetailsSuccess(plantsModel: plants));
      },
    );
  }

  Future<void> getPlantById(int id) async {
    emit(PlantDetailsLoading());

    final result = await plantDetailsRepo.getPlantById(id);
    result.fold(
      (failure) {
        emit(PlantDetailsFailure(errorMessage: failure.errMessage));
      },
      (plant) {
        emit(PlantDetailsByIdSuccess(plant: plant));
      },
    );
  }

  // ── Analyze Progress ────────────────────────────────────────────────────────

  /// Downloads [imageUrl] from the backend to a temporary file and returns its
  /// local path so it can be passed to the AI multipart upload.
  Future<String> _downloadToTempFile(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    final tempDir = await getTemporaryDirectory();
    final fileName = 'plant_ref_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  Future<void> analyzeProgress({
    required String oldImageUrl,
    required String newImagePath,
  }) async {
    emit(AnalyzeProgressLoading());
    try {
      final oldImagePath = await _downloadToTempFile(oldImageUrl);
      final params = AiComparisonParams(
        oldImage: oldImagePath,
        newImage: newImagePath,
      );
      final result = await plantDetailsRepo.analyzeProgress(params: params);
      result.fold(
        (failure) => emit(AnalyzeProgressFailure(errorMessage: failure.errMessage)),
        (aiResult) => emit(AnalyzeProgressSuccess(
          result: aiResult,
          newImagePath: newImagePath,
        )),
      );
    } catch (e) {
      emit(AnalyzeProgressFailure(errorMessage: e.toString()));
    }
  }

  // ── Post Scan Result ────────────────────────────────────────────────────────

  Future<void> postScanResult(ScanParams scanParam, int plantId) async {
    emit(PostScanLoading());
    final result = await plantDetailsRepo.postScanResult(scanParam, plantId);
    result.fold(
      (failure) => emit(PostScanFailure(errorMessage: failure.errMessage)),
      (message) => emit(PostScanSuccess(message: message)),
    );
  }

  // ── Get Scan History ────────────────────────────────────────────────────────

  Future<void> getScanHistory(int plantId) async {
    emit(GetScanHistoryLoading());
    final result = await plantDetailsRepo.getScanHistory(plantId);
    result.fold(
      (failure) => emit(GetScanHistoryFailure(errorMessage: failure.errMessage)),
      (records) => emit(GetScanHistorySuccess(records: records)),
    );
  }
  // After getAllPlants succeeds, also fetch latest scan for each plant
  Future<void> getAllPlantsWithLatestScan() async {
    emit(PlantDetailsLoading());
    final result = await plantDetailsRepo.getAllPlants();
    result.fold(
          (failure) => emit(PlantDetailsFailure(errorMessage: failure.errMessage)),
          (plants) async {
        final Map<int, ScanRecord?> latestScans = {};
        await Future.wait(
          plants.map((plant) async {
            final historyResult = await plantDetailsRepo.getScanHistory(plant.id);
            historyResult.fold(
                  (_) => latestScans[plant.id] = null,
                  (history) {
                latestScans[plant.id] = _getLatest(history);
              },
            );
          }),
        );
        emit(PlantDetailsSuccess(latestScans: latestScans, plantsModel: plants,));
      },
    );
  }

  ScanRecord? _getLatest(List<ScanRecord> history) {
    if (history.isEmpty) return null;
    return history.reduce((a, b) =>
    DateTime.parse(a.date).isAfter(DateTime.parse(b.date)) ? a : b);
  }
}

