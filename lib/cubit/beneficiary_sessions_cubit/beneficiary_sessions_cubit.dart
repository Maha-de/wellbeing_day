// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../api/end_points.dart';
// import '../../models/beneficiaries_sessions_model.dart';
// import '../get_beneficiary_sessions_cubit/beneficiary_session_state.dart';
//
//
//
// class BeneficiarySessionCubit extends Cubit<BeneficiarySessionState> {
//   BeneficiarySessionCubit() : super(BeneficiarySessionInitial());
//   BeneficiarySessionsModel? sessionData;
//   Future<void> getDoctorSessionsTypes(BuildContext context,String id) async {
//     emit(BeneficiarySessionLoading());
//     try {
//       final dio = Dio(
//         BaseOptions(
//           baseUrl: EndPoint.baseUrl,
//           validateStatus: (status) => status != null && status < 500,
//         ),
//       );
//
//       final response = await dio.get("/beneficiary/$id");
//
//       if (response.statusCode == 200) {
//         final BeneficiarySessionsModel userProfileModel = BeneficiarySessionsModel.fromJson(response.data);
//         sessionData = userProfileModel;
//         print("sessions1: ${sessionData}");
//         print("sessions2: ${sessionData?.scheduledSessions}");
//         print("sessions3: ${sessionData?.completedSessions}");
//
//         emit(BeneficiarySessionSuccess("Profile loaded successfully", userProfileModel));
//       } else {
//         emit(BeneficiarySessionFailure("Error Fetching Data: ${response.data['message']}"));
//       }
//     } catch (e) {
//       emit(BeneficiarySessionFailure("Error occurred while connecting to the API: $e"));
//     }
//   }
//
//
//
// }
