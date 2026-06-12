import 'package:json_annotation/json_annotation.dart';

part 'ai_comparison_arguments.g.dart';

@JsonSerializable()
class AiComparisonArguments {
  @JsonKey(name: 'progress_status')
  final String progressStatus;
  final String confidence;

  const AiComparisonArguments({
    required this.progressStatus,
    required this.confidence,
  });

  factory AiComparisonArguments.fromJson(Map<String, dynamic> json) =>
      _$AiComparisonArgumentsFromJson(json);
}