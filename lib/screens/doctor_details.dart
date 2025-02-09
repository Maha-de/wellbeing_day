import 'package:doctor/api/end_points.dart';
import 'package:doctor/screens/sign_up_as_client.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../make_email/login.dart';
import '../models/user_profile_model.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/doctor_details_info.dart';
import 'appointment_screen.dart';
import '../models/specialist_model.dart';

// import 'package:intl/intl.dart';


class DoctorDetails extends StatefulWidget {
  final Specialist specialistModel;

  const DoctorDetails({super.key, required this.specialistModel});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
int currentIndex=0;
  String? _selectedTime; // Variable to store selected time
  String? _selectedDay; // Variable to store selected time
  // String? _formattedDate; // Variable to store formatted date

  late UserProfileCubit userProfileCubit;
  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";
    userProfileCubit.getUserProfile(context, id);
  }
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

final List<String> daySlotsEnglish = [
  'Saturday',
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
];


  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isEnglish = Localizations.localeOf(context).languageCode == 'en';

    return BlocProvider(
        create: (_) => userProfileCubit,
        child: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (state is UserProfileFailure) {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: PreferredSize(
                  preferredSize:  Size.fromHeight(35.0.h), // Set the height here
                  child: AppBar(
                    backgroundColor: const Color(0xff19649E),
                    iconTheme: const IconThemeData(
                      color: Colors.white,
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width.w,
                            height: MediaQuery.of(context).size.height * 0.21.h, // Adjust height proportionally
                            decoration: const BoxDecoration(
                              color: Color(0xff19649E),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20,120,20,10),
                              child: Text(
                                "nameSample".tr(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold, // Bold text
                                  fontSize: 20, // Font size
                                  color: Colors.white, // Text color is white
                                ),),
                            ),
                          ),
                          SizedBox(
                            height: 200.h,
                            width: 150.w,
                            child: Transform.translate(
                              offset: Offset(isEnglish ? 230 : -210, 50
                              ),
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
                        padding: const EdgeInsets.only(right: 20, top: 60, left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DoctorInfo(text: 'priceSample'.tr(),),
                            SizedBox(height: 6.h),
                            Text("bioExample".tr(), style: TextStyle(fontSize: 18.sp, color: Color(0xff19649E), fontWeight: FontWeight.bold,),),
                            SizedBox(height: 6.h),
                            Text("doctorExample".tr(), style: TextStyle(fontSize: 18.sp, color: Colors.black, fontWeight: FontWeight.bold),),
                            SizedBox(height: 6.h),
                            DoctorInfo(text: 'typeExample'.tr(),),
                            SizedBox(height: 6.h),
                            DoctorInfo(text: 'availableVideo'.tr(),),
                            SizedBox(height: 6.h),
                            DoctorInfo(text: 'yearsExample'.tr(),),
                            SizedBox(height: 6.h),
                            DoctorInfo(text: 'languageExample'.tr(),),
                            SizedBox(height: 10.h),
                            Text("workingHours".tr(), style: TextStyle(fontSize: 20.sp, color: Color(0xff19649E), fontWeight: FontWeight.bold,),),
                            SizedBox(height: 10.h),
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
                                        child: Text(time,
                                          style: TextStyle(
                                            fontSize: 18.sp, fontWeight: FontWeight.bold,
                                            color: _selectedTime == time ? Colors.white : Colors.black,
                                          ),),
                                      );
                                    }).toList(),
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(height: 10.h,),
                            Text("day".tr(), style: TextStyle(fontSize: 20.sp, color: Color(0xff19649E), fontWeight: FontWeight.bold,),),
                            SizedBox(height: 10.h),
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
                                        fontSize: 18.sp, fontWeight: FontWeight.bold,
                                        color: _selectedDay == day ? Colors.white : Colors.black,
                                      ),),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(height: 50.h,),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {

                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("alert".tr()),
                                      content: Text("guestAccessibilityAlert".tr()),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context); // إغلاق الـ Alert
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => LoginPage()), // استبدليها بصفحة تسجيل الدخول
                                            );
                                          },
                                          child: Text("login".tr()),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context); // إغلاق الـ Alert
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => SignUpAsClient()), // استبدليها بصفحة التسجيل
                                            );
                                          },
                                          child: Text("createAccount".tr()),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context); // إغلاق الـ Alert بدون أي انتقال
                                          },
                                          child: Text("cancel".tr()),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(350, 50),
                                    backgroundColor: const Color(0xFF19649E),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10))),
                                child:  Text(
                                  "bookDate".tr(),
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else if (state is UserProfileSuccess) {
              UserProfileModel userProfile = state.userProfile;
              return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize:  Size.fromHeight(35.0.h), // Set the height here
          child: AppBar(
            backgroundColor: const Color(0xff19649E),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width.w,
                  height: MediaQuery.of(context).size.height * 0.21.h, // Adjust height proportionally
                  decoration: const BoxDecoration(
                    color: Color(0xff19649E),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20,120,20,10),
                    child: Text(
                      "nameSample".tr(),
                      style: const TextStyle(
                      fontWeight: FontWeight.bold, // Bold text
                      fontSize: 20, // Font size
                      color: Colors.white, // Text color is white
                    ),),
                  ),
                ),
                SizedBox(
                  height: 200.h,
                  width: 150.w,
                  child: Transform.translate(
                    offset: Offset(isEnglish ? 230 : -210, 50),
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
              padding: const EdgeInsets.only(right: 20, top: 60, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DoctorInfo(text: 'priceSample'.tr(),),
                   SizedBox(height: 6.h),
                   Text("bioExample".tr(), style: TextStyle(fontSize: 18.sp, color: Color(0xff19649E), fontWeight: FontWeight.bold,),),
                   SizedBox(height: 6.h),
                   Text("doctorExample".tr(), style: TextStyle(fontSize: 18.sp, color: Colors.black, fontWeight: FontWeight.bold),),
                   SizedBox(height: 6.h),
                  DoctorInfo(text: 'typeExample'.tr(),),
                   SizedBox(height: 6.h),
                  DoctorInfo(text: 'availableVideo'.tr(),),
                   SizedBox(height: 6.h),
                  DoctorInfo(text: 'yearsExample'.tr(),),
                   SizedBox(height: 6.h),
                  DoctorInfo(text: 'languageExample'.tr(),),
                   SizedBox(height: 10.h),
                   Text("workingHours".tr(), textAlign: TextAlign.start,
                     style: TextStyle(fontSize: 20.sp, color: Color(0xff19649E), fontWeight: FontWeight.bold,),),
                   SizedBox(height: 10.h),
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
                              child: Text(time,
                                style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.bold,
                                  color: _selectedTime == time ? Colors.white : Colors.black,
                                ),),
                            );
                          }).toList(),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 10.h,),
                   Text("day".tr(), style: TextStyle(fontSize: 20.sp, color: Color(0xff19649E), fontWeight: FontWeight.bold,),),
                   SizedBox(height: 10.h),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,

                    child: Row(
                      spacing: 10,
                      children:
                      (isEnglish ? daySlotsEnglish  : daySlots).map((day) {
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
                              fontSize: 18.sp, fontWeight: FontWeight.bold,
                              color: _selectedDay == day ? Colors.white : Colors.black,
                            ),),
                        );
                      }).toList(),
                    ),
                  ),
                   SizedBox(height: 50.h,),
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
                      child:  Text(
                        "bookDate".tr(),
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h,),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  return Container(); // Default return in case no state matches
},
));
}}
