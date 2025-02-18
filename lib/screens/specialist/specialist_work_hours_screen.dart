import 'package:doctor/screens/specialist/specialist_appointments_screen.dart';
import 'package:doctor/screens/specialist/specialist_home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import '../../cubit/doctor_details_cubit/doctor_profile_cubit.dart';
import '../../cubit/doctor_details_cubit/doctor_profile_state.dart';
import '../../cubit/get_doctor_sessions_types_cubit/doctor_session_types_cubit.dart';
import '../../cubit/update_user_cubit/update_user_cubit.dart';
import '../../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../../models/Doctor_id_model.dart';

class SpecialistWorkHoursScreen extends StatefulWidget {
  const SpecialistWorkHoursScreen({super.key});

  @override
  _SpecialistWorkHoursScreenState createState() =>
      _SpecialistWorkHoursScreenState();
}

class _SpecialistWorkHoursScreenState extends State<SpecialistWorkHoursScreen> {
  List<Widget> dayContainers = []; // List to hold the dynamically added containers
  late DoctorProfileCubit userProfileCubit;
  late DoctorSessionTypesCubit sessionTypesCubit;
  late AddImageToProfileCubit addImageToProfileCubit;

  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<DoctorProfileCubit>(context);
    sessionTypesCubit = BlocProvider.of<DoctorSessionTypesCubit>(context);
    addImageToProfileCubit = BlocProvider.of<AddImageToProfileCubit>(context);
    _loadUserProfile();

  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('doctorId') ?? "";
    print(id);
    userProfileCubit.getUserProfile(context, id);
    sessionTypesCubit.getDoctorSessions(context, id);
  }


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
              return Scaffold(body: Center(child: Text("Error loading profile: ${state.error}")));
            } else if (state is DoctorProfileSuccess) {
              DoctorByIdModel userProfile = state.doctorProfile;
              return Scaffold(
                backgroundColor: Colors.white,
    body: SafeArea(
      maintainBottomViewPadding: true,
      top: true,
      minimum: EdgeInsets.only(top:50),
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
                  InkWell(
                    // onTap: (){
                    //   setState(() {
                    //     addImageToProfileCubit.pickImage(context,userProfile.id??"");
                    //     BlocProvider.of<UserProfileCubit>(context).getUserProfile(context, userProfile.id??"");
                    //   });
                    //
                    // },
                    child: Container(
                      height:140.h,
                      // Adjust size proportionally
                      width: 140.w,
                      decoration: BoxDecoration(

                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40), // زاوية الإطار
                            child: userProfile.specialist?.imageUrl ==
                                "" ||
                                userProfile.specialist?.imageUrl ==
                                    null
                                ? Image.asset(
                              "assets/images/profile.jpg",
                              fit: BoxFit.fill,
                            )
                                : Image.network(
                              userProfile.specialist?.imageUrl ??
                                  "", // رابط الصورة
                              fit: BoxFit
                                  .fill, // ملء الصورة
                            ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        addImageToProfileCubit.pickImage(
                            context, userProfile.specialist?.id ?? "");
                        BlocProvider.of<UserProfileCubit>(
                            context)
                            .getUserProfile(context,
                            userProfile.specialist?.id ?? "");
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
                          child: Icon(Icons.edit, size: 24, color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              Text(
                "${userProfile.specialist?.firstName} "+"doctor".tr(),
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
                  SizedBox(height: 7.h,),
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
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
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.start,
                            // textDirection: TextDirection.rtl,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
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
                                borderRadius: BorderRadius.circular(4),
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
              SizedBox(height: 30.h,),
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
                SizedBox(height: 7.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Center(
                          child: Container(
                            width: 131.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(11),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      hintText: "dayy".tr(),
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.center,
                                    // textDirection: TextDirection.rtl,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Center(
                          child: Container(
                            width: 131.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(11),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      hintText: "hour".tr(),
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.center,
                                    // textDirection: TextDirection.rtl,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          // Add a new day container when tapped
                          dayContainers.add(buildDayContainer(326.w));
                        });
                      },
                      child: Container(
                        width: 27.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: Color(0xff19649E),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
              SizedBox(height: 10.h,),
              Column(
                children: dayContainers,
              ),


            ],
          ),
        ),
      ),
    ),
    bottomNavigationBar: Padding(
      padding: EdgeInsets.only(bottom: 20.0.h,right: 20.w,left: 20.w), // Adds space below the button
      child: Container(
        width: 333.w, // Keeps the width consistent
        height: 48.h, // Reduced height to make the button smaller
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<DoctorProfileCubit>(create: (_) => DoctorProfileCubit()),
                    BlocProvider<DoctorSessionTypesCubit>(create: (_) => DoctorSessionTypesCubit()),
                    BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                  ],
                  child: SpecialistHomeScreen(),
                ),

              ),
                  (route) => false,
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(700, 45), // Adjusted minimum size to match the new height
            backgroundColor: const Color(0xFF19649E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            "confirm".tr(),
            style:  TextStyle(
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

  // Function to create a new "Day" container
  Widget buildDayContainer(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0,bottom: 10),
      child: Container(
        width: screenWidth ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Center(
                      child: Container(
                        width: 131,
                        height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  hintText: "dayy".tr(),
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                                // textDirection: TextDirection.rtl,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Center(
                      child: Container(
                        width: 131,
                        height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  hintText: "hour".tr(),
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                                // textDirection: TextDirection.rtl,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      // Add a new day container when tapped
                      dayContainers.add(buildDayContainer(screenWidth));
                    });
                  },
                  child: Container(
                    width: 27.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Color(0xff19649E),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }}

