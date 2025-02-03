import 'package:flutter/material.dart';
import '../widgets/doctor_details_info.dart';
import 'appointment_screen.dart';
// import 'package:intl/intl.dart';


class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {

  String? _selectedTime; // Variable to store selected time
  String? _selectedDay; // Variable to store selected time
  // String? _formattedDate; // Variable to store formatted date


  final List<String> timeSlots = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
  ];

  final List<String> daySlots = [
    'السبت',
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(35.0), // Set the height here
          child: AppBar(
            backgroundColor: const Color(0xff19649E),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.21, // Adjust height proportionally
                decoration: const BoxDecoration(
                  color: Color(0xff19649E),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0,120,50,10),
                  child: Text("د. محمود محمد",
                    style: TextStyle(
                    fontWeight: FontWeight.bold, // Bold text
                    fontSize: 20, // Font size
                    color: Colors.white, // Text color is white
                  ),),
                ),
              ),
              SizedBox(
                height: 220,
                width: 180,
                child: Transform.translate(
                  offset: const Offset(-210, 50),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60.0),
                        topRight: Radius.circular(60.0),
                      )
                    ),
                    child: Image.asset('assets/images/doctor.png', fit: BoxFit.contain),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const DoctorInfo(text: 'السعر: 300 ليرة / 30 دقيقة',),
                const SizedBox(height: 6),
                const Align(
                  alignment: Alignment.centerRight,
                    child: Text("نبذة عن الأخصائي", style: TextStyle(fontSize: 18, color: Color(0xff19649E), fontWeight: FontWeight.bold,),)),
                const SizedBox(height: 6),
                const Align(
                    alignment: Alignment.centerRight,
                    child: Text("طبيب نفسي مهتم بالوقاية النفسية", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),)),
                const SizedBox(height: 6),
                const DoctorInfo(text: 'النوع: وقاية نفسية',),
                const SizedBox(height: 6),
                const DoctorInfo(text: 'متاح جلسات صوتية، فيديو',),
                const SizedBox(height: 6),
                const DoctorInfo(text: 'خبرة 7 سنوات',),
                const SizedBox(height: 6),
                const DoctorInfo(text: 'اللغة: العربية، الإنجليزية',),
                const SizedBox(height: 10),
                const Align(
                    alignment: Alignment.centerRight,
                    child: Text("ساعات العمل", style: TextStyle(fontSize: 20, color: Color(0xff19649E), fontWeight: FontWeight.bold,),)),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [

                      Wrap(
                        spacing: 10,
                        children: timeSlots.map((time) {
                          return TextButton(
                            onPressed: () {
                              setState(() {
                                _selectedTime = time; // Update the selected time
                              });
                            },
                            style: TextButton.styleFrom(
                              minimumSize: Size(110, 50), // Set minimum size for the button
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20), // Change this value for more or less rounding
                              ),
                              foregroundColor: Colors.grey.shade300,
                              backgroundColor: _selectedTime == time ? const Color(0xFF19649E) : Colors.grey.shade300, // Text color
                            ),
                            child: Text(time, textDirection: TextDirection.ltr,
                              style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold,
                                color: _selectedTime == time ? Colors.white : Colors.black,
                              ),),
                          );
                        }).toList(),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 10,),
                const Align(
                    alignment: Alignment.centerRight,
                    child: Text("اليوم", style: TextStyle(fontSize: 20, color: Color(0xff19649E), fontWeight: FontWeight.bold,),)),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: Row(
                    spacing: 10,
                    children:
                    daySlots.map((day) {
                      return TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedDay = day; // Update the selected time
                          });
                        },
                        style: TextButton.styleFrom(
                          minimumSize: Size(110, 50), // Set minimum size for the button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Change this value for more or less rounding
                          ),
                          foregroundColor: Colors.grey.shade300,
                          backgroundColor: _selectedDay == day ? const Color(0xFF19649E) : Colors.grey.shade300, // Text color
                        ),
                        child: Text(day,
                          // textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold,
                            color: _selectedDay == day ? Colors.white : Colors.black,
                          ),),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 50,),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const AppointmentScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(350, 50),
                        backgroundColor: const Color(0xFF19649E),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text(
                      "حجز موعد",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
