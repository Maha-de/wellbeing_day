import 'package:dio/dio.dart';
import 'package:doctor/cubit/user_profile_cubit/user_profile_state.dart';
import 'package:doctor/models/doctor_sessions_types_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/end_points.dart';
import '../../models/doctor_session_model.dart';
import '../../models/user_profile_model.dart';
import '../reset_password_cubit/reset_password_state.dart';
import 'doctor_session_types_state.dart';


class DoctorSessionTypesCubit extends Cubit<DoctorSessionTypesState> {
  DoctorSessionTypesCubit() : super(DoctorSessionTypesInitial());
  // DoctorSessionsTypesModel? sessionData;
  // Future<void> getDoctorSessionsTypes(BuildContext context) async {
  //   emit(DoctorSessionTypesLoading());
  //   try {
  //     final dio = Dio(
  //       BaseOptions(
  //         baseUrl: EndPoint.baseUrl,
  //         validateStatus: (status) => status != null && status < 500,
  //       ),
  //     );
  //
  //     final response = await dio.get("/sessions");
  //
  //     if (response.statusCode == 200) {
  //       final userProfileModel = DoctorSessionsTypesModel.fromJson(response.data);
  //       sessionData = userProfileModel;
  //       print("sessions1: ${sessionData}");
  //       print("sessions2: ${sessionData?.scheduledSessions}");
  //       print("sessions3: ${sessionData?.completedSessions}");
  //
  //       emit(DoctorSessionTypesSuccess("Profile loaded successfully", userProfileModel));
  //     } else {
  //       emit(DoctorSessionTypesFailure("Error Fetching Data: ${response.data['message']}"));
  //     }
  //   } catch (e) {
  //     emit(DoctorSessionTypesFailure("Error occurred while connecting to the API: $e"));
  //   }
  // }

  DoctorSessionsModel? doctorSessionData;
  Future<void> getDoctorSessions(BuildContext context,String id) async {
    emit(DoctorSessionTypesLoading());
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: EndPoint.baseUrl,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final response = await dio.get("/sessions/specialist/67a4a7a716033e66a957deb6");

      if (response.statusCode == 200) {
        final userProfileModel = DoctorSessionsModel.fromJson(response.data);
        doctorSessionData = userProfileModel;
        print("sessions1: ${doctorSessionData}");
        print("sessions2: ${doctorSessionData?.freeConsultations}");
        print("sessions3: ${doctorSessionData?.instantSessions}");
        print("sessions2: ${doctorSessionData?.scheduledSessions}");
        print("sessions3: ${doctorSessionData?.completedSessions}");

        emit(DoctorSessionTypesSuccess("Profile loaded successfully", userProfileModel));
      } else {
        emit(DoctorSessionTypesFailure("Error Fetching Data: ${response.data['message']}"));
      }
    } catch (e) {
      emit(DoctorSessionTypesFailure("Error occurred while connecting to the API: $e"));
    }
  }

}
