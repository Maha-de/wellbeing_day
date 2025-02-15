import 'package:equatable/equatable.dart';

import '../../models/doctor_session_model.dart';
import '../../models/doctor_sessions_types_model.dart';
import '../../models/user_profile_model.dart';

abstract class DoctorSessionTypesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DoctorSessionTypesInitial extends DoctorSessionTypesState {}

class DoctorSessionTypesLoading extends DoctorSessionTypesState {}

class DoctorSessionTypesSuccess extends DoctorSessionTypesState {
  final String message;
  // final DoctorSessionsTypesModel session;
  final DoctorSessionsModel session;
  DoctorSessionTypesSuccess(this.message, this.session);

  @override
  List<Object?> get props => [message, session];
}

class DoctorSessionTypesFailure extends DoctorSessionTypesState {
  final String error;

  DoctorSessionTypesFailure(this.error);

  @override
  List<Object?> get props => [error];
}
