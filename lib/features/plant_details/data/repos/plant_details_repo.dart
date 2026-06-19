import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../arguments/ai_comparison_arguments.dart';
import '../models/plants_model.dart';
import '../models/scan_record_model.dart';
import '../params/ai_comparison_params.dart';
import '../params/scan_params.dart';

abstract class PlantDetailsRepo {
  Future<Either<Failure, List<PlantsModel>>> getAllPlants();
  Future<Either<Failure, PlantsModel>> getPlantById(int id);
  Future<Either<Failure, AiComparisonArguments>> analyzeProgress({
    required AiComparisonParams params
  });

  Future<Either<Failure, String>> postScanResult(ScanParams scanParam,int plantId);
  Future<Either<Failure, List<ScanRecord>>> getScanHistory(int plantId);
  Future<Either<Failure, void>> deletePlant({
    required int id,
  });
}
