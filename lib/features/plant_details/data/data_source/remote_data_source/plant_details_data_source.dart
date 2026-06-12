import '../../arguments/ai_comparison_arguments.dart';
import '../../models/plants_model.dart';
import '../../models/scan_record_model.dart';
import '../../params/ai_comparison_params.dart';
import '../../params/scan_params.dart';


abstract class PlantDetailsDataSource {
  Future<List<PlantsModel>> getAllPlants();
  Future<PlantsModel> getPlantById(int id);
  Future<AiComparisonArguments> analyzeProgress({
    required AiComparisonParams params
  });

  Future<String> postScanResult(ScanParams scanParam,int plantId);
  Future<List<ScanRecord>> getScanHistory(int plantId);
}