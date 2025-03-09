import 'package:equatable/equatable.dart';
import '../../models/advertisments_model.dart';
import '../../models/doctor_by_category_model.dart';
import '../../models/get_notification_model.dart';
import '../../models/sub_categories_model.dart';


// Base state class
abstract class GetBeneficiaryNotificationState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state
class GetBeneficiaryNotificationInitial extends GetBeneficiaryNotificationState {}

// Loading state
class GetBeneficiaryNotificationLoading extends GetBeneficiaryNotificationState {}

// Success state
class GetBeneficiaryNotificationSuccess extends GetBeneficiaryNotificationState {
  final String message;
  final List<GetNotificationModel>notifications;

  GetBeneficiaryNotificationSuccess(this.message, this.notifications);

  @override
  List<Object?> get props => [message, notifications];
}

// Failure state
class GetBeneficiaryNotificationFailure extends GetBeneficiaryNotificationState {
  final String errMessage;

  GetBeneficiaryNotificationFailure(String s, {required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
