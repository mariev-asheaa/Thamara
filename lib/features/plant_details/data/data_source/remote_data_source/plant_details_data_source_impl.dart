import 'package:injectable/injectable.dart';
import 'package:thamara/features/plant_details/data/data_source/remote_data_source/plant_details_data_source.dart';
import '../../../../../core/api/api_consumer.dart';
import '../../../../../core/api/api_status_codes.dart';
import '../../../../../core/api/base_response.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../models/plants_model.dart';

@Injectable(as: PlantDetailsDataSource)
class PlantDetailsDataSourceImpl implements PlantDetailsDataSource {
  final ApiConsumer apiConsumer;
  PlantDetailsDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<PlantsModel>> getAllPlants() async {
    BaseResponse response = await apiConsumer.get(ApiConstants.allPlants);
    if (response.status == ApiStatusCodes.ok ||
        response.status == ApiStatusCodes.created) {
      return (response.data["data"] as List)
          .map((e) => PlantsModel.fromJson(e))
          .toList();
    } else {
      throw ServerException(response.message.toString());
    }
  }

  @override
  Future<PlantsModel> getPlantById(int id) async {
    BaseResponse response =
        await apiConsumer.get('${ApiConstants.plantDetails}$id');
    if (response.status == ApiStatusCodes.ok ||
        response.status == ApiStatusCodes.created) {
      final List dataList = response.data["data"];

      return PlantsModel.fromJson(dataList.first);
    } else {
      throw ServerException(response.message.toString());
    }
  }
}
