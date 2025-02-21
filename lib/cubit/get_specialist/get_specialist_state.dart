import 'package:equatable/equatable.dart';
import '../../models/specialist_model.dart';

// Base state class
abstract class GetSpecialistState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state
class GetSpecialistInitial extends GetSpecialistState {}

// Loading state
class SpecialistLoading extends GetSpecialistState {}

// Success state
class SpecialistSuccess extends GetSpecialistState {
  final String message;
  final List<Item> specialists;

  SpecialistSuccess(this.message, this.specialists);

  @override
  List<Object?> get props => [message, specialists];
}

// Failure state
class SpecialistFailure extends GetSpecialistState {
  final String errMessage;

  SpecialistFailure(String s, {required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
