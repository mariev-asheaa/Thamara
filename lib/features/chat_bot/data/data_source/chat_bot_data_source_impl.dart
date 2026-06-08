import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/locals/secure_storage.dart';
import 'chat_bot_data_source.dart';

@Injectable(as: ChatBotRemoteDataSource)
class ChatBotRemoteDataSourceImpl implements ChatBotRemoteDataSource {
  final Dio dio;
  final CachedSecure cachedSecure;
  ChatBotRemoteDataSourceImpl(@Named("aiDio") this.dio, {required this.cachedSecure});


  @override
  Future<String> getAnswer({required String text, int limit = 5}) async {
    final response = await dio.post(
      ApiConstants.chatBot,
      data: {'text': text, 'limit': limit},
    );

    if (response.statusCode == 200) {
      final json = response.data as Map<String, dynamic>;

      if (json['signal'] == 'rag_answer_success') {
        return json['answer'] as String;
      }

      throw Exception('Unexpected signal: ${json['signal']}');
    }

    throw Exception('Request failed with status: ${response.statusCode}');
  }
}