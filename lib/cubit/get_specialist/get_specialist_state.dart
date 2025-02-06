import '../../models/specialist_model.dart';

abstract class GetSpecialistState {}

final class GetSpecialistInitial extends GetSpecialistState {}


final class GetSpecialist extends GetSpecialistState {}



final class SpecialistLoading extends GetSpecialistState {}

final class SpecialistFailure extends GetSpecialistState {
  final String errMessage;


  SpecialistFailure({required this.errMessage});
}
final class SpecialistSuccess extends GetSpecialistState {

  final String message;
  final List<SpecialistModel> specialists;

  SpecialistSuccess(this.message,  this.specialists,);
}
