import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CreateSessionState {}

class CreateSessionInitial extends CreateSessionState {}

class CreateSessionLoading extends CreateSessionState {}

class CreateSessionSuccess extends CreateSessionState {}

class CreateSessionError extends CreateSessionState {
  final String message;
  CreateSessionError(this.message);
}
