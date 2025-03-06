import 'package:doctor/cubit/doctor_details_cubit/doctor_profile_state.dart';
import 'package:doctor/models/Doctor_id_model.dart';
import 'package:doctor/screens/sign_up_as_client.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/doctor_details_cubit/doctor_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../make_email/login.dart';
import '../models/doctor_by_category_model.dart';
import '../widgets/doctor_details_info.dart';
import 'appointment_screen.dart';

class DoctorDetails extends StatefulWidget {
  final Specialists? specialists;
  final String doctorID;

  const DoctorDetails({super.key, required this.doctorID, this.specialists});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  int currentIndex = 0;
  String? _selectedTime; // Variable to store selected time
  String? _selectedDay; // Variable to store selected time
  // String? _formattedDate; // Variable to store formatted date
  late DoctorProfileCubit doctorProfileCubit;
  late UserProfileCubit userProfileCubit;

  @override
  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    doctorProfileCubit = BlocProvider.of<DoctorProfileCubit>(context);
    _loadDoctorProfile();
    _loadUserProfile();

    print(widget.doctorID);
  }

  Future<void> _loadDoctorProfile() async {
    print("Fetching doctor profile for ID: ${widget.doctorID}");
    doctorProfileCubit.getUserProfile(context, widget.doctorID);
    print(doctorProfileCubit.userData);
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";
    userProfileCubit.getUserProfile(context, id);
    doctorProfileCubit.getUserProfile(context, widget.doctorID);
    print(doctorProfileCubit.userData?.specialist?.availableSlots);
  }

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
    bool isEnglish = Localizations.localeOf(context).languageCode == 'en';

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => userProfileCubit, lazy: false),
          BlocProvider(create: (_) => doctorProfileCubit, lazy: false),
        ],
        child: BlocBuilder<UserProfileCubit, UserProfileState>(
            builder: (context, userProfileState) {
          print("User Profile State: $userProfileState");
          return BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
            builder: (context, doctorProfileState) {
              print("Doctor Profile State: $doctorProfileState");
              if (userProfileState is UserProfileLoading ||
                  doctorProfileState is DoctorProfileLoading) {
                return Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              } else if (userProfileState is UserProfileFailure &&
                  doctorProfileState is DoctorProfileSuccess) {
                DoctorByIdModel doctor = doctorProfileState.doctorProfile;
                print(doctor);
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(35.0.h),
                    // Set the height here
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
                              height:
                                  MediaQuery.of(context).size.height * 0.21.h,
                              // Adjust height proportionally
                              decoration: const BoxDecoration(
                                color: Color(0xff19649E),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 120, 20, 10),
                                child: SizedBox(
                                  width: 120.w,
                                  child: Text(
                                    (doctor.specialist?.firstName ?? "") +
                                        (doctor.specialist?.lastName ?? ""),
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold, // Bold text
                                      fontSize: 20, // Font size
                                      color:
                                          Colors.white, // Text color is white
                                    ),
                                  ),
                                ),
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
                                      )),
                                  child: Image.asset('assets/images/doctor.png',
                                      fit: BoxFit.contain),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 20, top: 60, left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DoctorInfo(
                                text:
                                    "${doctor.specialist?.sessionPrice ?? " "}",
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                doctor.specialist?.bio ?? "",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // SizedBox(height: 6.h),
                              // Text("doctorExample".tr(), style: TextStyle(
                              //     fontSize: 18.sp,
                              //     color: Colors.black,
                              //     fontWeight: FontWeight.bold),),
                              SizedBox(height: 6.h),
                              DoctorInfo(
                                text: 'typeExample'.tr(),
                              ),
                              SizedBox(height: 6.h),
                              DoctorInfo(
                                text: 'availableVideo'.tr(),
                              ),
                              SizedBox(height: 6.h),
                              DoctorInfo(
                                text:
                                    "${doctor.specialist?.yearsExperience ?? 0}",
                              ),
                              SizedBox(height: 6.h),
                              DoctorInfo(
                                text: 'languageExample'.tr(),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                "workingHours".tr(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Color(0xff19649E),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Wrap(
                                      spacing: 10,
                                      children: doctor
                                              .specialist?.availableSlots
                                              ?.map((timeString) {
                                            // تحويل النص إلى DateTime
                                            DateTime time =
                                                DateTime.parse(timeString);

                                            // تنسيق الوقت فقط بدون التاريخ
                                            String formattedTime =
                                                DateFormat('hh:mm a')
                                                    .format(time);

                                            return TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  _selectedTime =
                                                      timeString; // تخزين النص الأصلي لضمان التوافق
                                                });
                                              },
                                              style: TextButton.styleFrom(
                                                minimumSize: Size(110, 50),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                foregroundColor:
                                                    Colors.grey.shade300,
                                                backgroundColor:
                                                    _selectedTime == timeString
                                                        ? const Color(
                                                            0xFF19649E)
                                                        : Colors.grey.shade300,
                                              ),
                                              child: Text(
                                                formattedTime, // عرض الوقت فقط
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: _selectedTime ==
                                                          timeString
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                            );
                                          }).toList() ??
                                          [],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "day".tr(),
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Color(0xff19649E),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.h),

                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children:
                                      (isEnglish ? daySlotsEnglish : daySlots)
                                          .map((day) {
                                    return TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _selectedDay =
                                              day; // Update the selected time
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                        minimumSize: Size(110, 50),
                                        // Set minimum size for the button
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20), // Change this value for more or less rounding
                                        ),
                                        foregroundColor: Colors.grey.shade300,
                                        backgroundColor: _selectedDay == day
                                            ? const Color(0xFF19649E)
                                            : Colors
                                                .grey.shade300, // Text color
                                      ),
                                      child: Text(
                                        day,
                                        // textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: _selectedDay == day
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("alert".tr()),
                                        content: Text(
                                            "guestAccessibilityAlert".tr()),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                  context); // إغلاق الـ Alert
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage()), // استبدليها بصفحة تسجيل الدخول
                                              );
                                            },
                                            child: Text("login".tr()),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                  context); // إغلاق الـ Alert
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignUpAsClient()), // استبدليها بصفحة التسجيل
                                              );
                                            },
                                            child: Text("createAccount".tr()),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                  context); // إغلاق الـ Alert بدون أي انتقال
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
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Text(
                                    "bookDate".tr(),
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else if (userProfileState is UserProfileSuccess &&
                  doctorProfileState is DoctorProfileSuccess) {
                DoctorByIdModel doctor = doctorProfileState.doctorProfile;
                print(doctor);
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(35.0.h),
                    // Set the height here
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
                              height:
                                  MediaQuery.of(context).size.height * 0.21.h,
                              // Adjust height proportionally
                              decoration: const BoxDecoration(
                                color: Color(0xff19649E),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 120, 20, 10),
                                child: SizedBox(
                                  width: 120.w,
                                  child: Text(
                                    (doctor.specialist?.firstName ?? "") +
                                        " " +
                                        (doctor.specialist?.lastName ?? ""),
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold, // Bold text
                                      fontSize: 20, // Font size
                                      color:
                                          Colors.white, // Text color is white
                                    ),
                                  ),
                                ),
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
                                        )),
                                    child: doctor.specialist?.imageUrl == "" ||
                                            doctor.specialist?.imageUrl == null
                                        ? Image.asset(
                                            'assets/images/doctor.png',
                                            fit: BoxFit.contain)
                                        : Image.network(
                                            doctor.specialist?.imageUrl ??
                                                "", // رابط الصورة
                                            fit: BoxFit.contain, // ملء الصورة
                                          )),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 20, top: 60, left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DoctorInfo(
                                text:
                                    "session price:${doctor.specialist?.sessionPrice ?? " "}",
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                doctor.specialist?.bio ?? "",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Color(0xff19649E),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // SizedBox(height: 6.h),
                              // Text("doctorExample".tr(), style: TextStyle(
                              //     fontSize: 18.sp,
                              //     color: Colors.black,
                              //     fontWeight: FontWeight.bold),),
                              SizedBox(height: 6.h),
                              DoctorInfo(
                                text: 'typeExample'.tr(),
                              ),
                              SizedBox(height: 6.h),
                              DoctorInfo(
                                text: 'availableVideo'.tr(),
                              ),
                              SizedBox(height: 6.h),
                              DoctorInfo(
                                text: "Years of Experience: " +
                                    "${doctor.specialist?.yearsExperience ?? 0}",
                              ),
                              SizedBox(height: 6.h),
                              DoctorInfo(
                                text: 'languageExample'.tr(),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                "workingHours".tr(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Color(0xff19649E),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Wrap(
                                      spacing: 10,
                                      children: doctor
                                              .specialist?.availableSlots
                                              ?.map((timeString) {
                                            if (timeString == null)
                                              return SizedBox();

                                            try {
                                              // تنظيف النص من "T" وأي مسافات زائدة
                                              String cleanedTimeString =
                                                  timeString
                                                      .replaceAll("T", "")
                                                      .trim();

                                              // استخراج الجزء الخاص بالوقت فقط
                                              RegExp regex = RegExp(
                                                  r"(\d{1,2}:\d{2} (AM|PM))");
                                              Match? match = regex.firstMatch(
                                                  cleanedTimeString);

                                              if (match == null) {
                                                print(
                                                    "❌ فشل استخراج الوقت من: $timeString");
                                                return SizedBox();
                                              }

                                              String formattedTime =
                                                  match.group(0)!; // الوقت فقط

                                              return TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _selectedTime = timeString;
                                                  });
                                                },
                                                style: TextButton.styleFrom(
                                                  minimumSize: Size(110, 50),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  foregroundColor:
                                                      Colors.grey.shade300,
                                                  backgroundColor:
                                                      _selectedTime ==
                                                              timeString
                                                          ? const Color(
                                                              0xFF19649E)
                                                          : Colors
                                                              .grey.shade300,
                                                ),
                                                child: Text(
                                                  formattedTime, // عرض الوقت فقط مع AM/PM
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: _selectedTime ==
                                                            timeString
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                              );
                                            } catch (e) {
                                              print(
                                                  "❌ خطأ في معالجة الوقت: $timeString - $e");
                                              return SizedBox();
                                            }
                                          }).toList() ??
                                          [],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "day".tr(),
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Color(0xff19649E),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.h),

                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: doctor.specialist?.availableSlots
                                          ?.map((dayString) {
                                        if (dayString == null)
                                          return SizedBox();

                                        try {
                                          // تنظيف النص من أي حرف "T" زائد والمسافات غير الضرورية
                                          String cleanedDayString = dayString
                                              .replaceAll("T", " ")
                                              .trim();

                                          // قائمة بالتنسيقات الممكنة
                                          List<String> possibleFormats = [
                                            "yyyy-MM-dd HH:mm", // 2025-07-10 18:00
                                            "yyyy-MM-dd hh:mm a", // 2025-07-10 08:00 AM
                                            "yyyy-MM-dd'T'HH:mm", // 2025-07-10T18:00
                                            "yyyy-MM-dd'T'hh:mm a", // 2025-07-10T08:00 AM
                                          ];

                                          DateTime?
                                              parsedDate; // يجب أن يكون قابلاً للإسناد بـ null

                                          for (String format
                                              in possibleFormats) {
                                            try {
                                              parsedDate = DateFormat(format)
                                                  .parse(cleanedDayString);
                                              break; // إذا تم التحليل بنجاح، نخرج من الحلقة
                                            } catch (e) {
                                              continue; // جرب التنسيق التالي
                                            }
                                          }

                                          // لو لم يتم التحليل بنجاح، اطبع تحذيرًا وأعد زرًا فارغًا
                                          if (parsedDate == null) {
                                            print(
                                                "❌ فشل تحليل التاريخ: $dayString");
                                            return SizedBox();
                                          }

                                          // استخراج اليوم من الأسبوع (Sunday, Monday,...)
                                          String dayOfWeek = DateFormat('EEEE')
                                              .format(parsedDate);

                                          return TextButton(
                                            onPressed: () {
                                              setState(() {
                                                _selectedDay = dayString;
                                              });
                                            },
                                            style: TextButton.styleFrom(
                                              minimumSize: Size(110, 50),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              foregroundColor:
                                                  Colors.grey.shade300,
                                              backgroundColor:
                                                  _selectedDay == dayString
                                                      ? const Color(0xFF19649E)
                                                      : Colors.grey.shade300,
                                            ),
                                            child: Text(
                                              dayOfWeek, // عرض اليوم فقط
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold,
                                                color: _selectedDay == dayString
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          );
                                        } catch (e) {
                                          print(
                                              "❌ خطأ غير متوقع عند تحليل التاريخ: $dayString - $e");
                                          return SizedBox();
                                        }
                                      }).toList() ??
                                      [],
                                ),
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    print(
                                        "111111111111111111111111111111111111111111");
                                    print(doctor
                                        .specialist!.specialties!.mentalHealth);
                                    print(
                                        "111111111111111111111111111111111111111111");
                                    if (doctor.specialist == null ||
                                        doctor.specialist!.availableSlots ==
                                            null ||
                                        doctor.specialist!.availableSlots!
                                            .isEmpty) {
                                      const snackBar = SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                            'No available slots for This doctor',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AppointmentScreen(
                                                    availableSlots: doctor
                                                                .specialist ==
                                                            null
                                                        ? []
                                                        : doctor.specialist!
                                                                .availableSlots ??
                                                            [],
                                                  )));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(350, 50),
                                      backgroundColor: const Color(0xFF19649E),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Text(
                                    "bookDate".tr(),
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              return Scaffold(
                  body: Center(
                      child: Text(
                "Error loading data",
                style: TextStyle(color: Colors.black, fontSize: 25.sp),
              ))); // Default return in case no state matches
            },
          );
        }));
  }
}
