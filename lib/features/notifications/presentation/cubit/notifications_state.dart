part of 'notifications_cubit.dart';

@immutable
abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {
  const NotificationsInitial();
}

class NotificationsLoading extends NotificationsState {
  const NotificationsLoading();
}

class NotificationsSuccess extends NotificationsState {
  final List<NotificationModel> notifications;
  final bool isSelectionMode;
  final int selectedCount;
  final bool isAllSelected;

  const NotificationsSuccess({
    required this.notifications,
    this.isSelectionMode = false,
    this.selectedCount = 0,
    this.isAllSelected = false,
  });

  @override
  List<Object?> get props => [
    notifications,
    isSelectionMode,
    selectedCount,
    isAllSelected,
  ];
}

class NotificationsFailure extends NotificationsState {
  final String error;

  const NotificationsFailure({required this.error});

  @override
  List<Object?> get props => [error];
}


