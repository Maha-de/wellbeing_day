import 'package:doctor/models/notification_model.dart';

abstract class UserNotificationState {}

class UserNotificationInitial extends UserNotificationState {}

class UserNotificationLoading extends UserNotificationState {
  UserNotificationLoading();
}

class UserNotificationSuccess extends UserNotificationState {
  final List<NotificationModel> TodaySessions;

  UserNotificationSuccess({
    required this.TodaySessions,
  });
}

class UserNotificationFailure extends UserNotificationState {
  final String errMessage;

  UserNotificationFailure({required this.errMessage});
}
