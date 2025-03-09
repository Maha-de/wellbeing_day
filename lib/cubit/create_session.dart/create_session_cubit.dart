import 'package:bloc/bloc.dart';
import 'package:doctor/api/end_points.dart';
import 'package:doctor/cubit/create_session.dart/create_session_state.dart';
import 'package:doctor/models/catgoryInfo.dart';
import 'package:doctor/models/sessionType.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class CreateSessionCubit extends Cubit<CreateSessionState> {
  CreateSessionCubit() : super(CreateSessionInitial());

  Future<Map<String, String>> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";
    String token = prefs.getString('token') ?? "";

    return {"id": id, "token": token};
  }

  Future<void> createSession(
    DateTime confirmedUserDateTimel,
    CategoryInfo categoryInfo,
    String? specId,
    SessionType sessionType,
  ) async {
    emit(CreateSessionLoading());

    try {
      final userProfile = await _loadUserProfile();
      final String? userId = userProfile["id"];
      final String? token = userProfile["token"];
      print(
          "info are : token =${token}  ${confirmedUserDateTimel}, ${categoryInfo.pubCategory} specId =  ${specId},${sessionType.runtimeType},");

      if (userId == null || userId.isEmpty || token == null || token.isEmpty) {
        emit(CreateSessionError("User ID or token is missing."));
        return;
      }
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final Map<String, dynamic> body = {
        "specialist": specId ?? "",
        "beneficiary": userId,
        "sessionDate": confirmedUserDateTimel.toString(),
        "sessionType": sessionType.sessionType,
        "category": categoryInfo.pubCategory,
        "subcategory": categoryInfo.subCategory,
        "description": sessionType is InstantSession
            ? sessionType.description
            : sessionType is FreeSession
                ? sessionType.description
                : "No Description",
        "paymentStatus": sessionType.isPaid ? "paid" : "Unpaid",
      };

      final url = Uri.parse(EndPoint.baseUrl + EndPoint.createSession);

      final response = await Dio().post(
        url.toString(),
        data: json.encode(body),
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(CreateSessionSuccess());
      } else {
        var responseData = json.decode(response.data);

        emit(CreateSessionError(responseData['error']));
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 400 || e.response?.statusCode == 401)
          emit(CreateSessionError(e.response?.data["error"]));
      } else
        emit(CreateSessionError("Request failed: $e"));
    }
  }
}
