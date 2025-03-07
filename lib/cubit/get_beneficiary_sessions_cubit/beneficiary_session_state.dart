import 'package:equatable/equatable.dart';
import '../../models/Doctor_id_model.dart';
import '../../models/beneficiaries_sessions_model.dart';
import '../../models/beneficiary_session_model.dart';

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
  final List<DoctorByIdModel> doctors;
  final List<DoctorByIdModel> doctorsCompleted;
  final List<DoctorByIdModel> doctorsCanceled;
  BeneficiarySessionSuccess(this.message, this.session, this.doctors, this.doctorsCompleted, this.doctorsCanceled);

  @override
  List<Object?> get props => [message, session];
}

class BeneficiarySessionFailure extends BeneficiarySessionState {
  final String error;

  BeneficiarySessionFailure(this.error);

  @override
  List<Object?> get props => [error];
}
