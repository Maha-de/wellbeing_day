import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/end_points.dart';
import '../../models/create_session_error_model.dart';
import '../../models/create_session_model.dart';
import 'create_session_state.dart';

class CreateSessionCubit extends Cubit<CreateSessionState> {
  CreateSessionCubit() : super(CreateSessionInitial());

  Future<void> updateUser(BuildContext context, String specialistId,String beneficiaryId,String token,
      String sessionType,
      String category,
      String description,
      String paymentStatus
     ) async {
    emit(CreateSessionLoading());
    try {
      final dio = Dio(BaseOptions(baseUrl: EndPoint.baseUrl,
        headers: {
          "Authorization":"Bearer $token"
      },
        validateStatus: (status) {
          return status != null && status < 500;
        },));
      final response = await dio.post(
        "/sessions/create",
        data:{
          "specialist": specialistId,
          "beneficiary": beneficiaryId,
          "sessionType": sessionType,
          "category": category,
          "subcategory": "",
          "sessionDate": DateTime.now().toUtc().toIso8601String(),
          "description": description,
          "paymentStatus": paymentStatus
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final m= CreateSessionModel.fromJson(response.data);
        String message=m.message??"";
        emit(CreateSessionSuccess(message));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );

        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => MultiBlocProvider(
        //         providers: [
        //           BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
        //           BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
        //           BlocProvider<CreateSessionCubit>(create: (_) => CreateSessionCubit()),
        //         ],
        //         child: HomeScreen()
        //     ),
        //   ),
        //       (route) => false,
        // );

      } else {
        final forgetPasswordModel = CreateSessionErrorModel.fromJson(response.data);
        emit(CreateSessionFailure(forgetPasswordModel.error??""));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(forgetPasswordModel.error??"")),
        );
      }
    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error occurred while connecting to the API')),
      );
    }
  }

}