import 'package:doctor/models/beneficiary_session_model.dart';
import 'package:equatable/equatable.dart';

import '../../models/doctor_session_model.dart';
import '../../models/doctor_sessions_types_model.dart';
import '../../models/user_profile_model.dart';

abstract class BeneficiarySessionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BeneficiarySessionInitial extends BeneficiarySessionState {}

class BeneficiarySessionLoading extends BeneficiarySessionState {}

class BeneficiarySessionSuccess extends BeneficiarySessionState {
  final String message;
  // final DoctorSessionsTypesModel session;
  final BeneficiarySessionModel session;
  BeneficiarySessionSuccess(this.message, this.session);

  @override
  List<Object?> get props => [message, session];
}

class BeneficiarySessionFailure extends BeneficiarySessionState {
  final String error;

  BeneficiarySessionFailure(this.error);

  @override
  List<Object?> get props => [error];
}
