
import 'package:dio/dio.dart';
import 'package:doctor/cubit/send_notification_cubit/send_notification_state.dart';
import 'package:doctor/cubit/verify_code_cubit/verify_code_state.dart';
import 'package:doctor/make_email/new_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/end_points.dart';
import '../../models/forget_password_model.dart';
import '../reset_password_cubit/reset_password_cubit.dart';

class  SendNotificationCubit extends Cubit< SendNotificationState> {
  SendNotificationCubit() : super( SendNotificationInitial());

  Future<void> sendNotification(BuildContext context, String senderId,String userId, String meetingLink, String message) async {
    emit(SendNotificationLoading());
    try {
      final dio = Dio(BaseOptions(baseUrl: EndPoint.baseUrl,
        validateStatus: (status) {
          return status != null && status < 500;
        },));
      final response = await dio.post(
        "/notification/send",
        data: {
          "senderId":senderId,
          "userId":userId,
          "meetingLink":meetingLink,
          "message":message
        },
      );
      if (response.statusCode == 201) {
        final forgetPasswordModel = ForgetPasswordModel.fromJson(response.data);
        emit(SendNotificationSuccess(forgetPasswordModel.message??""));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(forgetPasswordModel.message??"")),
        );


      } else {
        final forgetPasswordModel = ForgetPasswordModel.fromJson(response.data);
        emit(SendNotificationFailure(forgetPasswordModel.message??""));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(forgetPasswordModel.message??"")),
        );
      }
    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error occurred while connecting to the API')),
      );
    }
  }}