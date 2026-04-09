import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'dart:io';
import 'package:thamara/features/home/data/params/ai_feature_params.dart';
import 'package:thamara/features/home/data/params/plant_data_params.dart';
import 'package:thamara/features/home/data/repos/ai_feature_repo.dart';

import '../../data/arguments/ai_feature_arguments.dart';

part 'ai_feature_state.dart';

@injectable
class AiFeatureCubit extends Cubit<AiFeatureState> {
  final AiFeatureRepo aiFeatureRepo;

  AiFeatureCubit(this.aiFeatureRepo) : super(AiFeatureInitial());

  Future<void> postPlantImage(File imageFile) async {
    emit(AiFeatureLoading());

    final result = await aiFeatureRepo.postPlantImage(params: AiFeatureParams(imagePath: imageFile.path));

    result.fold(
      (failure) => emit(AiFeatureError(failure.errMessage)),
      (model) => emit(AiFeatureSuccess(model)),
    );
  }

  Future<void> postAiReport({required AiFeatureArguments arguments,required String imagePath, required String plantName,}) async {
    emit(AiReportLoading());

    final plantParams = PlantDataParams(
      image: imagePath,
      plantName: plantName,
    );

    final result = await aiFeatureRepo.postAiReport(
      arguments: arguments,
      plantParams: plantParams,
    );

    result.fold(
      (failure) => emit(AiReportError(failure.errMessage)),
      (message) => emit(AiReportSuccess(message)),
    );
  }
}
