import '../../arguments/ai_feature_arguments.dart';
import '../../params/ai_feature_params.dart';
import '../../params/plant_data_params.dart';

abstract class AiFeatureDataSource {
  Future<AiFeatureArguments> postPlantImage({required AiFeatureParams params});
  Future<String> postAiReport({required AiFeatureArguments arguments,required PlantDataParams plantParams});
}