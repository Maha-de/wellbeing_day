import 'package:equatable/equatable.dart';

abstract class SendNotificationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class  SendNotificationInitial extends SendNotificationState {}

class  SendNotificationLoading extends SendNotificationState {}

class  SendNotificationSuccess extends SendNotificationState {
  final String message;

  SendNotificationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class  SendNotificationFailure extends  SendNotificationState {
  final String error;

  SendNotificationFailure(this.error);

  @override
  List<Object?> get props => [error];
}
