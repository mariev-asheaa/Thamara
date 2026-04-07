part of 'ai_feature_cubit.dart';

@immutable
sealed class AiFeatureState {}

final class AiFeatureInitial extends AiFeatureState {}

final class AiFeatureLoading extends AiFeatureState {}

final class AiFeatureSuccess extends AiFeatureState {
  final AiFeatureArguments resultModel;
  AiFeatureSuccess(this.resultModel);
}

final class AiFeatureError extends AiFeatureState {
  final String errorMessage;
  AiFeatureError(this.errorMessage);
}
