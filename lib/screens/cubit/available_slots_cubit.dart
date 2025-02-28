import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AvailableSlotsState extends Equatable {
  @override
  List<Object> get props => [];
}

class AvailableSlotsInitial extends AvailableSlotsState {}

class AvailableSlotsLoading extends AvailableSlotsState {}

class AvailableSlotsLoaded extends AvailableSlotsState {
  final List<String> availableSlots;
  AvailableSlotsLoaded(this.availableSlots);

  @override
  List<Object> get props => [availableSlots];
}

class AvailableSlotsError extends AvailableSlotsState {
  final String message;
  AvailableSlotsError(this.message);

  @override
  List<Object> get props => [message];
}

class AvailableSlotsCubit extends Cubit<AvailableSlotsState> {
  AvailableSlotsCubit() : super(AvailableSlotsInitial()) {
    debugPrint("AvailableSlotsCubit initialized!");
  }


  Future<void> fetchAvailableSlots(String id) async {
    emit(AvailableSlotsLoading());

    print("Fetching slots for ID: $id");

    try {
      final dio = Dio();
      final response = await dio.get(
          'https://scopey.onrender.com/api/specialist/getById/$id');

      print("Response Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Success status code received: ${response
            .statusCode}"); // Add this line
        final data = response.data;
        final specialistData = data['specialist'];

        if (specialistData != null &&
            specialistData['availableSlots'] != null) {
          final slots = List<String>.from(specialistData['availableSlots']);
          emit(AvailableSlotsLoaded(slots));
          print("Available Slots: $slots");
        } else {
          emit(AvailableSlotsError("Available slots not found in response."));
        }
      } else {
        emit(AvailableSlotsError(
            "Unexpected response status: ${response.statusCode}"));
      }
    } catch (e) {
      emit(AvailableSlotsError("Error fetching data: $e"));
    }
  }
}
abstract class AvailableLanguageState extends Equatable {
  @override
  List<Object> get props => [];
}

class AvailableLanguageInitial extends AvailableLanguageState {}

class AvailableLanguageLoading extends AvailableLanguageState {}

class AvailableLanguageLoaded extends AvailableLanguageState {
  final List<String> availableLanguage;
  AvailableLanguageLoaded(this.availableLanguage);

  @override
  List<Object> get props => [availableLanguage];
}

class AvailableLanguageError extends AvailableLanguageState {
  final String message;
  AvailableLanguageError(this.message);

  @override
  List<Object> get props => [message];
}

class AvailableLanguageCubit extends Cubit<AvailableLanguageState> {
  AvailableLanguageCubit() : super(AvailableLanguageInitial()) {
    debugPrint("AvailableLanguageCubit initialized!");
  }

  Future<void> fetchLanguage(String id) async {
    emit(AvailableLanguageLoading());

    print("Fetching language for ID: $id");

    try {
      final dio = Dio();
      final response = await dio.get(
          'https://scopey.onrender.com/api/specialist/getById/$id');

      print("Response Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Success status code received: ${response
            .statusCode}"); // Add this line
        final data = response.data;
        final specialistData = data['specialist'];

        if (specialistData != null && specialistData['language'] != null) {
          final slots = List<String>.from(specialistData['language']);
          emit(AvailableLanguageLoaded(slots));
          print("Available language: $slots");
        } else {
          emit(
              AvailableLanguageError("Available slots not found in response."));
        }
      } else {
        emit(AvailableLanguageError(
            "Unexpected response status: ${response.statusCode}"));
      }
    } catch (e) {
      emit(AvailableLanguageError("Error fetching data: $e"));
    }
  }
}




