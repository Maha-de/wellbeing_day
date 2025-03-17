import 'package:dio/dio.dart';
import 'package:doctor/models/doctor_sessions_types_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/end_points.dart';
import '../../models/get_group_threapy_model.dart';
import 'get_group_threapy_state.dart';

class GetGroupThreapyCubit extends Cubit<GetGroupThreapyState> {
  GetGroupThreapyCubit() : super(GetGroupThreapyInitial());
  GetGroupThreapyModel? sessionData;
  Future<void> getDoctorSessionsTypes(BuildContext context,String id) async {
    emit(GetGroupThreapyLoading());
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: EndPoint.baseUrl,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final response = await dio.get("/sessions/groupTherapy/$id");

      if (response.statusCode == 200) {
        final userProfileModel = GetGroupThreapyModel.fromJson(response.data);
        sessionData = userProfileModel;
        print("sessions1: ${sessionData}");


        emit(GetGroupThreapySuccess("Profile loaded successfully", userProfileModel));
      } else {
        emit(GetGroupThreapyFailure("${response.data['message']}"));
      }
    } catch (e) {
      emit(GetGroupThreapyFailure("Error occurred while connecting to the API: $e"));
    }
  }



}
