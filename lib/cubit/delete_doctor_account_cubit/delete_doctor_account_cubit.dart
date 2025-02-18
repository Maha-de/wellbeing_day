
import 'package:dio/dio.dart';
import 'package:doctor/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:doctor/models/delete_doctor_model.dart';
import 'package:doctor/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/end_points.dart';
import '../../models/forget_password_model.dart';
import 'delete_doctor_account_state.dart';

class  DeleteDoctorAccountCubit extends Cubit< DeleteDoctorAccountState> {
  DeleteDoctorAccountCubit() : super( DeleteDoctorAccountInitial());

  Future<void> deleteAccount(BuildContext context, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    emit(DeleteDoctorAccountLoading());
    try {
      final dio = Dio(BaseOptions(baseUrl: EndPoint.baseUrl,
        validateStatus: (status) {
          return status != null && status < 500;
        },));
      final response = await dio.delete(
        "/specialist/delete/$userId",
      );
      if (response.statusCode == 200) {
        final forgetPasswordModel = DeleteDoctorModel.fromJson(response.data);
        emit(DeleteDoctorAccountSuccess(forgetPasswordModel.message??""));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(forgetPasswordModel.message??"")),
        );

        prefs.remove('userId');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SplashScreen(),
          ),
        );;

      } else {
        final forgetPasswordModel = ForgetPasswordModel.fromJson(response.data);
        emit(DeleteDoctorAccountFailure(forgetPasswordModel.message??""));
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