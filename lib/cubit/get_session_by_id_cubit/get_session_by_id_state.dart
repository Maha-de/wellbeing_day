import 'package:equatable/equatable.dart';
import '../../models/get_session_by_id_model.dart';


abstract class GetSessionByIdState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSessionByIdInitial extends GetSessionByIdState {}

class GetSessionByIdLoading extends GetSessionByIdState {}

class GetSessionByIdSuccess extends GetSessionByIdState {
  final String message;
  // final DoctorSessionsTypesModel session;
  final GetSessionByIdModel session;
  GetSessionByIdSuccess(this.message, this.session);

  @override
  List<Object?> get props => [message, session];
}

class GetSessionByIdFailure extends GetSessionByIdState {
  final String error;

  GetSessionByIdFailure(this.error);

  @override
  List<Object?> get props => [error];
}
