import 'package:doctor/screens/payment_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentScreen extends StatefulWidget {
  final List<String> availableSlots;
  const AppointmentScreen({super.key, required this.availableSlots});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  late DateTime _selectedDay;
  late DateTime? _selectedTimeSlot;
  late List<DateTime> availableSlotsDateTime;
  late List<DateTime> availableDates;

  @override
  void initState() {
    super.initState();
    _initializeAvailableSlots();
  }

  void _initializeAvailableSlots() {
    availableDates = _parseAndSortDates(widget.availableSlots);
    if (availableDates.isNotEmpty) {
      setState(() {
        availableSlotsDateTime = availableDates;
        _selectedDay = availableDates.first;
        _selectedTimeSlot = null;
      });
    }
  }

  List<DateTime> _parseAndSortDates(List<String> dateStrings) {
    return dateStrings
        .map((dateString) => _parseDateString(dateString))
        .where((date) => date != null)
        .map((date) => date!)
        .toList()
      ..sort((a, b) => a.compareTo(b));
  }

  DateTime? _parseDateString(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final slotsForSelectedDay = availableSlotsDateTime
        .where((dateTime) => isSameDay(dateTime, _selectedDay))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(35.0),
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
            SizedBox(height: 20),
            TableCalendar(
              focusedDay: _selectedDay,
              firstDay: availableDates.first,
              lastDay: availableDates.last.add(const Duration(days: 1)),
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _selectedTimeSlot = null;
                });
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: const Color(0xFF19649E),
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                defaultDecoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                disabledDecoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
              enabledDayPredicate: (day) {
                return availableDates
                    .any((availableDate) => isSameDay(availableDate, day));
              },
            ),
            SizedBox(height: 50),
            Text(
              "avaiableTimes".tr(),
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20.sp,
                color: Color(0xff19649E),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: slotsForSelectedDay.length,
                itemBuilder: (context, index) {
                  final timeSlot = slotsForSelectedDay[index];
                  final isSelected = _selectedTimeSlot == timeSlot;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedTimeSlot = timeSlot;
                          // print('Selected date and time: $timeSlot');
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected
                            ? const Color(0xFF19649E)
                            : Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        DateFormat('hh:mm a').format(timeSlot),
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF19649E),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: _selectedTimeSlot == null
                  ? null
                  : () {
                      // print(
                      // 'User confirmed: ${_selectedTimeSlot!.toUtc().toIso8601String()}');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentScreen(
                                    confirmedUserDateTimel:
                                        _selectedTimeSlot!.toUtc(),
                                  )));
                    },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(350, 50),
                backgroundColor: _selectedTimeSlot == null
                    ? Colors.grey
                    : const Color(0xFF19649E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "confirmDate".tr(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
