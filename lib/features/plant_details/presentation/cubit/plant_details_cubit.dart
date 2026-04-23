import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../data/models/plants_model.dart';
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
}

