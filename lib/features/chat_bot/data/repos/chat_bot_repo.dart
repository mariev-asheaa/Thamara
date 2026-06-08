import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class ChatBotRepository {
  Future<Either<Failure, String>> getAnswer({required String text, int limit = 5});
}