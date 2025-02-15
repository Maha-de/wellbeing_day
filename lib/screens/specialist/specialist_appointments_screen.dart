import 'package:doctor/cubit/delete_account_cubit/delete_account_cubit.dart';
import 'package:doctor/screens/change_language.dart';
import 'package:doctor/screens/client_change_password.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import '../../cubit/doctor_details_cubit/doctor_profile_cubit.dart';
import '../../cubit/doctor_details_cubit/doctor_profile_state.dart';
import '../../cubit/reset_password_cubit/reset_password_cubit.dart';
import '../../cubit/update_user_cubit/update_user_cubit.dart';
import '../../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../../cubit/user_profile_cubit/user_profile_state.dart';
import '../../models/Doctor_id_model.dart';
import '../../models/user_profile_model.dart';


class SpecialistAppointmentsScreen extends StatefulWidget {
  const SpecialistAppointmentsScreen({super.key});


  @override
  State<SpecialistAppointmentsScreen> createState() => _SpecialistAppointmentsScreenState();
}

class _SpecialistAppointmentsScreenState extends State<SpecialistAppointmentsScreen> {

  List<Widget> dayContainers = [];
  void showDeleteAccountBottomSheet(BuildContext context, VoidCallback onConfirm) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20), // Rounded top corners
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Adjust height to fit content
            children: [
              Text(
                "confirmDeleteAccount".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Divider(thickness: 1, color: Color(0xff19649E)),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xff19649E),width: 2),
                      shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(20),

                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the bottom sheet
                    },
                    child: Text(
                      "dismiss".tr(),
                      style: TextStyle(color: Color(0xff19649E),fontSize: 20,fontWeight: FontWeight.w600),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff19649E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the bottom sheet
                      onConfirm(); // Handle confirmation
                    },
                    child: Text(
                      "confirm".tr(),
                      style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }


  late DoctorProfileCubit userProfileCubit;
  late AddImageToProfileCubit addImageToProfileCubit;

  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<DoctorProfileCubit>(context);
    addImageToProfileCubit = BlocProvider.of<AddImageToProfileCubit>(context);// Initialize the cubit
    _loadUserProfile();
    // Call the asynchronous method here
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('doctorId') ?? "";

    // Set the state once the user profile data is fetched
    userProfileCubit.getUserProfile(context, id);
  }
  @override

  Widget build(BuildContext context) {
    List<String> actions = ["changeLanguage".tr(), "passwordManager".tr()];

    // MediaQuery for responsive sizing
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
        create: (_) => userProfileCubit,  // Use the same cubit instance
        child: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
          builder: (context, state) {
            if (state is DoctorProfileLoading) {
              return Scaffold(body: Center(child: CircularProgressIndicator(),));
            } else if (state is DoctorProfileFailure) {
              return Center(child: Text("Error loading profile: ${state.error}"));
            } else if (state is DoctorProfileSuccess) {

              // Once the profile is loaded, show the actual UI
              DoctorByIdModel userProfile = state.doctorProfile;
              
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  leading: IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_backspace,size: 25,)),
                  backgroundColor: const Color(0xff19649E),
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                  centerTitle: true,
                  title: Text(
                    "مواعيدي",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: screenHeight * 0.22,  // Adjust height proportionally
                                decoration: BoxDecoration(
                                  color: Color(0xff19649E),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                  
                              ),
                              Positioned(
                                bottom: -50,
                                left: 0,
                                right: 0,
                                child: Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.bottomLeft,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              addImageToProfileCubit.pickImage(context,userProfile.specialist?.id??"");
                                              BlocProvider.of<DoctorProfileCubit>(context).getUserProfile(context, userProfile.specialist?.id??"");
                                            });
                  
                                          },
                                          child: Container(
                                            height: screenWidth * 0.3,
                                            // Adjust size proportionally
                                            width: screenWidth * 0.3,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(40),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(30),
                  
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(50), // زاوية الإطار
                                                  child: userProfile.specialist?.imageUrl==""||userProfile.specialist?.imageUrl==null?Image.asset("assets/images/profile.jpg",fit: BoxFit.fill,):Image.network(
                                                    userProfile.specialist?.imageUrl ?? "", // رابط الصورة
                                                    fit: BoxFit.fill, // ملء الصورة
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: (){
                                            setState(() {
                                              addImageToProfileCubit.pickImage(context,userProfile.specialist?.id??"");
                                              BlocProvider.of<DoctorProfileCubit>(context).getUserProfile(context, userProfile.specialist?.id??"");
                                            });
                                          },
                                          icon: Positioned(
                                            bottom: 10,
                                            left: 10,
                                            child: CircleAvatar(
                                              radius: 16,
                                              backgroundColor: Color(0xff19649E),
                                              child: Icon(Icons.edit, size: 16, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 35),
                          Positioned(
                            left: screenWidth * 0.35, // Adjust for better centering
                            top: -100,
                            child: Text(
                              "${userProfileCubit.userData?.specialist?.firstName}",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: screenWidth * 0.06,
                                // Adjust size based on screen width
                                color: Color(0xff19649E),
                              ),
                            ),
                          ),
                          SizedBox(height: 35),
                          Container(
                            width: screenWidth * 0.85,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                          
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
                                                      hintText: "الأحد",
                                                      hintStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    style: TextStyle(color: Colors.black),
                                                    textAlign: TextAlign.center,
                          
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
                                                      hintText: "2.30Am",
                                                      hintStyle: TextStyle(
                                                        // color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    style: TextStyle(color: Colors.black),
                                                    textAlign: TextAlign.center,
                          
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
                                          Icons.remove,
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
                          SizedBox(height: 20),
                          Container(
                            width: screenWidth * 0.85,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                          
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
                                                      hintText: "الاثنين",
                                                      hintStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    style: TextStyle(color: Colors.black),
                                                    textAlign: TextAlign.center,
                          
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
                                                      hintText: "5.00PM",
                                                      hintStyle: TextStyle(
                                                        // color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    style: TextStyle(color: Colors.black),
                                                    textAlign: TextAlign.center,
                          
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
                                          Icons.remove,
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
                          SizedBox(height: 20),
                          Container(
                            width: screenWidth * 0.85,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                          
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
                                                      hintText: "الثلاثاء",
                                                      hintStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    style: TextStyle(color: Colors.black),
                                                    textAlign: TextAlign.center,
                          
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
                                                      hintText: "3.45Am",
                                                      hintStyle: TextStyle(
                                                        // color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    style: TextStyle(color: Colors.black),
                                                    textAlign: TextAlign.center,
                          
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
                                          Icons.remove,
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
                          SizedBox(height: 20),
                          Center(
                            child: Container(
                              width: 138,
                              height: 38,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color(0xff19649E)
                              ),
                              child: Center(
                                child: Text("إضافة جلسه",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700
                                ),),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            width: screenWidth * 0.85,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                          
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
                  
                    ],
                  ),
                ),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0,right: 20,left: 20), // Adds space below the button
                  child: Container(
                    width: screenWidth * 0.85, // Keeps the width consistent
                    height: 45, // Reduced height to make the button smaller
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your confirmation logic here
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(700, 45), // Adjusted minimum size to match the new height
                        backgroundColor: const Color(0xFF19649E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "تحديث",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ));

  }
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
  }
}
