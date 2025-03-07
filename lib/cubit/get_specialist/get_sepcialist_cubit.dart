import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/end_points.dart';
import '../../models/specialist_model.dart';
import 'get_specialist_state.dart';

class GetSpecialistCubit extends Cubit<GetSpecialistState> {
  GetSpecialistCubit() : super(GetSpecialistInitial());

  List<Specialists> specialists = []; // القائمة الأصلية للأطباء
  List<Specialists> filteredSpecialists = [];
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
  TextEditingController session_price_Controller = TextEditingController();// قائمة البحث

  TextEditingController searchController = TextEditingController();

  Future<void> fetchSpecialists() async {
    emit(SpecialistLoading());
    try {
      final dio = Dio(BaseOptions(
        baseUrl: EndPoint.baseUrl,
        validateStatus: (status) => status != null && status < 500,
      ));

      final response = await dio.get("/specialist/getAll");

      if (response.statusCode == 200) {
        final specialistModel = SpecialistsResponse.fromJson(response.data);
        specialists = specialistModel.items ?? [];
        print(specialists);
        filteredSpecialists = List.from(specialists); // أول مرة تكون النتائج نفس القائمة الأصلية
        emit(SpecialistSuccess("Profile loaded successfully", specialists));
      } else {
        emit(SpecialistFailure("Error Fetching Data: ${response.data['message']}",
            errMessage: "Error Fetching Data: ${response.data['message']}"));
      }
    } catch (e) {
      emit(SpecialistFailure("Error occurred while connecting to the API: $e",
          errMessage: "Error occurred while connecting to the API: $e"));
    }
  }

  void searchSpecialists(String query) {
    if (query.isEmpty) {
      filteredSpecialists = List.from(specialists);
    } else {
      query = query.toLowerCase();
      filteredSpecialists = specialists.where((specialist) {
        // التأكد من أن القيم غير null قبل استخدامها
        final firstName = specialist.firstName?.toLowerCase() ?? "";
        final lastName = specialist.lastName?.toLowerCase() ?? "";
        final specialties = specialist.specialties;

        // البحث بالاسم
        bool matchesName = firstName.contains(query) || lastName.contains(query);

        // البحث بالتخصصات
        bool matchesSpecialty = specialties != null &&
            ((specialties.psychologicalDisorders?.any((s) => s.toLowerCase().contains(query)) ?? false) ||
                (specialties.mentalHealth?.any((s) => s.toLowerCase().contains(query)) ?? false) ||
                (specialties.physicalHealth?.any((s) => s.toLowerCase().contains(query)) ?? false) ||
                (specialties.skillDevelopment?.any((s) => s.toLowerCase().contains(query)) ?? false));

        return matchesName || matchesSpecialty;
      }).toList();
    }

    emit(SpecialistSuccess("Search completed", filteredSpecialists));
  }
}
