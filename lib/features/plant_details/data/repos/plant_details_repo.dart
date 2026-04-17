import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/plants_model.dart';

abstract class PlantDetailsRepo {
  Future<Either<Failure, List<PlantsModel>>> getAllPlants();
  Future<Either<Failure, PlantsModel>> getPlantById(int id);
}