import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:thamara/core/errors/failure.dart';
import 'package:thamara/core/models/user_model.dart';
import 'package:thamara/features/auth/sign_up/data/params/register_params.dart';
import 'package:thamara/features/auth/sign_up/data/repos/register_repo.dart';

import '../data_source/register_remote_data_source.dart';

@Injectable(as: RegisterRepository)
class RegisterRepoImplementation implements RegisterRepository{
  final RegisterRemoteDataSource registerRemoteDataSource;

  RegisterRepoImplementation({required this.registerRemoteDataSource});

  @override
  Future<Either<Failure, UserModel>> register({required RegisterParams param})async {
    try {
      UserModel model = await registerRemoteDataSource.register(param: param);
      return Right(model);
    } on ServerFailure catch (exception) {
      return Left(ServerFailure(exception.errMessage));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}