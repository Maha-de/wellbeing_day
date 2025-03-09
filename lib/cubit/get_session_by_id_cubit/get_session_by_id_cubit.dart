import 'package:dio/dio.dart';
import 'package:doctor/models/doctor_sessions_types_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/end_points.dart';
import '../../models/get_session_by_id_model.dart';
import 'get_session_by_id_state.dart';


class GetSessionByIdCubit extends Cubit<GetSessionByIdState> {
  GetSessionByIdCubit() : super(GetSessionByIdInitial());
  GetSessionByIdModel? sessionData;
  Future<void> getDoctorSessionsTypes(BuildContext context,String id) async {
    emit(GetSessionByIdLoading());
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: EndPoint.baseUrl,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final response = await dio.get("/sessions/$id");

      if (response.statusCode == 200) {
        final userProfileModel = GetSessionByIdModel.fromJson(response.data);
        sessionData = userProfileModel;
        print("sessions1: ${sessionData}");


        emit(GetSessionByIdSuccess("Profile loaded successfully", userProfileModel));
      } else {
        emit(GetSessionByIdFailure("Error Fetching Data: ${response.data['message']}"));
      }
    } catch (e) {
      emit(GetSessionByIdFailure("Error occurred while connecting to the API: $e"));
    }
  }

// DoctorSessionsModel? doctorSessionData;
// Future<void> getDoctorSessions(BuildContext context,String id) async {
//   emit(DoctorSessionLoading());
//   try {
//     final dio = Dio(
//       BaseOptions(
//         baseUrl: EndPoint.baseUrl,
//         validateStatus: (status) => status != null && status < 500,
//       ),
//     );
//
//     final response = await dio.get("/sessions/specialist/$id");
//
//     if (response.statusCode == 200) {
//       final userProfileModel = DoctorSessionsModel.fromJson(response.data);
//       doctorSessionData = userProfileModel;
//       print("sessions1: ${doctorSessionData}");
//       print("sessions2: ${doctorSessionData?.freeConsultations}");
//       print("sessions3: ${doctorSessionData?.instantSessions}");
//
//       emit(DoctorSessionSuccess("Profile loaded successfully", userProfileModel));
//     } else {
//       emit(DoctorSessionFailure("Error Fetching Data: ${response.data['message']}"));
//     }
//   } catch (e) {
//     emit(DoctorSessionFailure("Error occurred while connecting to the API: $e"));
//   }
// }

}
