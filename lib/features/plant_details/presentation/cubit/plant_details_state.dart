part of 'plant_details_cubit.dart';

@immutable
sealed class PlantDetailsState {}

final class PlantDetailsInitial extends PlantDetailsState {}

final class PlantDetailsLoading extends PlantDetailsState {}

final class PlantDetailsSuccess extends PlantDetailsState {
  final List<PlantsModel> plantsModel;

  PlantDetailsSuccess({required this.plantsModel});
}

final class PlantDetailsByIdSuccess extends PlantDetailsState {
  final PlantsModel plant;

  PlantDetailsByIdSuccess({required this.plant});
}

final class PlantDetailsFailure extends PlantDetailsState {
  final String errorMessage;

  PlantDetailsFailure({required this.errorMessage});
}