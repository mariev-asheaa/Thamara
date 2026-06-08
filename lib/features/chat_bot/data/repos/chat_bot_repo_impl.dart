
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../data_source/chat_bot_data_source.dart';
import 'chat_bot_repo.dart';

@Injectable(as: ChatBotRepository)
class ChatBotRepositoryImpl implements ChatBotRepository {
  final ChatBotRemoteDataSource remoteDataSource;

  ChatBotRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> getAnswer({required String text, int limit = 5}) async {
    try {
      final answer =await remoteDataSource.getAnswer(text: text, limit: limit);
      return Right(answer);
    } on ServerException catch (exception) {
      print(exception.message);
      return Left(ServerFailure(exception.message ?? 'Server error occurred'));
    } catch (error) {
      print(error.toString());
      return Left(ServerFailure(error.toString()));
    }
  }
}