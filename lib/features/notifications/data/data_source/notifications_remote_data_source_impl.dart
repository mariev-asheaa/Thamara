import 'package:injectable/injectable.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/api_status_codes.dart';
import '../../../../core/api/base_response.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/notification_model.dart';
import '../params/delete_notifications_param.dart';
import 'notifications_remote_data_source.dart';

@Injectable(as: NotificationsRemoteDataSource)
class NotificationsRemoteDataSourceImpl extends NotificationsRemoteDataSource {
  final ApiConsumer apiConsumer;

  NotificationsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<NotificationModel> fetchNotifications() async {
    BaseResponse response = await apiConsumer.get(
      ApiConstants.notifications,
    );
    if (response.status == ApiStatusCodes.ok ||
        response.status == ApiStatusCodes.created) {
      return NotificationModel.fromJson(response.data);
    } else {
      throw ServerException(response.message.toString());
    }
  }

  @override
  Future<void> markAsReadBasedOnId({required String notificationId}) async {
    BaseResponse response = await apiConsumer.post(
      ApiConstants.markAsRead,
      queryParameters: {'id': notificationId},
    );
    if (response.status == ApiStatusCodes.ok ||
        response.status == ApiStatusCodes.created) {
      return;
    } else {
      throw ServerException(response.message.toString());
    }
  }

  @override
  Future<void> deleteSelectedNotifications({
    required DeleteNotificationsParam param,
  }) async {
    BaseResponse response = await apiConsumer.delete(
      ApiConstants.notifications,
      body: param.toJson(),
    );
    if (response.status == ApiStatusCodes.ok ||
        response.status == ApiStatusCodes.created) {
      return;
    } else {
      throw ServerException(response.message.toString());
    }
  }
}
