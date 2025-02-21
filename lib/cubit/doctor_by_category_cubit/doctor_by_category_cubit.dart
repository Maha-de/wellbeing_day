import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/end_points.dart';
import '../../api/user_repository.dart';
import '../../models/doctor_by_category_model.dart';
import '../../models/specialist_model.dart';
import 'doctor_by_category_state.dart';



class DoctorByCategoryCubit extends Cubit<DoctorByCategoryState> {

  DoctorByCategoryCubit() : super(DoctorByCategoryInitial());




  List<Specialists> specialists = [];



  TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController nationalityController = TextEditingController();
    TextEditingController homeAddressController = TextEditingController();
    TextEditingController workAddressController = TextEditingController();
    TextEditingController workController = TextEditingController();
    TextEditingController about_doctor_Controller = TextEditingController();
    TextEditingController exp_year_Controller = TextEditingController();
    TextEditingController session_time_Controller = TextEditingController();
    TextEditingController session_price_Controller = TextEditingController();

    

  Future<void> fetchSpecialistsbycategory(String category,String subcategory) async {

      emit(DoctorByCategoryLoading());
      try {
        final dio = Dio(
          BaseOptions(
            baseUrl: EndPoint.baseUrl,
            validateStatus: (status) => status != null && status < 500,

          ),

        );

        final response = await dio.get("/specialist/getByCategory",
            data: {

                "category": [category],
                "subcategory": [subcategory]

            });

        if (response.statusCode == 200) {
          final specialistModel = DoctorByCategoryModel.fromJson(response.data);
          specialists = specialistModel.specialists??[];
            print(specialists);
           print("those are categories"+"{$specialists}");
          emit(DoctorByCategorySuccess("Profile loaded successfully", specialists));
        } else {
          emit(DoctorByCategoryFailure("${response.data['message']}", errMessage: " ${response.data['message']}"));
        }
      } catch (e) {
        emit(DoctorByCategoryFailure("Error occurred while connecting to the API: $e", errMessage: "Error occurred while connecting to the API: $e"));
      }
  }
}





