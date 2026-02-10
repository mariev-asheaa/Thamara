import 'package:dartz/dartz.dart';
import  'package:injectable/injectable.dart';
import 'package:thamara/features/auth/reset_password/data/repos/password_settings_repository.dart';

import '../../../../../core/errors/failure.dart';
import '../../../otp/data/params/email_param.dart';
import '../data_sources/remote/password_settings_remote_data_source.dart';
import '../param/reset_password_param.dart';

@Injectable(as: PasswordSettingsRepository)
class PasswordSettingsRepositoryImpl extends PasswordSettingsRepository {
  final PasswordSettingsRemoteDataSource passwordSettingsRemoteDataSource;

  PasswordSettingsRepositoryImpl(
      {required this.passwordSettingsRemoteDataSource});

  @override
  Future<Either<Failure, String>> forgotPassword(
      {required EmailParam param}) async {
    try {
      String message =
          await passwordSettingsRemoteDataSource.forgotPassword(param: param);
      return Right(message);
    } on ServerFailure catch (exception) {
      return Left(ServerFailure(exception.errMessage));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword(
      {required ResetPasswordParam param}) async {
    try {
      String message =
          await passwordSettingsRemoteDataSource.resetPassword(param: param);
      return Right(message);
    } on ServerFailure catch (exception) {
      return Left(ServerFailure(exception.errMessage));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
