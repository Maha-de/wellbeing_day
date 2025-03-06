import 'package:equatable/equatable.dart';

abstract class CreateSessionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateSessionInitial extends CreateSessionState {}

class CreateSessionLoading extends CreateSessionState {}

class CreateSessionSuccess extends CreateSessionState {
  final String message;

  CreateSessionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CreateSessionFailure extends CreateSessionState {
  final String error;

  CreateSessionFailure(this.error);

  @override
  List<Object?> get props => [error];
}

