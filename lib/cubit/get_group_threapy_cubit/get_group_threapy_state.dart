import 'package:equatable/equatable.dart';

import '../../models/doctor_session_model.dart';
import '../../models/doctor_sessions_types_model.dart';
import '../../models/get_group_threapy_model.dart';
import '../../models/user_profile_model.dart';

abstract class GetGroupThreapyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetGroupThreapyInitial extends GetGroupThreapyState {}

class GetGroupThreapyLoading extends GetGroupThreapyState {}

class GetGroupThreapySuccess extends GetGroupThreapyState {
  final String message;
  // final DoctorSessionsTypesModel session;
  final GetGroupThreapyModel session;
  GetGroupThreapySuccess(this.message, this.session);

  @override
  List<Object?> get props => [message, session];
}

class GetGroupThreapyFailure extends GetGroupThreapyState {
  final String error;

  GetGroupThreapyFailure(this.error);

  @override
  List<Object?> get props => [error];
}
