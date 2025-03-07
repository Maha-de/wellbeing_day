import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/end_points.dart';
import '../../api/user_repository.dart';
import '../../models/doctor_by_category_model.dart';
import '../../models/get_sub_sub_category_model.dart';
import '../../models/sub_categories_model.dart';
import 'get_sub_sub_category_state.dart';





class SubSubCategoriesCubit extends Cubit<SubSubCategoriesState> {

  SubSubCategoriesCubit() : super(SubSubCategoriesInitial());
  List<String?>categories=[];


  Future<void> fetchSubCategories(BuildContext context,String category) async {
    String lang = EasyLocalization.of(context)?.currentLocale?.languageCode == 'ar' ? 'ar' : 'en';

    emit(SubSubCategoriesLoading());
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: EndPoint.baseUrl,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final response = await dio.get("/categories/subcategory/$category/$lang");

      if (response.statusCode == 200) {
        print("/categories/subcategory/$category/$lang");
        final sub=List<String>.from(response.data);
        categories=sub;
        print(categories);

        emit(SubSubCategoriesSuccess("Profile loaded successfully", categories));
      } else {
        emit(SubSubCategoriesFailure("${response.data['message']}", errMessage: " ${response.data['message']}"));
      }
    } catch (e) {
      emit(SubSubCategoriesFailure("Error occurred while connecting to the API: $e", errMessage: "Error occurred while connecting to the API: $e"));
    }
  }

}





