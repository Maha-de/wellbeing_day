import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/end_points.dart';
import '../../api/user_repository.dart';
import '../../models/doctor_by_category_model.dart';
import '../../models/sub_categories_model.dart';
import 'get_sub_categories_state.dart';




class SubCategoriesCubit extends Cubit<SubCategoriesState> {

  SubCategoriesCubit() : super(SubCategoriesInitial());
List<String?>categories=[];
  List<GetSubCategoriesModel> model=[];


  Future<void> fetchSubCategories(BuildContext context,String category) async {
    String lang = EasyLocalization.of(context)?.currentLocale?.languageCode == 'ar' ? 'ar' : 'en';

    emit(SubCategoriesLoading());
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: EndPoint.baseUrl,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final response = await dio.get("/categories/$category/$lang");

      if (response.statusCode == 200) {
        final List<GetSubCategoriesModel> subCategoriesModel =
        (response.data as List).map((e) => GetSubCategoriesModel.fromJson(e)).toList();
        categories=subCategoriesModel?.map((category) => category.name).toList() ?? [];
        model=subCategoriesModel;
        print(subCategoriesModel);

        emit(SubCategoriesSuccess("Profile loaded successfully", subCategoriesModel));
      } else {
        emit(SubCategoriesFailure("${response.data['message']}", errMessage: " ${response.data['message']}"));
      }
    } catch (e) {
      emit(SubCategoriesFailure("Error occurred while connecting to the API: $e", errMessage: "Error occurred while connecting to the API: $e"));
    }
  }

}





