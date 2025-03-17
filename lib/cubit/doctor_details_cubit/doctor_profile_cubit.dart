import 'package:dio/dio.dart';
import 'package:doctor/cubit/user_profile_cubit/user_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/end_points.dart';
import '../../models/Doctor_id_model.dart';
import '../../models/user_profile_model.dart';
import '../reset_password_cubit/reset_password_state.dart';
import 'doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  DoctorProfileCubit() : super(DoctorProfileInitial());

  DoctorByIdModel? userData;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = TextEditingController();
  final nationalityController = TextEditingController();
  final addressController = TextEditingController();
  final regionController = TextEditingController();

  Future<void> getUserProfile(BuildContext context, String id) async {
    emit(DoctorProfileLoading());
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: EndPoint.baseUrl,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final response = await dio.get("/specialist/getById/$id");

      if (response.statusCode == 201) {
        print("ssss");

        final userProfileModel = DoctorByIdModel.fromJson(response.data);
        userData = userProfileModel;
         print(userData);
        // Update controllers with data
        firstNameController.text = userData?.specialist?.firstName ?? "";
        lastNameController.text = userData?.specialist?.lastName ?? "";
        emailController.text = userData?.specialist?.email ?? "";
        phoneController.text = userData?.specialist?.phone ?? "";
        nationalityController.text = userData?.specialist?.nationality ?? "";
        addressController.text = userData?.specialist?.homeAddress ?? "";


        emit(DoctorProfileSuccess("Profile loaded successfully", userProfileModel));
      } else {
        emit(DoctorProfileFailure("Error Fetching Data: ${response.data['message']}"));
      }
    } catch (e) {
      emit(DoctorProfileFailure("Error occurred while connecting to the API: $e"));
    }
  }



}
