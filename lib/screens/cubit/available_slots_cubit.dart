import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

// 🔹 حالات الـ Cubit
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

// 🔹 الكلاس الرئيسي لإدارة Slots
class AvailableSlotsCubit extends Cubit<AvailableSlotsState> {
  AvailableSlotsCubit() : super(AvailableSlotsInitial()){
    debugPrint("AvailableSlotsCubit initialized!");
  }

  // Future<void> fetchAvailableSlots(String id) async {
  //   emit(AvailableSlotsLoading());
  //
  //   print("Fetching slots for ID: $id"); // ✅ تأكد من أن الدالة يتم استدعاؤها
  //
  //   try {
  //     final dio = Dio();
  //     final response = await dio.get('https://scopey.onrender.com/api/specialist/getById/$id');
  //
  //     print("Response Status Code: ${response.statusCode}"); // ✅ تحقق من الاستجابة
  //     print("Response Data: ${response.data}"); // ✅ تأكد من أن البيانات صحيحة
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //
  //
  // //       // final data = response.data['specialist']; // Access the 'specialist' object directly
  // //       // final slots = List<String>.from(data['availableSlots']?? []);
  // //       // // final data = response.data;
  // //       // // final slots = List<String>.from(data['specialist']['availableSlots'] ?? []);
  // //
  // //       emit(AvailableSlotsLoaded(slots));
  // //       print("Available Slots: $slots"); // ✅ تأكد من أن القائمة ليست فارغة
  // //
  // //     } else {
  // //       emit(AvailableSlotsError("Unexpected response status: ${response.statusCode}"));
  // //     }
  // //   } catch (e) {
  // //     emit(AvailableSlotsError("Error fetching data: $e"));
  // //   }
  // // }

  Future<void> fetchAvailableSlots(String id) async {
    emit(AvailableSlotsLoading());

    print("Fetching slots for ID: $id");

    try {
      final dio = Dio();
      final response = await dio.get('https://scopey.onrender.com/api/specialist/getById/$id');

      print("Response Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Success status code received: ${response.statusCode}"); // Add this line
        final data = response.data;
        final specialistData = data['specialist'];

        if (specialistData != null && specialistData['availableSlots'] != null) {
          final slots = List<String>.from(specialistData['availableSlots']);
          emit(AvailableSlotsLoaded(slots));
          print("Available Slots: $slots");
        } else {
          emit(AvailableSlotsError("Available slots not found in response."));
        }
      } else {
        emit(AvailableSlotsError("Unexpected response status: ${response.statusCode}"));
      }
    } catch (e) {
      emit(AvailableSlotsError("Error fetching data: $e"));
    }
  }


}
