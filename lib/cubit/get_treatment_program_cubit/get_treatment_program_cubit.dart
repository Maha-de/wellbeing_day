import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/end_points.dart';
import '../../api/user_repository.dart';
import '../../models/doctor_by_category_model.dart';
import '../../models/sub_categories_model.dart';
import '../../models/treatment_programs_model.dart';
import 'get_treatment_program_state.dart';





class GetTreatmentProgramCubit extends Cubit<GetTreatmentProgramState> {
  GetTreatmentProgramCubit() : super(GetTreatmentProgramInitial());
  List<Program>? programs = [];

  Future<void> fetchProgramByName(BuildContext context, String programName) async {

    emit(GetTreatmentProgramLoading());
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: EndPoint.baseUrl,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final response = await dio.get("/treatment");

      if (response.statusCode == 200) {
        final treatmentProgramsModel = TreatmentProgramsModel.fromJson(response.data);
        programs = treatmentProgramsModel.programs;

        // البحث عن البرنامج بالاسم
        Program? selectedProgram = programs?.firstWhere(
              (prog) => prog.name == programName,
          orElse: () => Program(), // يرجّع كائن فارغ لو مفيش برنامج بالاسم ده
        );

        if (selectedProgram?.id != null) {
          emit(GetTreatmentProgramSuccess("Program loaded successfully", selectedProgram));
        } else {
          emit(GetTreatmentProgramFailure("No program found with this name", errMessage: "No program found with this name"));
        }
      } else {
        emit(GetTreatmentProgramFailure("${response.data['message']}", errMessage: " ${response.data['message']}"));
      }
    } catch (e) {
      emit(GetTreatmentProgramFailure("Error occurred while connecting to the API: $e", errMessage: "Error occurred while connecting to the API: $e"));
    }
  }
}







