import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:thamara/core/errors/exceptions.dart';
import 'package:thamara/core/errors/failure.dart';
import 'package:thamara/features/home/data/params/plant_data_params.dart';
import '../arguments/ai_feature_arguments.dart';
import '../data_source/remote_data_source/ai_feature_data_source.dart';
import '../params/ai_feature_params.dart';
import 'ai_feature_repo.dart';

@Injectable(as: AiFeatureRepo)
class AiFeatureRepoImpl implements AiFeatureRepo {
  final AiFeatureDataSource remoteDataSource;

  AiFeatureRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AiFeatureArguments>> postPlantImage({required AiFeatureParams params}) async {
    try {
      final model = await remoteDataSource.postPlantImage(params: params);
      return Right(model);
    } on ServerException catch (exception) {
      print(exception.message);
      return Left(ServerFailure(exception.message ?? 'Server error occurred'));
    } catch (error) {
      print(error.toString());
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> postAiReport({required AiFeatureArguments arguments, required PlantDataParams plantParams})async {
    try {
      final message = await remoteDataSource.postAiReport(arguments: arguments, plantParams: plantParams);
      return Right(message);
    } on ServerException catch (exception) {
      print(exception.message);
      return Left(ServerFailure(exception.message ?? 'Server error occurred'));
    } catch (error) {
      print(error.toString());
      return Left(ServerFailure(error.toString()));
    }
  }
}
