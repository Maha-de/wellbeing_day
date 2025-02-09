import 'package:equatable/equatable.dart';

import '../../models/Doctor_id_model.dart';
import '../../models/user_profile_model.dart';

abstract class DoctorProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DoctorProfileInitial extends DoctorProfileState {}

class DoctorProfileLoading extends DoctorProfileState {}

class DoctorProfileSuccess extends DoctorProfileState {
  final String message;
  final DoctorByIdModel doctorProfile;

  DoctorProfileSuccess(this.message, this.doctorProfile);

  @override
  List<Object?> get props => [message, doctorProfile];
}

class DoctorProfileFailure extends DoctorProfileState {
  final String error;

  DoctorProfileFailure(this.error);

  @override
  List<Object?> get props => [error];
}
