import 'package:equatable/equatable.dart';

abstract class DeleteDoctorAccountState extends Equatable {
  @override
  List<Object?> get props => [];
}

class  DeleteDoctorAccountInitial extends DeleteDoctorAccountState {}

class  DeleteDoctorAccountLoading extends DeleteDoctorAccountState {}

class  DeleteDoctorAccountSuccess extends DeleteDoctorAccountState {
  final String message;

  DeleteDoctorAccountSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class  DeleteDoctorAccountFailure extends  DeleteDoctorAccountState {
  final String error;

  DeleteDoctorAccountFailure(this.error);

  @override
  List<Object?> get props => [error];
}
