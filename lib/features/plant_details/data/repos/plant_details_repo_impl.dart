import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:thamara/core/errors/failure.dart';
import 'package:thamara/features/plant_details/data/models/scan_record_model.dart';
import 'package:thamara/features/plant_details/data/repos/plant_details_repo.dart';
import '../arguments/ai_comparison_arguments.dart';
import '../data_source/remote_data_source/plant_details_data_source.dart';
import '../models/plants_model.dart';
import '../params/ai_comparison_params.dart';
import '../params/scan_params.dart';

@Injectable(as: PlantDetailsRepo)
class PlantDetailsRepoImpl implements PlantDetailsRepo {
  final PlantDetailsDataSource plantDetailsDataSource;

  PlantDetailsRepoImpl({required this.plantDetailsDataSource});

  @override
  Future<Either<Failure, List<PlantsModel>>> getAllPlants() async {
    try {
      List<PlantsModel> model = await plantDetailsDataSource.getAllPlants();
      return Right(model);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, PlantsModel>> getPlantById(int id) async {
    try {
      final plant = await plantDetailsDataSource.getPlantById(id);
      return Right(plant);
    } catch (error) {
      print(error.toString());
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, AiComparisonArguments>> analyzeProgress({required AiComparisonParams params}) async{
    try {
      final model = await plantDetailsDataSource.analyzeProgress(params: params);
      return Right(model);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ScanRecord>>> getScanHistory(int plantId)async {
    try {
      final model = await plantDetailsDataSource.getScanHistory(plantId);
      return Right(model);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> postScanResult(ScanParams scanParam, int plantId) async{
    try {
      String message = await plantDetailsDataSource.postScanResult(scanParam,plantId);
      return Right(message);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePlant({required int id}) async {
    try {
      await plantDetailsDataSource.deletePlant(
      id: id
      );
      return const Right(null);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}

