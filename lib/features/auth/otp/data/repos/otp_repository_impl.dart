import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/models/user_model.dart';
import '../data_sources/local/otp_local_data_source.dart';
import '../data_sources/remote/otp_remote_data_source.dart';
import '../params/email_param.dart';
import '../params/otp_param.dart';
import 'otp_repository.dart';

@Injectable(as: OTPRepository)
class OTPRepositoryImpl extends OTPRepository {
  final OTPRemoteDataSource authRemoteDataSource;
  final OTPLocalDataSource authLocalDataSource;

  OTPRepositoryImpl({required this.authRemoteDataSource, required this.authLocalDataSource,});

  @override
  Future<Either<Failure, String>> resendOtp({required EmailParam param}) async {
    try {
      String message = await authRemoteDataSource.resendOtp(param: param);
      return Right(message);
    } on ServerFailure catch (exception) {
      return Left(ServerFailure(exception.errMessage));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> otpPassword({required OTPParam param}) async {
    try {
      String message = await authRemoteDataSource.otpPassword(param: param);
      return Right(message);
    } on ServerFailure catch (exception) {
      return Left(ServerFailure(exception.errMessage));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> verifyEmail(
      {required OTPParam param}) async {
    try {
      UserModel model = await authRemoteDataSource.verifyEmail(param: param);
      return Right(model);
    } on ServerFailure catch (exception) {
      return Left(ServerFailure(exception.errMessage));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Either<Failure, dynamic> saveToken({
    required String token,
  }) {
    try {
      authLocalDataSource.saveToken(
        token: token,
      );
      return const Right('Done');
    } on Exception catch (exception) {
      return Left(Exception(exception.toString()) as Failure);
    } catch (error) {
      return Left(Exception(error.toString()) as Failure);
    }
  }
}
