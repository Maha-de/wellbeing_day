import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/end_points.dart';
import '../../api/user_repository.dart';
import '../../models/advertisments_model.dart';
import '../../models/doctor_by_category_model.dart';
import '../../models/sub_categories_model.dart';
import 'get_all_ads_state.dart';





class GetAllAdsCubit extends Cubit<GetAllAdsState> {

  GetAllAdsCubit() : super(GetAllAdsInitial());
  List<Adv>advs=[];


  Future<void> fetchAllAdv() async {


    emit(GetAllAdsLoading());
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: EndPoint.baseUrl,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final response = await dio.get("/adv/getAll");

      if (response.statusCode == 201) {
        final  advsModel =AdvertismentsModel.fromJson(response.data);
        advs=advsModel.advs??[];

        print(advsModel);
        print(advs);

        emit(GetAllAdsSuccess("Profile loaded successfully", advs));
      } else {
        emit(GetAllAdsFailure("${response.data['message']}", errMessage: " ${response.data['message']}"));
      }
    } catch (e) {
      emit(GetAllAdsFailure("Error occurred while connecting to the API: $e", errMessage: "Error occurred while connecting to the API: $e"));
    }
  }

}





