import 'package:dio/dio.dart';
import 'package:doctor/cubit/up_comming_session_beneficiary/up_comming_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/end_points.dart';
import '../../api/user_repository.dart';
import '../../models/Doctor_id_model.dart';
import '../../models/beneficiary_up_coming_sessions_model.dart';
import '../../models/doctor_by_category_model.dart';
import '../../models/specialist_model.dart';




class UpCommingCubit extends Cubit<UpCommingState> {
  UpCommingCubit() : super(UpCommingInitial());

  Future<void> UpComming(String id, String token) async {
    print(id);
    print(token);
    emit(UpCommingLoading());
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: EndPoint.baseUrl,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      // 1️⃣ جلب الجلسات القادمة
      final sessionResponse = await dio.get(
        "/admin/upcomingSessions/$id",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (sessionResponse.statusCode == 200) {
        final sessionModel = BeneficiaryUpComingSessionsModel.fromJson(sessionResponse.data);

        // استخراج جميع الـ doctorId من الجلسات
        final doctorIds = sessionModel.upcomingSessions?.map((s) => s.specialist).toSet().toList()??[];

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

        emit(UpCommingSuccess("Data loaded successfully", sessionModel, doctorsData));
      } else {
        emit(UpCommingFailure("${sessionResponse.data['message']}", errMessage: '${sessionResponse.data['message']}'));
      }
    } catch (e) {
      emit(UpCommingFailure("Error occurred: $e", errMessage: 'Error occurred'));
    }
  }
}






