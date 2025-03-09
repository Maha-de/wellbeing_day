import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/end_points.dart';
import '../../models/advertisments_model.dart';
import '../../models/get_notification_model.dart';
import 'beneficiary_notification_state.dart';

class GetBeneficiaryNotificationCubit extends Cubit<GetBeneficiaryNotificationState> {

  GetBeneficiaryNotificationCubit() : super(GetBeneficiaryNotificationInitial());
  List<GetNotificationModel>notifications=[];


  Future<void> fetchAllNotifications(String id) async {


    emit(GetBeneficiaryNotificationLoading());
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: EndPoint.baseUrl,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final response = await dio.get("/notification/$id");

      if (response.statusCode == 200) {
        final List<GetNotificationModel> notificationsModel =
        (response.data as List).map((e) => GetNotificationModel.fromJson(e)).toList();

        notifications=notificationsModel??[];




        emit(GetBeneficiaryNotificationSuccess("Profile loaded successfully", notifications));
      } else {
        emit(GetBeneficiaryNotificationFailure("${response.data['message']}", errMessage: " ${response.data['message']}"));
      }
    } catch (e) {
      print(e);
     
      emit(GetBeneficiaryNotificationFailure("Error occurred while connecting to the API: $e", errMessage: "Error occurred while connecting to the API: $e"));
    }
  }

}





