import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/user_repository.dart';
import '../../models/specialist_model.dart';
import 'get_specialist_state.dart';



class GetSpecialistCubit extends Cubit<GetSpecialistState> {

  GetSpecialistCubit(this.userRepository) : super(GetSpecialistInitial());


  final UserRepository userRepository;

  List<SpecialistModel> specialists = [];



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
    try {
      emit(SpecialistLoading());


      final response = await userRepository.getSpecialists(

      ); // Fetch all specialists
      response.fold(
            (errMessage) {
              emit(SpecialistFailure(errMessage: errMessage));
              print("Error fetching specialists: $errMessage");

            },
            (specialistList) {

          emit(SpecialistSuccess( "Success", specialists));
          print("Fetched specialists: $specialists");
        },
      );
    } catch (e) {
      emit(SpecialistFailure(errMessage: 'An error occurred: $e'));
      print("Exception: $e");


    }
  }
}





