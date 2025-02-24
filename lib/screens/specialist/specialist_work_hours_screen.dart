import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctor/api/end_points.dart';
import 'package:doctor/screens/specialist/specialist_appointments_screen.dart';
import 'package:doctor/screens/specialist/specialist_home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import '../../cubit/doctor_details_cubit/doctor_profile_cubit.dart';
import '../../cubit/doctor_details_cubit/doctor_profile_state.dart';
import '../../cubit/get_doctor_sessions_types_cubit/doctor_session_types_cubit.dart';
import '../../cubit/update_user_cubit/update_user_cubit.dart';
import '../../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../../models/Doctor_id_model.dart';
import '../cubit/available_slots_cubit.dart';

class SpecialistWorkHoursScreen extends StatefulWidget {
  const SpecialistWorkHoursScreen({super.key});

  @override
  _SpecialistWorkHoursScreenState createState() =>
      _SpecialistWorkHoursScreenState();
}

class _SpecialistWorkHoursScreenState extends State<SpecialistWorkHoursScreen> {
  late DoctorProfileCubit userProfileCubit;
  late DoctorSessionTypesCubit sessionTypesCubit;
  late AddImageToProfileCubit addImageToProfileCubit;
  AvailableSlotsCubit? availableSlotsCubit;

  DateTime _selectedDay = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  List<DateTime> availableSlots = [];

  @override
  void initState() {
    super.initState();
    addImageToProfileCubit = BlocProvider.of<AddImageToProfileCubit>(context);
    userProfileCubit = BlocProvider.of<DoctorProfileCubit>(context);
    sessionTypesCubit = BlocProvider.of<DoctorSessionTypesCubit>(context);
    _loadUserProfile();
  }

  bool isValidObjectId(String id) {
    // Check if the ID is a 24-character hexadecimal string
    final RegExp objectIdRegex = RegExp(r'^[0-9a-fA-F]{24}$');
    return objectIdRegex.hasMatch(id);
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('doctorId') ?? "";
    print(id);

    if (!isValidObjectId(id)) {
      print("Invalid Doctor ID format");
      return;
    }

    userProfileCubit.getUserProfile(context, id);
    sessionTypesCubit.getDoctorSessions(context, id);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (availableSlotsCubit == null) {
      availableSlotsCubit = BlocProvider.of<AvailableSlotsCubit>(context);
      _loadAvailableSlots();
    }
  }

  void _loadAvailableSlots() {
    final prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      String id = value.getString('doctorId') ?? "";
      availableSlotsCubit!.fetchAvailableSlots(id);
    });
  }

  String? _combineDateTime() {
    if (_selectedDay == null) {
      print('Error: _selectedDay is null');
      return null;
    }
    if (_selectedTime == null) {
      print('Error: _selectedTime is null');
      return null;
    }

    DateTime combinedDateTime = DateTime(
      _selectedDay.year,
      _selectedDay.month,
      _selectedDay.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    print('Combined DateTime: ${combinedDateTime.toIso8601String()}');

    return combinedDateTime.toIso8601String();
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
      print('Selected Time: ${_selectedTime!.hour}:${_selectedTime!.minute}');
    }
  }

  String formatSlot(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd – hh:mm a').format(dateTime.toLocal());
  }

  void editSlot(int index) {
    // Handle slot editing logic
    print("Edit slot: ${availableSlots[index]}");
  }

  final ApiService apiService = ApiService();
  final DateCubit dateCubit = DateCubit();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width.w;
    double screenHeight = MediaQuery.of(context).size.height.h;

    return BlocProvider(
        create: (_) => userProfileCubit,
        child: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
          builder: (context, state) {
            if (state is DoctorProfileLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (state is DoctorProfileFailure) {
              return Scaffold(
                  body: Center(
                      child: Text("Error loading profile: ${state.error}")));
            } else if (state is DoctorProfileSuccess) {
              DoctorByIdModel userProfile = state.doctorProfile;
              return Scaffold(
                  backgroundColor: Colors.white,
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SingleChildScrollView(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "uploadImage".tr(),
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  // InkWell(
                                  // onTap: (){
                                  //   setState(() {
                                  //     addImageToProfileCubit.pickImage(context,userProfile.id??"");
                                  //     BlocProvider.of<UserProfileCubit>(context).getUserProfile(context, userProfile.id??"");
                                  //   });
                                  //
                                  // },
                                  // child:
                                  Container(
                                    height: 140.h,
                                    // Adjust size proportionally
                                    width: 140.w,
                                    decoration: BoxDecoration(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(13.0),
                                      child: Container(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              40), // زاوية الإطار
                                          child: userProfile.specialist
                                                          ?.imageUrl ==
                                                      "" ||
                                                  userProfile.specialist
                                                          ?.imageUrl ==
                                                      null
                                              ? Image.asset(
                                                  "assets/images/profile.jpg",
                                                  fit: BoxFit.fill,
                                                )
                                              : Image.network(
                                                  userProfile.specialist
                                                          ?.imageUrl ??
                                                      "", // رابط الصورة
                                                  fit: BoxFit
                                                      .fill, // ملء الصورة
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        addImageToProfileCubit.pickImage(
                                            context,
                                            userProfile.specialist?.id ?? "");
                                        BlocProvider.of<UserProfileCubit>(
                                                context)
                                            .getUserProfile(
                                                context,
                                                userProfile.specialist?.id ??
                                                    "");
                                      });
                                    },
                                    icon: Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: Container(
                                        width: 41.67.w,
                                        height: 41.67.h,
                                        child: CircleAvatar(
                                          radius: 16,
                                          backgroundColor: Color(0xff19649E),
                                          child: Icon(Icons.edit,
                                              size: 24, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${userProfile.specialist?.firstName} " +
                                    "doctor".tr(),
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Color(0xff19649E),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "chooseLang".tr(),
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Color(0xff19649E),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7.h,
                                  ),
                                  Container(
                                    width: 327.w,
                                    height: 48.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(11),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(11),
                                                borderSide: BorderSide.none,
                                              ),
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              hintText: "chooseLang".tr(),
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            style:
                                                TextStyle(color: Colors.black),
                                            textAlign: TextAlign.start,
                                            // textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                // Add a new day container when tapped
                                              });
                                            },
                                            child: Container(
                                              width: 27.w,
                                              height: 28.h,
                                              decoration: BoxDecoration(
                                                color: Color(0xff19649E),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              // Display the dynamically added day containers
                              Container(
                                width: screenWidth * 0.85,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "chooseWorkingHours".tr(),
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        color: Color(0xff19649E),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 7.h,
                                    ),
                                    BlocBuilder<DateCubit, DateState>(
                                      bloc: dateCubit,
                                      builder: (context, state) {
                                        return Column(
                                          children: [
                                            TableCalendar(
                                              focusedDay: _selectedDay,
                                              firstDay: DateTime.now(),
                                              lastDay: DateTime.now().add(
                                                  const Duration(days: 365)),
                                              selectedDayPredicate: (day) =>
                                                  isSameDay(day,
                                                      _selectedDay), // Check if the day is selected
                                              onDaySelected:
                                                  (selectedDay, focusedDay) {
                                                setState(() {
                                                  _selectedDay = selectedDay;
                                                });
                                                print(
                                                    'Selected Day: ${selectedDay.toLocal()}');
                                                _selectTime(context);
                                              },
                                              calendarStyle:
                                                  const CalendarStyle(
                                                selectedDecoration:
                                                    BoxDecoration(
                                                  color: Color(0xFF19649E),
                                                  shape: BoxShape.circle,
                                                ),
                                                todayDecoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                            if (state.isLoading)
                                              CircularProgressIndicator(),
                                            if (state.errorMessage != null)
                                              Text(state.errorMessage!),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 30.h,
                              ),
                              BlocBuilder<AvailableSlotsCubit,
                                  AvailableSlotsState>(
                                builder: (context, state) {
                                  if (state is AvailableSlotsLoading) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (state is AvailableSlotsLoaded) {
                                    print(
                                        "AvailableSlotsLoaded state received.");
                                    print(
                                        "Loaded slots: ${state.availableSlots}");
                                    if (state.availableSlots.isEmpty) {
                                      return Center(
                                          child: Text("No available slots"));
                                    }
                                    return Container(
                                      color: Colors.white,
                                      height: screenHeight * 0.4.h,
                                      child: ListView.builder(
                                        itemCount: state.availableSlots.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            color: Colors.grey.shade300,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child:
                                            ListTile(
                                              leading: IconButton(
                                                icon: Icon(Icons.delete, color: Colors.red),
                                                onPressed: () {
                                                  _deleteAppointment(
                                                      // state.availableSlots[index]
                                                  );
                                                },
                                              ),
                                              title: Center(
                                                child: Text(formatSlot(
                                                    DateTime.parse(state
                                                        .availableSlots[index]))),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  } else if (state is AvailableSlotsError) {
                                    print(
                                        "AvailableSlotsError state received: ${state.message}");
                                    return Center(
                                        child: Text("Error: ${state.message}"));
                                  } else {
                                    print("No data available state.");
                                    return Center(
                                        child: Text("No data available"));
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  bottomNavigationBar: Padding(
                    padding: EdgeInsets.only(
                        bottom: 20.0.h, right: 20.w, left: 20.w),
                    // Adds space below the button
                    child: Container(
                      width: 333.w, // Keeps the width consistent
                      height: 48.h, // Reduced height to make the button smaller
                      child: ElevatedButton(
                        onPressed: () {
                          _bookAppointment(); // Call the method to book the appointment

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider<DoctorProfileCubit>(
                                      create: (_) => DoctorProfileCubit()),
                                  BlocProvider<DoctorSessionTypesCubit>(
                                      create: (_) => DoctorSessionTypesCubit()),
                                  BlocProvider<UpdateUserCubit>(
                                      create: (_) => UpdateUserCubit()),
                                ],
                                child: SpecialistHomeScreen(),
                              ),
                            ),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(700, 45),
                          // Adjusted minimum size to match the new height
                          backgroundColor: const Color(0xFF19649E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "confirm".tr(),
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ));
            }
            return Container(); // Default return in case no state matches
          },
        ));
  }

  Future<void> _bookAppointment() async {
    final String? combinedDateTime = _combineDateTime();
    print('Final Combined DateTime: $combinedDateTime');

    if (combinedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both date and time')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('doctorId') ?? "";

    try {
      // Show loading indicator
      dateCubit.loadInProgress();

      print('Sending to API: ${{
        'date': combinedDateTime,
        'doctorId': id,
      }}');

      // Call the API to book the appointment
      final response = await apiService.postData(id, {
        'date': combinedDateTime,
      });

      print('API Response Code: ${response.statusCode}');
      print('API Response Body: ${response.data}');

      // Handle the response
      if (response.statusCode == 200) {
        // Appointment booked successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Appointment booked successfully!')),
        );
        // Optionally navigate to another screen or reset the form
      } else {
        // Handle error response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to book appointment: ${response.data}')),
        );
      }
    } catch (e) {
      // Handle exceptions
      print('API Error: $e'); // Print errors to the terminal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      // Hide loading indicator
      dateCubit.loadComplete();
    }
  }

  Future<void> _deleteAppointment() async {
    final String? combinedDateTime = _combineDateTime();

    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('doctorId') ?? "";

    try {
      // Show loading indicator
      dateCubit.loadInProgress();

      print('Sending delete request to API: ${{
        'date': combinedDateTime,
        'doctorId': id,
      }}');

      // Call the API to delete the appointment
      final response = await apiService.deleteData(id, {
        'date': combinedDateTime,
      });

      print('API Response Code: ${response.statusCode}');
      print('API Response Body: ${response.data}');

      // Handle the response
      if (response.statusCode == 200) {
        // Appointment deleted successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Slot deleted successfully!')),
        );
        // Optionally navigate to another screen or reset the form
      } else {
        // Handle error response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete slot: ${response.data}')),
        );
      }
    } catch (e) {
      // Handle exceptions
      print('API Error: $e'); // Print errors to the terminal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      // Hide loading indicator
      dateCubit.loadComplete();
    }
  }

}


class ApiService {
  final Dio _dio = Dio();

  Future<Response> postData(String id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        'https://scopey.onrender.com/api/specialist/addSlots/$id', // Use correct API endpoint
        data: jsonEncode(data), // Ensure JSON encoding
      );
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> deleteData(String id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.delete( // Use PUT for deleting a slot that is already created.
        'https://scopey.onrender.com/api/specialist/deleteSlots/$id',
        data: jsonEncode(data),
      );
      return response;
    } catch (e) {
      throw e;
    }
  }

}

class DateState {
  final DateTime selectedDate;
  final String? appointmentTime;
  final bool isLoading;
  final String? errorMessage;

  DateState({
    required this.selectedDate,
    this.appointmentTime,
    this.isLoading = false,
    this.errorMessage,
  });

  DateState copyWith({
    DateTime? selectedDate,
    String? appointmentTime,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DateState(
      selectedDate: selectedDate ?? this.selectedDate,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class DateCubit extends Cubit<DateState> {
  DateCubit() : super(DateState(selectedDate: DateTime.now()));

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void setAppointmentTime(String time) {
    emit(state.copyWith(appointmentTime: time));
  }

  void loadInProgress() {
    emit(state.copyWith(isLoading: true));
  }

  void loadComplete() {
    emit(state.copyWith(isLoading: false));
  }

  void setError(String message) {
    emit(state.copyWith(errorMessage: message, isLoading: false));
  }
}

