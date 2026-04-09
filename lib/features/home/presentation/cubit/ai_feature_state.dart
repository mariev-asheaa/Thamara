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

final class AiReportLoading extends AiFeatureState {}

final class AiReportSuccess extends AiFeatureState {
  final String message;
  AiReportSuccess(this.message);
}

final class AiReportError extends AiFeatureState {
  final String errorMessage;
  AiReportError(this.errorMessage);
}
