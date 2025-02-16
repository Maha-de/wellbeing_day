import 'package:equatable/equatable.dart';

import '../../models/doctor_session_model.dart';
import '../../models/doctor_sessions_types_model.dart';
import '../../models/user_profile_model.dart';

abstract class DoctorSessionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DoctorSessionInitial extends DoctorSessionState {}

class DoctorSessionLoading extends DoctorSessionState {}

class DoctorSessionSuccess extends DoctorSessionState {
  final String message;
  // final DoctorSessionsTypesModel session;
  final DoctorSessionsTypesModel session;
  DoctorSessionSuccess(this.message, this.session);

  @override
  List<Object?> get props => [message, session];
}

class DoctorSessionFailure extends DoctorSessionState {
  final String error;

  DoctorSessionFailure(this.error);

  @override
  List<Object?> get props => [error];
}
