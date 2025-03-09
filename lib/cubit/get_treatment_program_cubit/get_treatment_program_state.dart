import 'package:equatable/equatable.dart';
import '../../models/doctor_by_category_model.dart';

import '../../models/sub_categories_model.dart';
import '../../models/treatment_programs_model.dart';


// Base state class
abstract class GetTreatmentProgramState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state
class GetTreatmentProgramInitial extends GetTreatmentProgramState {}

// Loading state
class GetTreatmentProgramLoading extends GetTreatmentProgramState {}

// Success state
class GetTreatmentProgramSuccess extends GetTreatmentProgramState {
  final String message;
  final Program? programs;

  GetTreatmentProgramSuccess(this.message, this.programs);

  @override
  List<Object?> get props => [message, programs];
}

// Failure state
class GetTreatmentProgramFailure extends GetTreatmentProgramState {
  final String errMessage;

  GetTreatmentProgramFailure(String s, {required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
