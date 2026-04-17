import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:thamara/core/errors/failure.dart';
import 'package:thamara/features/plant_details/data/repos/plant_details_repo.dart';
import '../data_source/remote_data_source/plant_details_data_source.dart';
import '../models/plants_model.dart';

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
}

