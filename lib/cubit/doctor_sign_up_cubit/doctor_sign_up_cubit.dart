// import 'package:dio/dio.dart';
// import 'package:doctor/core/strings.dart';
// import 'dart:developer';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../api/end_points.dart';
// import '../../errors/exceptions.dart';
// import '../../models/doctor.dart';
// import 'doctor_sign_up_state.dart';
// import 'package:http_parser/http_parser.dart';

// class SignUpSpecialistCubit extends Cubit<SignUpSpecialistState> {
//   SignUpSpecialistCubit() : super(SignUpSpecialistInitial());

//   Future<void> signUp(Doctor doctor) async {
//     log("Sign-up is loading...");
//     emit(SignUpSpecialistLoading(message: SpSignUpLoadingMsg));

//     try {
//       final dio = Dio(
//         BaseOptions(
//           baseUrl: EndPoint.baseUrl,
//           validateStatus: (status) => status != null && status < 500,
//         ),
//       );

//       // Prepare form data
//       FormData formData = FormData.fromMap({
//         'firstName': doctor.firstName,
//         'lastName': doctor.lastName,
//         'email': doctor.email,
//         'phone': doctor.phone,
//         'password': doctor.password,
//         'nationality': doctor.nationality,
//         'work': doctor.work,
//         'yearsExperience': doctor.yearOfExperience.toString(),
//         'workAddress': doctor.workAddress,
//         'homeAddress': doctor.homeAddress,
//         'bio': doctor.bio,
//         'sessionPrice': doctor.sessionPrice,
//         'sessionDuration': doctor.sessionDuration,
//         'specialties': doctor.specialties,
//         if (doctor.idOrPassport != null)
//           'idOrPassport': await MultipartFile.fromFile(
//             doctor.idOrPassport!.path!,
//             contentType: MediaType('application', 'pdf'),
//           ),
//         if (doctor.resume != null)
//           'resume': await MultipartFile.fromFile(
//             doctor.resume!.path!,
//             contentType: MediaType('application', 'pdf'),
//           ),
//         if (doctor.certificates != null)
//           'certificates': await MultipartFile.fromFile(
//             doctor.certificates!.path!,
//             contentType: MediaType('application', 'pdf'),
//           ),
//         if (doctor.ministryLicense != null)
//           'ministryLicense': await MultipartFile.fromFile(
//             doctor.ministryLicense!.path!,
//             contentType: MediaType('application', 'pdf'),
//           ),
//         if (doctor.associationMembership != null)
//           'associationMembership': await MultipartFile.fromFile(
//             doctor.associationMembership!.path!,
//             contentType: MediaType('application', 'pdf'),
//           ),
//       });

//       Response response = await dio.post(
//         EndPoint.signUpSpecialist,
//         data: formData,
//         options: Options(
//           headers: {
//             "Content-Type": "multipart/form-data",
//           },
//         ),
//         onSendProgress: (int sent, int total) {
//           log("Progress: $sent / $total");
//         },
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         log("Success: ${response.data}");
//         emit(SignUpSpecialistSuccess(message: SpSignUpSuccessMsg));
//       } else {
//         emit(SignUpSpecialistFailure(
//           errMessage:
//               SpSignUpErrorMsg + " " + handleFailureResponse(response.data),
//         ));
//         log("Failure: ${response.statusCode} - ${response.data}");
//       }
//     } on ServerException catch (e) {
//       emit(SignUpSpecialistFailure(errMessage: e.errModel.data));
//     }
//   }
// }

// String handleFailureResponse(Map<String, dynamic> errorResponse) {
//   if (errorResponse.containsKey('errors') &&
//       errorResponse['errors'].isNotEmpty) {
//     String errorMessage = errorResponse['errors'][0]['msg'];
//     return "$errorMessage";
//   }
//   return "";
// }
import 'dart:convert';

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

  // Future<void> signUp(Specialist doctor) async {
  //   emit(SignUpSpecialistLoading(message: SpSignUpLoadingMsg));
  //   log("Sign-up is loading...");
  //
  //   try {
  //     // Call the sign-up function from the repository
  //     Response response = await specialistRepository.signUpSpecialist(doctor);
  //     var data = response.data;
  //     if (data["errors"] != null) {
  //       emit(SignUpSpecialistFailure(errMessage: data["errors"][0]['msg']));
  //     } else {
  //       var userId = data['specialist']['_id'];
  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         final prefs = await SharedPreferences.getInstance();
  //         prefs.setString('doctorId', userId);
  //         log(response.data.toString());
  //         emit(SignUpSpecialistSuccess(
  //             message: SpSignUpSuccessMsg, userId: userId));
  //
  //         log(response.statusMessage!);
  //       } else {
  //         emit(SignUpSpecialistFailure(
  //             errMessage: SpSignUpErrorMsg +
  //                 " " +
  //                 handleFailureResponse(response.data)));
  //         log("Failure: ${response.statusCode} - ${response.data}");
  //       }
  //     }
  //   } on ServerException catch (e) {
  //     log(e.errModel.message!);
  //     emit(SignUpSpecialistFailure(errMessage: e.errModel.message!));
  //   }
  // }

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
            errMessage: SpSignUpErrorMsg +
                " " +
                handleFailureResponse(response.data)));
        log("Failure: ${response.statusCode} - ${response.data}");
      }
    } on ServerException catch (e) {
      // Handle server exceptions
      log(e.errModel.message!);
      emit(SignUpSpecialistFailure(errMessage: e.errModel.message!));
    } catch (e) {
      // Handle any other exceptions
      log("Unexpected error: $e");
      emit(SignUpSpecialistFailure(errMessage: "An unexpected error occurred."));
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
