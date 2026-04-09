import 'package:json_annotation/json_annotation.dart';

part 'plant_data_params.g.dart';

@JsonSerializable()
class PlantDataParams {
  final String image;
  @JsonKey(name: 'plant_name')
  final String plantName;

  PlantDataParams({required this.image, required this.plantName});

  Map<String, dynamic> toJson() => _$PlantDataParamsToJson(this);

}