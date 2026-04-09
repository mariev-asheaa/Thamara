import 'package:dartz/dartz.dart';
import 'package:thamara/core/errors/failure.dart';
import '../arguments/ai_feature_arguments.dart';
import '../params/ai_feature_params.dart';
import '../params/plant_data_params.dart';

abstract class AiFeatureRepo {
  Future<Either<Failure, AiFeatureArguments>> postPlantImage({required AiFeatureParams params});
  Future<Either<Failure, String>> postAiReport({required AiFeatureArguments arguments,required PlantDataParams plantParams});
}
