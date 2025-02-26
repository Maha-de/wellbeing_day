import 'package:doctor/screens/payment_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

// class AppointmentScreen extends StatefulWidget {
//   final List<String> availableSlots;
//   const AppointmentScreen({super.key, required this.availableSlots});

//   @override
//   State<AppointmentScreen> createState() => _AppointmentScreenState();
// }

// class _AppointmentScreenState extends State<AppointmentScreen> {
//   DateTime _selectedDay = DateTime.now(); // Initialize with current date
//   // TimeOfDay _selectedTime = TimeOfDay.now();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(35.0.h), // Set the height here
//         child: AppBar(
//           backgroundColor: Colors.white,
//           iconTheme: const IconThemeData(
//             color: Color(0xff19649E),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Align(
//             alignment: Alignment.topCenter,
//             child: Container(
//               height: 50.h,
//               width: 250.w,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.rectangle,
//                 color: Color(0xFF19649E),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   bottomRight: Radius.circular(30),
//                 ),
//               ),
//               child: Center(
//                   child: Text(
//                 "calenderDate".tr(),
//                 style: TextStyle(fontSize: 20.sp, color: Colors.white),
//               )),
//             ),
//           ),
//           SizedBox(
//             height: 20.h,
//           ),
//           Column(
//             children: [
//               TableCalendar(
//                 focusedDay: _selectedDay,
//                 firstDay: DateTime.now(),
//                 lastDay: DateTime.now().add(const Duration(days: 365)),
//                 selectedDayPredicate: (day) => isSameDay(
//                     day, _selectedDay), // Check if the day is selected
//                 onDaySelected: (selectedDay, focusedDay) {
//                   setState(() {
//                     _selectedDay = selectedDay;
//                     // _selectedTime = null; // Reset selected time when date changes
//                   });
//                   print('Selected Day: ${selectedDay.toLocal()}');
//                   // _selectTime(context); // Show time picker after selecting a date
//                 },
//                 calendarStyle: const CalendarStyle(
//                   selectedDecoration: BoxDecoration(
//                     color: Color(0xFF19649E),
//                     shape: BoxShape.circle,
//                   ),
//                   todayDecoration: BoxDecoration(
//                     color: Colors.blue,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 50.h),
//               Center(
//                   child: Text(
//                       "availability".tr() +
//                           "                 " +
//                           "dateExample".tr(),
//                       style: TextStyle(
//                         fontSize: 20.h,
//                         color: Color(0xff19649E),
//                         fontWeight: FontWeight.bold,
//                       ))),
//               SizedBox(height: 50.h),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const PaymentScreen()));

// //                     // if (_selectedTime != null) {
// //                     //   // Here you can implement the logic to save the appointment
// //                     //   // For example, you can send the selected date and time to the doctor
// //                     //   final appointmentDetails =
// //                     //       'Appointment scheduled on ${_selectedDay.toLocal()} at $_selectedTime';
// //                     //   // Show a confirmation dialog or send the details to the doctor
// //                     //   showDialog(
// //                     //     context: context,
// //                     //     builder: (context) {
// //                     //       return AlertDialog(
// //                     //         title: const Text('Appointment Confirmed'),
// //                     //         content: Text(appointmentDetails),
// //                     //         actions: [
// //                     //           TextButton(
// //                     //             onPressed: () {
// //                     //               Navigator.of(context)
// //                     //                   .pop(); // Close the dialog
// //                     //             },
// //                     //             child: const Text('OK'),
// //                     //           ),
// //                     //         ],
// //                     //       );
// //                     //     },
// //                     //   );
// //                     // } else {
// //                     //   // Show a message if no time is selected
// //                     //   ScaffoldMessenger.of(context).showSnackBar(
// //                     //     const SnackBar(
// //                     //         content:
// //                     //             Text('Please select a time before approving.')),
// //                     //   );
// //                     // }
//                   },
//                   style: ElevatedButton.styleFrom(
//                       minimumSize: const Size(350, 50),
//                       backgroundColor: const Color(0xFF19649E),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10))),
//                   child: Text(
//                     "confirmDate".tr(),
//                     style: TextStyle(
//                         fontSize: 20.h,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentScreen extends StatefulWidget {
  final List<String> availableSlots;
  const AppointmentScreen({super.key, required this.availableSlots});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  late DateTime _selectedDay;
  late String formattedDate;
  @override
  void initState() {
    super.initState();

    _selectFirstAvailableSlot();
  }

  void _selectFirstAvailableSlot() {
    // Convert availableSlots to DateTime objects for easier comparison
    List<DateTime> availableDates = widget.availableSlots
        .map((dateString) => _parseDateString(dateString))
        .where((date) => date != null)
        .map((date) => date!)
        .toList();
    availableDates.sort((a, b) => a.compareTo(b));
    if (availableDates.isNotEmpty) {
      print('availableDates Day: ${availableDates}');
      // Set the first valid available date as the selected date
      setState(() {
        _selectedDay = availableDates.first;
        formattedDate = _formatDate(_selectedDay);
      });
    }
  }

  // Parse the date string into a DateTime object
  DateTime? _parseDateString(String dateString) {
    try {
      // Try to parse the date string into DateTime
      return DateTime.parse(dateString);
    } catch (e) {
      // If parsing fails, return null
      return null;
    }
  }

  String _formatDate(DateTime date) {
    // Format the date into the desired format (e.g., "25 Feb - 03:00 PM")
    return DateFormat('dd MMM - hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    // Convert availableSlots to DateTime objects for easier comparison
    List<DateTime> availableDates = widget.availableSlots
        .map((dateString) => _parseDateString(dateString))
        .where((date) => date != null)
        .map((date) => date!)
        .toList();
    availableDates.sort((a, b) => a.compareTo(b));
    DateTime firstDay = availableDates.first;
    DateTime lastDay = availableDates.last.add(const Duration(days: 1));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35.0), // Set the height here
        child: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Color(0xff19649E),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 50,
                width: 250,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color(0xFF19649E),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Center(
                    child: Text(
                  "calenderDate".tr(),
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                TableCalendar(
                  focusedDay: _selectedDay,
                  firstDay: firstDay,
                  lastDay: lastDay,
                  selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      formattedDate = "";
                      _selectedDay = selectedDay;
                      formattedDate = _formatDate(selectedDay.toLocal());
                    });

                    print('formattedDate Day: ${formattedDate}');
                    print('Selected Day: ${selectedDay.toLocal()}');
                  },
                  calendarStyle: const CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: Color(0xFF19649E),
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                  enabledDayPredicate: (day) {
                    return availableDates
                        .any((availableDate) => isSameDay(availableDate, day));
                  },
                ),
                SizedBox(height: 50),
                Center(
                    child: Text("availability".tr() + "     " + formattedDate,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff19649E),
                          fontWeight: FontWeight.bold,
                        ))),
                SizedBox(height: 50),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(350, 50),
                        backgroundColor: const Color(0xFF19649E),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      "confirmDate".tr(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// class AppointmentScreen extends StatefulWidget {
//   final List<String> availableSlots;
//   const AppointmentScreen({super.key, required this.availableSlots});

//   @override
//   State<AppointmentScreen> createState() => _AppointmentScreenState();
// }

// class _AppointmentScreenState extends State<AppointmentScreen> {
//   late DateTime _selectedDay;

//   @override
//   void initState() {
//     super.initState();

//     _selectFirstAvailableSlot();
//   }

//   void _selectFirstAvailableSlot() {
//     // Convert availableSlots to DateTime objects for easier comparison
//     List<DateTime> availableDates = widget.availableSlots
//         .map((dateString) => _parseDateString(dateString))
//         .where((date) => date != null)
//         .map((date) => date!)
//         .toList();
//     availableDates.sort((a, b) => a.compareTo(b));
//     if (availableDates.isNotEmpty) {
//       // Set the first valid available date as the selected date
//       setState(() {
//         _selectedDay = availableDates.first;
//       });
//     }
//   }

//   // Parse the date string into a DateTime object
//   DateTime? _parseDateString(String dateString) {
//     try {
//       // Try to parse the date string into DateTime
//       return DateTime.parse(dateString);
//     } catch (e) {
//       // If parsing fails, return null
//       return null;
//     }
//   }

//   String _formatDate(DateTime date) {
//     // Format the date into the desired format (e.g., "25 Feb - 03:00 PM")
//     return DateFormat('dd MMM - hh:mm a').format(date);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Convert availableSlots to DateTime objects for easier comparison
//     List<DateTime> availableDates = widget.availableSlots
//         .map((dateString) => _parseDateString(dateString))
//         .where((date) => date != null)
//         .map((date) => date!)
//         .toList();
//     availableDates.sort((a, b) => a.compareTo(b));
//     DateTime firstDay = availableDates.first;
//     DateTime lastDay = availableDates.last.add(const Duration(days: 1));

//     // Get the first formatted date from the availableSlots list
//     String formattedDate = _formatDate(availableDates.first);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(35.0), // Set the height here
//         child: AppBar(
//           backgroundColor: Colors.white,
//           iconTheme: const IconThemeData(
//             color: Color(0xff19649E),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.topCenter,
//               child: Container(
//                 height: 50,
//                 width: 250,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   color: Color(0xFF19649E),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     bottomRight: Radius.circular(30),
//                   ),
//                 ),
//                 child: Center(
//                     child: Text(
//                   "calenderDate".tr(),
//                   style: TextStyle(fontSize: 20, color: Colors.white),
//                 )),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Column(
//               children: [
//                 TableCalendar(
//                   focusedDay: _selectedDay,
//                   firstDay: firstDay,
//                   lastDay: lastDay,
//                   selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
//                   onDaySelected: (selectedDay, focusedDay) {
//                     setState(() {
//                       _selectedDay = selectedDay;
//                     });
//                     print('Selected Day: ${selectedDay.toLocal()}');
//                   },
//                   calendarStyle: const CalendarStyle(
//                     selectedDecoration: BoxDecoration(
//                       color: Color(0xFF19649E),
//                       shape: BoxShape.circle,
//                     ),
//                     todayDecoration: BoxDecoration(
//                       color: Colors.blue,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                   enabledDayPredicate: (day) {
//                     return availableDates
//                         .any((availableDate) => isSameDay(availableDate, day));
//                   },
//                 ),
//                 SizedBox(height: 50),
//                 Center(
//                     child: Text("availability".tr() + " " + formattedDate,
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Color(0xff19649E),
//                           fontWeight: FontWeight.bold,
//                         ))),
//                 SizedBox(height: 50),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const PaymentScreen()));
//                     },
//                     style: ElevatedButton.styleFrom(
//                         minimumSize: const Size(350, 50),
//                         backgroundColor: const Color(0xFF19649E),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10))),
//                     child: Text(
//                       "confirmDate".tr(),
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
