import 'package:doctor/screens/specialist/specialist_appointments_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                "الرجاء تحميل صورة ملف شخصي",
                style: TextStyle(
                  fontSize: 20,
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
                      height:140,
                      // Adjust size proportionally
                      width: 140,
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
                        width: 41.67,
                        height: 41.67,
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
                "${userProfile.specialist?.firstName}"+"دكتور ",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff19649E),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "تحديد اللغه",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff19649E),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 7,),
                  Container(
                    width: screenWidth * 0.85,
                    height: 48,
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
                              contentPadding: EdgeInsets.symmetric(horizontal: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: "تحديد اللغه",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                // Add a new day container when tapped

                              });
                            },
                            child: Container(
                              width: 27,
                              height: 28,
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
              SizedBox(height: 30,),
              // Display the dynamically added day containers
              Container(
            width: screenWidth * 0.85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "تحديد اوقات العمل",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff19649E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 7,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Center(
                          child: Container(
                            width: 133,
                            height: 40,
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
                                      hintText: "يوم",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Center(
                          child: Container(
                            width: 133,
                            height: 40,
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
                                      hintText: "ساعه",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.rtl,
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
                        width: 27,
                        height: 40,
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
              SizedBox(height: 10,),
              Column(
                children: dayContainers,
              ),


            ],
          ),
        ),
      ),
    ),
    bottomNavigationBar: Padding(
      padding: const EdgeInsets.only(bottom: 20.0,right: 20,left: 20), // Adds space below the button
      child: Container(
        width: screenWidth * 0.85, // Keeps the width consistent
        height: 45, // Reduced height to make the button smaller
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                    BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                    BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                  ],
                  child:  SpecialistAppointmentsScreen(),
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
            "تأكيد",
            style: const TextStyle(
              fontSize: 20,
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
        width: screenWidth * 0.85,
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
                        width: 133,
                        height: 40,
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
                                  hintText: "يوم",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Center(
                      child: Container(
                        width: 133,
                        height: 40,
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
                                  hintText: "ساعه",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
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
                    width: 27,
                    height: 40,
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

