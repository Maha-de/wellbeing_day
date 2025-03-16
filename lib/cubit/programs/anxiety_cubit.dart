
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/programs_model.dart';

abstract class ProgramState {}

class ProgramInitial extends ProgramState {}

class ProgramLoading extends ProgramState {}

class ProgramLoaded extends ProgramState {
  final ProgramsModel programDetails;

  // final List<Program> programs;

  ProgramLoaded( this.programDetails);
}

class ProgramError extends ProgramState {
  final String error;

  ProgramError(this.error);
}

// Cubit11
class ProgramCubit extends Cubit<ProgramState> {
  ProgramCubit() : super(ProgramInitial());

  Future<void> fetchPrograms() async {
    emit(ProgramLoading());
    try {
      final dio = Dio();

      final response = await dio.get("https://wellbeingproject.onrender.com/api/treatment");


      if (response.statusCode == 200) {
        // final Programs programs = programsFromJson(response.data);
        final ProgramsModel program = programsFromJson(response.data);

        emit(ProgramLoaded(program));
      } else {
        emit(ProgramError('Failed to load programs: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ProgramError('An error occurred: $e'));
    }
  }


}
