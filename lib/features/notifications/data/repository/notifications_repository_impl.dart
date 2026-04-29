import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failure.dart';
import '../data_source/notifications_remote_data_source.dart';
import '../models/notification_model.dart';
import '../params/delete_notifications_param.dart';
import 'notifications_repository.dart';

@Injectable(as: NotificationsRepository)
class NotificationsRepositoryImpl extends NotificationsRepository {
  final NotificationsRemoteDataSource notificationsRemoteDataSource;

  NotificationsRepositoryImpl({required this.notificationsRemoteDataSource});

  @override
  Future<Either<Failure, NotificationModel>>
  fetchNotifications() async {
    try {
      final NotificationModel response =
          await notificationsRemoteDataSource.fetchNotifications();
      return Right(response);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markAsReadBasedOnId({
    required String notificationId,
  }) async {
    try {
      await notificationsRemoteDataSource.markAsReadBasedOnId(
        notificationId: notificationId,
      );
      return const Right(null);
    }catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSelectedNotifications({
    required DeleteNotificationsParam param,
  }) async {
    try {
      await notificationsRemoteDataSource.deleteSelectedNotifications(
        param: param,
      );
      return const Right(null);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
