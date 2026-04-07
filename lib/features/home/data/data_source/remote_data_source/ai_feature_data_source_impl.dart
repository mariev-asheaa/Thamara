import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:thamara/core/constants/api_constants.dart';
import '../../arguments/ai_feature_arguments.dart';
import '../../params/ai_feature_params.dart';
import 'ai_feature_data_source.dart';
import '../../../../../core/errors/exceptions.dart';

@Injectable(as: AiFeatureDataSource)
class AiFeatureDataSourceImpl implements AiFeatureDataSource {
  final Dio dio;
  AiFeatureDataSourceImpl(@Named("aiDio") this.dio);

  @override
  Future<AiFeatureArguments> postPlantImage({required AiFeatureParams params}) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(params.imagePath),
      });

      final response = await dio.post(
        ApiConstants.postPlantImage,
        data: formData,
      );

      print('Response statusCode: ${response.statusCode}');
      print('Response data: ${response.data}');

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
      throw ServerException(e.toString());
    }
  }
}