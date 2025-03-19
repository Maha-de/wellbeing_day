import 'package:equatable/equatable.dart';
import '../../models/doctor_by_category_model.dart';


// Base state class
abstract class DoctorByCategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state
class DoctorByCategoryInitial extends DoctorByCategoryState {}

// Loading state
class DoctorByCategoryLoading extends DoctorByCategoryState {}

// Success state
class DoctorByCategorySuccess extends DoctorByCategoryState {
  final String message;
  final List<Specialist> specialists;

  DoctorByCategorySuccess(this.message, this.specialists);

  @override
  List<Object?> get props => [message, specialists];
}

// Failure state
class DoctorByCategoryFailure extends DoctorByCategoryState {
  final String errMessage;

  DoctorByCategoryFailure(String s, {required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
