import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:thamara/core/errors/failure.dart';

import 'package:thamara/core/models/user_model.dart';
import 'package:thamara/features/auth/login/data/data_source/local/login_local_data_source.dart';

import 'package:thamara/features/auth/login/data/params/login_params.dart';
import 'package:thamara/features/auth/login/data/params/social_auth_params.dart';

import '../data_source/remote/login_data_source.dart';
import 'login_repo.dart';

@Injectable(as: LoginRepo)
class LoginRepoImplementation implements LoginRepo {
  final LoginDataSource loginRemoteDataSource;
  final LoginLocalDataSource loginLocalDataSource;

  LoginRepoImplementation({
    required this.loginRemoteDataSource,
    required this.loginLocalDataSource,
  });

  @override
  Future<Either<Failure, UserModel>> login({required LoginParams param}) async {
    try {
      UserModel model = await loginRemoteDataSource.login(param: param);
      return Right(model);
    } on ServerFailure catch (exception) {
      return Left(ServerFailure(exception.errMessage));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> socialLogin({
    required SocialAuthParams param,
  }) async {
    try {
      UserModel model = await loginRemoteDataSource.socialLogin(param: param);
      return Right(model);
    } on ServerFailure catch (exception) {
      return Left(ServerFailure(exception.errMessage));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Either<Failure, dynamic> saveToken({required String token}) {
    try {
      loginLocalDataSource.saveToken(token: token);
      return const Right(null);
    } catch (error) {
      throw Exception('Failed to save token: $error');
    }
  }
}
