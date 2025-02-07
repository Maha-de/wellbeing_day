import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/end_points.dart';
import '../../api/user_repository.dart';
import '../../models/specialist_model.dart';
import 'get_specialist_state.dart';



class GetSpecialistCubit extends Cubit<GetSpecialistState> {

  GetSpecialistCubit(this.userRepository) : super(GetSpecialistInitial());


  final UserRepository userRepository;

  List<Specialist> specialists = [];



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

    

  Future<void> fetchSpecialists() async {

      emit(SpecialistLoading());
      try {
        final dio = Dio(
          BaseOptions(
            baseUrl: EndPoint.baseUrl,
            validateStatus: (status) => status != null && status < 500,
          ),
        );

        final response = await dio.get("/specialist/getSpecialists");

        if (response.statusCode == 201) {
          final specialistModel = SpecialistModel.fromJson(response.data);
          specialists = specialistModel.specialists??[];


          emit(SpecialistSuccess("Profile loaded successfully", specialists));
        } else {
          emit(SpecialistFailure("Error Fetching Data: ${response.data['message']}", errMessage: "Error Fetching Data: ${response.data['message']}"));
        }
      } catch (e) {
        emit(SpecialistFailure("Error occurred while connecting to the API: $e", errMessage: "Error occurred while connecting to the API: $e"));
      }
  }
}





