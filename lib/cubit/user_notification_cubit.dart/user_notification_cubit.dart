import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor/api/end_points.dart';
import 'package:doctor/cubit/user_notification_cubit.dart/user_notification_state.dart';
import 'package:doctor/screens/specialist/repo/SpecialistRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';

class UserNotificationCubit extends Cubit<UserNotificationState> {
  final SpecialistRepository specialistRepository;
  UserNotificationCubit()
      : specialistRepository = SpecialistRepository(
          dio: Dio(
            BaseOptions(
              baseUrl: EndPoint.baseUrl,
              validateStatus: (status) => status != null && status < 500,
            ),
          ),
        ),
        super(UserNotificationInitial());

  Future<void> fetchDoctorSessions(String specialistId) async {
    emit(UserNotificationLoading());

    try {
      final todaySessions = await specialistRepository
          .getDoctorSessions(specialistId); //"67a4a7a716033e66a957deb6"

      emit(UserNotificationSuccess(TodaySessions: todaySessions));
    } catch (error) {
      log('Error fetching sessions: $error');
      error.printInfo();
      emit(UserNotificationFailure(errMessage: ""));
    }
  }

  Future<void> fetchBenificarySessions(String benId) async {
    emit(UserNotificationLoading());

    try {
      final sessions = await specialistRepository
          .getBenficSessions(benId); //67a9f7f55f1a1323e9f7936a

      emit(UserNotificationSuccess(TodaySessions: sessions));
    } catch (error) {
      log('Error fetching sessions: $error');
      error.printInfo();
      emit(UserNotificationFailure(errMessage: ""));
    }
  }
}
