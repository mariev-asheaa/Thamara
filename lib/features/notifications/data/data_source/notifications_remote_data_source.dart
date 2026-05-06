
import '../models/notification_model.dart';
import '../params/delete_notifications_param.dart';

abstract class NotificationsRemoteDataSource {
  Future<List<NotificationModel>> fetchNotifications();
  Future<void> markAsReadBasedOnId({required String notificationId});
  Future<void> deleteSelectedNotifications({
    required DeleteNotificationsParam param,
  });
}
