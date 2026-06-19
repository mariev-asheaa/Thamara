import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:thamara/features/plant_details/data/data_source/remote_data_source/plant_details_data_source.dart';
import 'package:thamara/features/plant_details/data/models/scan_record_model.dart';
import '../../../../../core/api/api_consumer.dart';
import '../../../../../core/api/api_status_codes.dart';
import '../../../../../core/api/base_response.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/locals/secure_storage.dart';
import '../../arguments/ai_comparison_arguments.dart';
import '../../models/plants_model.dart';
import '../../params/ai_comparison_params.dart';
import '../../params/scan_params.dart';


@Injectable(as: PlantDetailsDataSource)
class PlantDetailsDataSourceImpl implements PlantDetailsDataSource {
  final ApiConsumer apiConsumer;
  final Dio dio;
  final CachedSecure cachedSecure;
  PlantDetailsDataSourceImpl(@Named("aiDio") this.dio,{required this.apiConsumer,required this.cachedSecure});

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

  @override
  Future<AiComparisonArguments> analyzeProgress({required AiComparisonParams params}) async {
    try {
      final formData = FormData.fromMap({
        'file_before': await MultipartFile.fromFile(params.oldImage),
        'file_after': await MultipartFile.fromFile(params.newImage),
      });

      final response = await dio.post(
        ApiConstants.trackProgress,
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonData =
        response.data is String ? jsonDecode(response.data) : response.data;

        return AiComparisonArguments.fromJson(jsonData);
      } else {
        throw ServerException(
            'Server error occurred, statusCode: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('There was an error try again');
    }
  }

  @override
  Future<List<ScanRecord>> getScanHistory(int plantId) async{
    BaseResponse response =
        await apiConsumer.get('${ApiConstants.getScanHistory}$plantId');
    if (response.status == ApiStatusCodes.ok ||
        response.status == ApiStatusCodes.created) {
      return  (response.data["scans"] as List)
          .map((e) => ScanRecord.fromJson(e))
          .toList();
    } else {
      throw ServerException(response.message.toString());
    }
  }

  @override
  Future<String> postScanResult(
      ScanParams scanParam,
      int plantId,
      ) async {
    try {
      final token = await cachedSecure.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('Token is missing! You must login first.');
      }
      final formData = FormData.fromMap({
        'progress_status': scanParam.progressStatus,
        'confidence_level': scanParam.confidence,
        'progress_level': scanParam.progressLevel,
        'image': await MultipartFile.fromFile(
          scanParam.image,
        ),
      });
      final response = await dio.post(
        '${ApiConstants.postProgressResult}$plantId',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonData =
        response.data is String ? jsonDecode(response.data) : response.data;
        return jsonData['message']?.toString() ?? 'Success';
      } else {
        throw ServerException(
            'Server error occurred, statusCode: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data.toString() ?? 'There was an error try again',
      );
    } catch (e) {
      throw ServerException('There was an error try again');
    }
  }

  @override
  Future<void> deletePlant({required int id}) async{
    BaseResponse response = await apiConsumer.delete(
        '${ApiConstants.plantDetails}$id'
    );
    if (response.status == ApiStatusCodes.ok ||
        response.status == ApiStatusCodes.created) {
      return;
    } else {
      throw ServerException(response.message.toString());
    }
  }
}
