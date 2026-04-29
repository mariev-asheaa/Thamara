import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/extentions/show_toast.dart';
import '../../data/models/notification_model.dart';
import '../../data/params/delete_notifications_param.dart';
import '../../data/repository/notifications_repository.dart';

part 'notifications_state.dart';

@injectable
class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepository repository;

  NotificationsCubit({required this.repository})
    : super(const NotificationsInitial());

  NotificationModel? notificationsPaginationModel;
  final List<NotificationModel> _notifications = [];

  bool _isSelectionMode = false;
  final Set<String> _selectedNotificationIds = {};

  int get selectedCount => _selectedNotificationIds.length;
  bool get isAllSelected =>
      _selectedNotificationIds.length == _notifications.length &&
      _notifications.isNotEmpty;
  Set<String> get selectedIds => Set.unmodifiable(_selectedNotificationIds);

  Future<void> fetchNotifications() async {
      emit(const NotificationsLoading());


    final result = await repository.fetchNotifications();
    result.fold(
      (failure) {
          emit(NotificationsFailure(error: failure.errMessage));
      },
      (notificationData) {
        emit(
          NotificationsSuccess(
            notifications: List.unmodifiable(_notifications),
            isSelectionMode: _isSelectionMode,
            selectedCount: selectedCount,
            isAllSelected: isAllSelected,
          ),
        );
      },
    );
  }



  void refreshNotifications() {
    _notifications.clear();
    fetchNotifications();
  }

  void enterSelectionMode() {
    _isSelectionMode = true;
    _selectedNotificationIds.clear();
    emit(
      NotificationsSuccess(
        notifications: List.unmodifiable(_notifications),
        isSelectionMode: true,
        selectedCount: 0,
        isAllSelected: false,
      ),
    );
  }

  void exitSelectionMode() {
    _isSelectionMode = false;
    _selectedNotificationIds.clear();
    emit(
      NotificationsSuccess(
        notifications: List.unmodifiable(_notifications),
        isSelectionMode: false,
        selectedCount: 0,
        isAllSelected: false,
      ),
    );
  }

  void toggleNotificationSelection(String notificationId) {
    if (_selectedNotificationIds.contains(notificationId)) {
      _selectedNotificationIds.remove(notificationId);
    } else {
      _selectedNotificationIds.add(notificationId);
    }
    emit(
      NotificationsSuccess(
        notifications: List.unmodifiable(_notifications),
        isSelectionMode: _isSelectionMode,
        selectedCount: selectedCount,
        isAllSelected: isAllSelected,
      ),
    );
  }

  void selectAll() {
    if (isAllSelected) {
      _selectedNotificationIds.clear();
    } else {
      _selectedNotificationIds.clear();
      _selectedNotificationIds.addAll(
        _notifications.map((notification) => notification.id),
      );
    }
    emit(
      NotificationsSuccess(
        notifications: List.unmodifiable(_notifications),
        isSelectionMode: _isSelectionMode,
        selectedCount: selectedCount,
        isAllSelected: isAllSelected,
      ),
    );
  }

  bool isNotificationSelected(String notificationId) {
    return _selectedNotificationIds.contains(notificationId);
  }

  Future<void> deleteSelectedNotifications(BuildContext context) async {
    _notifications.removeWhere(
      (notification) => _selectedNotificationIds.contains(notification.id),
    );

    final hasNotificationsLeft = _notifications.isNotEmpty;

    emit(
      NotificationsSuccess(
        notifications: List.unmodifiable(_notifications),
        isSelectionMode: hasNotificationsLeft,
        selectedCount: 0,
        isAllSelected: false,
      ),
    );

    if (_selectedNotificationIds.isEmpty) return;

    var result = await repository.deleteSelectedNotifications(
      param: DeleteNotificationsParam(ids: _selectedNotificationIds.toList()),
    );
    result.fold(
      (failure) {
        context.showToast(failure.errMessage, isError: true);
      },
      (_) {
        _selectedNotificationIds.clear();
        if (!hasNotificationsLeft) {
          _isSelectionMode = false;
        }
      },
    );
  }

  Future<void> readNotificationBasedOnId(
    BuildContext context,
    String notificationId,
  ) async {
    final NotificationModel notification = _notifications.firstWhere(
      (notification) => notification.id == notificationId,
    );
    if (!notification.isRead) {
      notification.isRead = true;
      emit(
        NotificationsSuccess(
          notifications: List.unmodifiable(_notifications),
          isSelectionMode: _isSelectionMode,
          selectedCount: selectedCount,
          isAllSelected: isAllSelected,
        ),
      );

      final result = await repository.markAsReadBasedOnId(
        notificationId: notificationId,
      );
      result.fold((failure) {}, (_) {});
    }
  }
}
