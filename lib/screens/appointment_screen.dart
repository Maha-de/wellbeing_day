import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
// import 'package:intl/intl.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime _selectedDay = DateTime.now(); // Initialize with current date


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(35.0), // Set the height here
        child: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Color(0xff19649E),
          ),
        ),
      ),
      body: Column(
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
              child: const Center(
                  child: Text(
                "حدد التاريخ والوقت",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              TableCalendar(
                focusedDay: _selectedDay,
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 365)),
                selectedDayPredicate: (day) => isSameDay(
                    day, _selectedDay), // Check if the day is selected
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    // _selectedTime = null; // Reset selected time when date changes
                  });
                  print('Selected Day: ${selectedDay.toLocal()}');
                  // _selectTime(context); // Show time picker after selecting a date
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
              ),

              const SizedBox(height: 50),

              const Center(
                  child: Text("أقرب إتاحة                 4 يونيو - 7 مساءا",
                      style: TextStyle(fontSize: 20, color: Color(0xff19649E), fontWeight: FontWeight.bold,))),



              const SizedBox(height: 50),

              Center(
                child: ElevatedButton(
                  onPressed: () {

                    // if (_selectedTime != null) {
                    //   // Here you can implement the logic to save the appointment
                    //   // For example, you can send the selected date and time to the doctor
                    //   final appointmentDetails =
                    //       'Appointment scheduled on ${_selectedDay.toLocal()} at $_selectedTime';
                    //   // Show a confirmation dialog or send the details to the doctor
                    //   showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return AlertDialog(
                    //         title: const Text('Appointment Confirmed'),
                    //         content: Text(appointmentDetails),
                    //         actions: [
                    //           TextButton(
                    //             onPressed: () {
                    //               Navigator.of(context)
                    //                   .pop(); // Close the dialog
                    //             },
                    //             child: const Text('OK'),
                    //           ),
                    //         ],
                    //       );
                    //     },
                    //   );
                    // } else {
                    //   // Show a message if no time is selected
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //         content:
                    //             Text('Please select a time before approving.')),
                    //   );
                    // }

                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(350, 50),
                      backgroundColor: const Color(0xFF19649E),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    "تأكيد الموعد",
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
    );
  }
}
