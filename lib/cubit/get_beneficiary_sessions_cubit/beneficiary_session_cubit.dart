import 'package:dio/dio.dart';
import 'package:doctor/cubit/user_profile_cubit/user_profile_state.dart';
import 'package:doctor/models/doctor_sessions_types_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/end_points.dart';
import '../../models/Doctor_id_model.dart';
import '../../models/beneficiaries_sessions_model.dart';
import '../../models/beneficiary_session_model.dart';
import '../../models/doctor_session_model.dart';
import '../../models/user_profile_model.dart';
import '../reset_password_cubit/reset_password_state.dart';
import 'beneficiary_session_state.dart';


class BeneficiarySessionCubit extends Cubit<BeneficiarySessionState> {
  BeneficiarySessionCubit() : super(BeneficiarySessionInitial());
  BeneficiarySessionModel? sessionData;
  Future<void> getDoctorSessionsTypes(BuildContext context,String id) async {
    emit(BeneficiarySessionLoading());
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: EndPoint.baseUrl,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final response = await dio.get("/beneficiaries/sessions/$id");

      if (response.statusCode == 200) {
        final userProfileModel = BeneficiarySessionModel.fromJson(response.data);
        sessionData = userProfileModel;
        // استخراج جميع الـ doctorId من الجلسات
        final doctorIds = userProfileModel.upcomingSessions?.map((s) => s.specialist).toSet().toList()??[];
        final doctorIdsComplete = userProfileModel.completedSessions?.map((s) => s.specialist).toSet().toList()??[];
        final doctorIdsCancled = userProfileModel.canceledSessions?.map((s) => s.specialist).toSet().toList()??[];
        // 2️⃣ جلب بيانات كل طبيب
        final doctorResponses = await Future.wait(
          doctorIds.map((doctorId) => dio.get(
            "/specialist/getById/$doctorId",

          )),
        );

        // تحويل البيانات إلى قائمة `DoctorByIdModel`
        final doctorsData = doctorResponses
            .where((res) => res.statusCode == 200||res.statusCode==201)
            .map((res) => DoctorByIdModel.fromJson(res.data))
            .toList();
        final doctorResponsesCompleted = await Future.wait(
          doctorIdsComplete.map((doctorId) => dio.get(
            "/specialist/getById/$doctorId",

          )),
        );
        final doctorsDataCompleted = doctorResponsesCompleted
            .where((res) => res.statusCode == 200||res.statusCode==201)
            .map((res) => DoctorByIdModel.fromJson(res.data))
            .toList();
        final doctorResponsesCancled = await Future.wait(
          doctorIdsCancled.map((doctorId) => dio.get(
            "/specialist/getById/$doctorId",

          )),
        );
        final doctorsDataCancled = doctorResponsesCancled
            .where((res) => res.statusCode == 200||res.statusCode==201)
            .map((res) => DoctorByIdModel.fromJson(res.data))
            .toList();
        print("sessions1: ${sessionData?.upcomingSessions}");
        print("sessions1: ${sessionData?.canceledSessions}");
        print("sessions2: ${sessionData?.scheduledSessions}");
        print("sessions3: ${sessionData?.completedSessions}");

        emit(BeneficiarySessionSuccess("Profile loaded successfully", userProfileModel,doctorsData,doctorsDataCompleted,doctorsDataCancled));
      } else {
        emit(BeneficiarySessionFailure("Error Fetching Data: ${response.data['message']}"));
      }
    } catch (e) {
      emit(BeneficiarySessionFailure("Error occurred while connecting to the API: $e"));
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
