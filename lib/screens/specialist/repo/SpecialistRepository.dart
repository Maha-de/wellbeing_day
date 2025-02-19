import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor/models/notification_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';

import '../../../api/end_points.dart';
import '../../../errors/error_model.dart';
import '../../../errors/exceptions.dart';
import '../../../models/Specialist.dart';

class SpecialistRepository {
  final Dio dio;

  SpecialistRepository({required this.dio});

  Future<Response> signUpSpecialist(Specialist doctor) async {
    try {
      List<Future<MultipartFile>> fileUploadFutures = [];

      if (doctor.idOrPassport != null) {
        fileUploadFutures.add(MultipartFile.fromFile(
          doctor.idOrPassport!.path!,
          contentType: MediaType('application', 'pdf'),
        ));
      }

      if (doctor.resume != null) {
        fileUploadFutures.add(MultipartFile.fromFile(
          doctor.resume!.path!,
          contentType: MediaType('application', 'pdf'),
        ));
      }

      if (doctor.certificates != null) {
        fileUploadFutures.add(MultipartFile.fromFile(
          doctor.certificates!.path!,
          contentType: MediaType('application', 'pdf'),
        ));
      }

      if (doctor.ministryLicense != null) {
        fileUploadFutures.add(MultipartFile.fromFile(
          doctor.ministryLicense!.path!,
          contentType: MediaType('application', 'pdf'),
        ));
      }

      if (doctor.associationMembership != null) {
        fileUploadFutures.add(MultipartFile.fromFile(
          doctor.associationMembership!.path!,
          contentType: MediaType('application', 'pdf'),
        ));
      }

      List<MultipartFile> uploadedFiles = await Future.wait(fileUploadFutures);

      FormData formData = FormData.fromMap({
        'firstName': doctor.firstName,
        'lastName': doctor.lastName,
        'email': doctor.email,
        'phone': doctor.phone,
        'password': doctor.password,
        'nationality': doctor.nationality,
        'work': doctor.work,
        'yearsExperience': doctor.yearOfExperience.toString(),
        'workAddress': doctor.workAddress,
        'homeAddress': doctor.homeAddress,
        'bio': doctor.bio,
        'sessionPrice': doctor.sessionPrice,
        'sessionDuration': doctor.sessionDuration,
        'specialties': doctor.specialties,
        if (doctor.idOrPassport != null) 'idOrPassport': uploadedFiles[0],
        if (doctor.resume != null) 'resume': uploadedFiles[1],
        if (doctor.certificates != null) 'certificates': uploadedFiles[2],
        if (doctor.ministryLicense != null) 'ministryLicense': uploadedFiles[3],
        if (doctor.associationMembership != null)
          'associationMembership': uploadedFiles[4],
      });
      final response = await dio.post(
        dio.options.baseUrl + EndPoint.signUpSpecialist,
        data: formData,
        options: Options(
          headers: {"Content-Type": "multipart/form-data"},
        ),
      );

      return response;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
    throw Exception('Unexpected error occurred (network connection)');
  }

  Future<List<NotificationModel>> getDoctorSessions(String id) async {
    try {
      Response response = await dio.get(
        dio.options.baseUrl + EndPoint.getSpecialistSessions(id),
      );

      final List<dynamic> instantSessions =
          response.data['instantSessions'] ?? [];
      final List<dynamic> freeConsultations =
          response.data['freeConsultations'] ?? [];
      final List<dynamic> combinedSessions = [
        ...instantSessions,
        ...freeConsultations
      ];

      final todaySessions = combinedSessions.where((session) {
        final String? sessionDate = session['sessionDate'] as String?;
        return sessionDate != null;
      }).map((session) {
        return NotificationModel(
          id: session["_id"] ?? '',
          notificationType: session['sessionType'] as String? ?? '',
          date: DateFormat('yyyy/MM/dd - HH:mm')
              .format(DateTime.parse(session['sessionDate'])),
        );
      }).toList();

      return todaySessions;
    } on DioException catch (e) {
      try {
        handleDioExceptions(e);
      } on ServerException catch (serverException) {
        throw Exception(serverException.errModel.message);
      }
    }

    // Fallback in case something unexpected happens
    throw Exception('Unexpected error occurred (network connection)');
  }

  Future<List<NotificationModel>> getBenficSessions(String id) async {
    try {
      Response response = await dio.get(
        dio.options.baseUrl + EndPoint.getBenificSessions(id),
      );

      final List<dynamic> scheduledSessions =
          response.data['scheduledSessions'] ?? [];

      final todaySessions = scheduledSessions.where((session) {
        final String? sessionDate = session['sessionDate'] as String?;
        return sessionDate != null;
      }).map((session) {
        return NotificationModel(
          id: session["_id"] ?? '',
          notificationType: session['sessionType'] as String? ?? '',
          date: DateFormat('yyyy/MM/dd - HH:mm')
              .format(DateTime.parse(session['sessionDate'])),
        );
      }).toList();

      return todaySessions;
    } on DioException catch (e) {
      print("+++++++++++++++++++++++++++");
      print("here");
      try {
        handleDioExceptions(e);
      } on ServerException catch (serverException) {
        throw Exception(serverException.errModel.message);
      }
    }

    // Fallback in case something unexpected happens
    throw Exception('Unexpected error occurred (network connection)');
  }

  void handleDioExceptions(DioException e) {
    if (e.response != null) {
      final responseData = e.response!.data;
      final statusCode = e.response!.statusCode;

      if (statusCode != null) {
        throw ServerException(
          errModel:
              ResponseModel.fromJson(responseData as Map<String, dynamic>),
        );
      }
    }

    // Handle cases with no response
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        throw ServerException(
          errModel: ResponseModel(
            code: 'TIMEOUT',
            message:
                'Connection timed out. Please try again later.  افحص الاتصال بالانترنت \n مشكلة في الشبكة',
          ),
        );
      case DioExceptionType.cancel:
        throw ServerException(
          errModel: ResponseModel(
            code: 'CANCELLED',
            message: 'Request was cancelled. تم الغاء الطلب',
          ),
        );
      case DioExceptionType.badResponse:
        throw ServerException(
          errModel: ResponseModel(
            code: 'BAD_RESPONSE',
            message:
                'An error occurred while processing the request. حدثت مشكلة',
          ),
        );
      case DioExceptionType.unknown:
        throw ServerException(
          errModel: ResponseModel(
            code: 'UNKNOWN',
            message:
                'An unknown error occurred. Please try again. حطأ غير معروف',
          ),
        );
      case DioExceptionType.badCertificate:
        throw ServerException(
          errModel: ResponseModel(
            code: 'BAD_CERTIFICATE',
            message: 'Invalid server certificate.',
          ),
        );
    }
  }
}
