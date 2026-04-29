import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/notification_model.dart';
import '../params/delete_notifications_param.dart';

abstract class NotificationsRepository {
  Future<Either<Failure,NotificationModel>> fetchNotifications();
  Future<Either<Failure, void>> markAsReadBasedOnId({
    required String notificationId,
  });
  Future<Either<Failure, void>> deleteSelectedNotifications({
    required DeleteNotificationsParam param,
  });
}
