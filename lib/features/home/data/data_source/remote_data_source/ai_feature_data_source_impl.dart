import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:thamara/core/constants/api_constants.dart';
import '../../../../../core/locals/secure_storage.dart';
import '../../arguments/ai_feature_arguments.dart';
import '../../params/ai_feature_params.dart';
import '../../params/plant_data_params.dart';
import 'ai_feature_data_source.dart';
import '../../../../../core/errors/exceptions.dart';

@Injectable(as: AiFeatureDataSource)
class AiFeatureDataSourceImpl implements AiFeatureDataSource {
  final Dio dio;
  final CachedSecure cachedSecure;
  AiFeatureDataSourceImpl(@Named("aiDio") this.dio, {required this.cachedSecure});

  @override
  Future<AiFeatureArguments> postPlantImage(
      {required AiFeatureParams params}) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(params.imagePath),
      });

      final response = await dio.post(
        ApiConstants.postPlantImage,
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonData =
        response.data is String ? jsonDecode(response.data) : response.data;

        return AiFeatureArguments.fromJson(jsonData);
      } else {
        throw ServerException(
            'Server error occurred, statusCode: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception in postPlantImage: $e');
      throw ServerException('There was an error try again');
    }
  }

  @override
  Future<String> postAiReport({
    required AiFeatureArguments arguments,
    required PlantDataParams plantParams,
  }) async {
    try {
      final token = await cachedSecure.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('Token is missing! You must login first.');
      }
      final formData = FormData();
      formData.files.add(
        MapEntry(
          'image',
          await MultipartFile.fromFile(plantParams.image),
        ),
      );
      formData.fields.add(MapEntry('disease_name', arguments.diseaseName));
      formData.fields.add(MapEntry('disease_description', arguments.diseaseDescription));
      formData.fields.add(MapEntry('confidence', "${arguments.confidenceLevel}"));
      formData.fields.add(MapEntry('severity_level', arguments.severityLevel));
      formData.fields.add(MapEntry('treatment', arguments.treatment));
      formData.fields.add(MapEntry('plant_name', plantParams.plantName));
      final response = await dio.post(
        ApiConstants.postAiAnalysisReport,
        data: formData,
        options: Options(
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
    } catch (e) {
      throw ServerException('There was an error try again');
    }
  }
}