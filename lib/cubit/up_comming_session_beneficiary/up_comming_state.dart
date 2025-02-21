import 'package:doctor/models/Doctor_id_model.dart';
import 'package:equatable/equatable.dart';
import '../../models/beneficiary_up_coming_sessions_model.dart';
import '../../models/doctor_by_category_model.dart';
import '../../models/specialist_model.dart';

// Base state class
abstract class UpCommingState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state
class UpCommingInitial extends UpCommingState {}

// Loading state
class UpCommingLoading extends UpCommingState {}

// Success state
class UpCommingSuccess extends UpCommingState {
  final String message;
  final BeneficiaryUpComingSessionsModel upComingSessions;
  final List<DoctorByIdModel> doctors;
  UpCommingSuccess(this.message, this.upComingSessions, this.doctors);

  @override
  List<Object?> get props => [message, upComingSessions];
}

// Failure state
class UpCommingFailure extends UpCommingState {
  final String errMessage;

  UpCommingFailure(String s, {required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
