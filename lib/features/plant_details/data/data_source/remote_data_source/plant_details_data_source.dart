import '../../models/plants_model.dart';

abstract class PlantDetailsDataSource {
  Future<List<PlantsModel>> getAllPlants();
  Future<PlantsModel> getPlantById(int id);
}