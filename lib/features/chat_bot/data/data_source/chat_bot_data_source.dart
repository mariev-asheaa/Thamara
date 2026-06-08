abstract class ChatBotRemoteDataSource {
  Future<String> getAnswer({required String text, int limit = 5});
}