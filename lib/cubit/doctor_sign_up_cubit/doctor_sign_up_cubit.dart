import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor/models/Specialist.dart';
import 'package:doctor/core/strings.dart';
import 'package:doctor/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/end_points.dart';
import '../../screens/specialist/repo/SpecialistRepository.dart';
import 'doctor_sign_up_state.dart';
import 'dart:developer';

class SignUpSpecialistCubit extends Cubit<SignUpSpecialistState> {
  final SpecialistRepository specialistRepository = SpecialistRepository(
    dio: Dio(
      BaseOptions(
        baseUrl: EndPoint.baseUrl,
        validateStatus: (status) => status != null && status < 500,
      ),
    ),
  );

  SignUpSpecialistCubit() : super(SignUpSpecialistInitial());

  Future<void> signUp(Specialist doctor) async {
    emit(SignUpSpecialistLoading(message: SpSignUpLoadingMsg));
    log("Sign-up is loading...");

    try {
      // Call the sign-up function from the repository
      Response response = await specialistRepository.signUpSpecialist(doctor);
      var data = response.data;
      // Check for errors in the response
      if (data["errors"] != null) {
        emit(SignUpSpecialistFailure(errMessage: data["errors"][0]['msg']));
        return; // Exit early if there are errors
      }

      // Extract userId from the response
      var userId = data['specialist']['_id'];

      // Check for successful response status
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Store the doctorId in shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('doctorId', userId);

        log(response.data.toString());
        emit(SignUpSpecialistSuccess(
            message: SpSignUpSuccessMsg, userId: userId));
        log(response.statusMessage!);
      } else {
        // Handle unexpected response status
        emit(SignUpSpecialistFailure(
            errMessage:
                SpSignUpErrorMsg + " " + handleFailureResponse(response.data)));
        log("Failure: ${response.statusCode} - ${response.data}");
      }
    } on ServerException catch (e) {
      // Handle server exceptions
      log(e.errModel.message!);
      emit(SignUpSpecialistFailure(errMessage: e.errModel.message!));
    } catch (e) {
      // Handle any other exceptions
      log("Unexpected error: ${e.toString()}");
      emit(
          SignUpSpecialistFailure(errMessage: "An unexpected error occurred."));
    }
  }
}

String handleFailureResponse(Map<String, dynamic> errorResponse) {
  if (errorResponse.containsKey('errors') &&
      errorResponse['errors'].isNotEmpty) {
    String errorMessage = errorResponse['errors'][0]['msg'];
    return "$errorMessage";
  }
  return "";
}
