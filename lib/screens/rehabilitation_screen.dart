import 'package:doctor/screens/sign_up_as_client.dart';
import 'package:doctor/widgets/custom_app_bar.dart';
import 'package:doctor/widgets/custom_bottom_nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/doctor_by_category_cubit/doctor_by_category_cubit.dart';
import '../cubit/doctor_by_category_cubit/doctor_by_category_state.dart';
import '../cubit/get_specialist/get_sepcialist_cubit.dart';
import '../cubit/get_specialist/get_specialist_state.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../make_email/login.dart';
import '../models/user_profile_model.dart';
import '../widgets/doctor_card.dart';
import 'applicationInfo.dart';
import 'first_home_page.dart';
import 'homescreen.dart';

class RehabilitationScreen extends StatefulWidget {
  final String category;
  final String subCategory;
  const RehabilitationScreen({super.key, required this.category, required this.subCategory});

  @override
  State<RehabilitationScreen> createState() => _RehabilitationScreenState();
}

class _RehabilitationScreenState extends State<RehabilitationScreen> {
  late UserProfileCubit userProfileCubit;
  late DoctorByCategoryCubit doctorByCategoryCubit;

  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    doctorByCategoryCubit = BlocProvider.of<DoctorByCategoryCubit>(context);
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";
    userProfileCubit.getUserProfile(context, id);
    doctorByCategoryCubit.fetchSpecialistsbycategory(widget.category, widget.subCategory,context);
  }
  int currentIndex=1;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width.w;
    double screenHeight = MediaQuery.of(context).size.height.h;

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
              bottomNavigationBar:BottomNavigationBar(
                backgroundColor: const Color(0xff19649E), // Ensures the background is consistent
                selectedItemColor: Colors.white, // Sets the color of the selected icons
                unselectedItemColor: Colors.black, // Sets the color of unselected icons
                showSelectedLabels: false, // Hides selected labels
                showUnselectedLabels: false, // Hides unselected labels
                currentIndex: currentIndex, // Default selected index
                type: BottomNavigationBarType.fixed, // Prevents animation on shifting types
                items: [
                  BottomNavigationBarItem(
                    icon: SizedBox(
                      height: 27.h, // Adjust icon size
                      child:
                      Image.asset(
                        "assets/images/meteor-icons_home.png",
                        // color: currentIndex == 0 ? Colors.white : Colors.black,
                        fit: BoxFit.fill,
                      ),
                    ),
                    activeIcon: SizedBox(
                      height: 27.h, // Active icon size adjustment
                      child: Image.asset(
                        "assets/images/meteor-icons_home.png",
                        color: currentIndex == 0 ? Colors.white : Colors.black,

                        fit: BoxFit.fill,
                      ),
                    ),
                    label: "home".tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox(
                      height: 27.h,
                      child: Image.asset(
                        "assets/images/nrk_category1.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    activeIcon: SizedBox(
                      height: 27.h,
                      child: Image.asset(
                        "assets/images/nrk_category.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    label: "menu".tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox(
                      height: 25.h, // Adjust icon size
                      child: Image.asset(
                        "assets/images/material-symbols_help-clinic-outline-rounded.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    activeIcon: SizedBox(
                      height: 33.h,
                      // width: 50,
                      child: Image.asset(
                        "assets/images/material-symbols_help-clinic-outline-rounded_Active.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    label: "info".tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox(
                      height: 27.h,
                      child: Image.asset(
                        "assets/images/gg_profile.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    activeIcon: SizedBox(
                      height: 27.h,
                      child: Image.asset(
                        "assets/images/gg_profile1.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    label: "profile".tr(),
                  ),
                ],
                onTap: (index) {
                  switch (index) {
                    case 3:

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
                      break;
                    case 1:

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                                BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                                BlocProvider<SubCategoriesCubit>(create: (_) => SubCategoriesCubit()),
                                BlocProvider<GetAllAdsCubit>(create: (_) => GetAllAdsCubit()),
                              ],
                              child: const HomeScreen(),
                            ),
                          ));
                      break;
                    case 2:

                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ApplicationInfo()));

                      break;

                    case 0:

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                                BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                                BlocProvider<SubCategoriesCubit>(create: (_) => SubCategoriesCubit()),
                                BlocProvider<GetAllAdsCubit>(create: (_) => GetAllAdsCubit()),
                              ],
                              child: const FirstHomePage(),
                            ),
                          ));
                      break;
                  }
                },
              ),
              appBar: AppBar(

                elevation: 0,
                backgroundColor: Colors.transparent,
                iconTheme: const IconThemeData(
                  color: Color(0xff19649E),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: 161.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: Color(0xFF1F78BC),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "rehabilitationPage".tr(),
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildDisorderButton("parkinson".tr()),
                        _buildDisorderButton("alzheimer".tr()),
                        _buildDisorderButton("epilepsy".tr()),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildDisorderButton("mentalIllness".tr()),
                        _buildDisorderButton("psychosis".tr()),
                        _buildDisorderButton("shockEvents".tr()),
                      ],
                    ),

                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        width: 161.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: Color(0xFF1F78BC),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "specialists".tr(),
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    // List of doctors
                    BlocBuilder<DoctorByCategoryCubit, DoctorByCategoryState>(
                      builder: (context, state) {
                        if (state is DoctorByCategoryLoading) {
                          return CircularProgressIndicator(); // Show loading indicator
                        } else if (state is DoctorByCategoryFailure) {
                          return Text(state.errMessage); // Display error message
                        } else if (state is DoctorByCategorySuccess) {
                          return Container(
                            height: screenHeight*0.63.h,
                            child: ListView.builder(
                              itemCount: state.specialists.length,
                              itemBuilder: (context, index) {
                                return DoctorCard(specialists: state.specialists[index], doctorID: state.specialists[index].id??"",);
                              },
                            ),
                          );
                        } else {
                          return Center(child: Text('noSpecialistsFound'.tr()));
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          } else if (state is UserProfileSuccess) {
            UserProfileModel userProfile = state.userProfile;
            return Scaffold(
              bottomNavigationBar: CustomBottomNavBar(currentIndex: 1),
              appBar: AppBar(

                elevation: 0,
                backgroundColor: Colors.transparent,
                iconTheme: const IconThemeData(
                  color: Color(0xff19649E),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: 161.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: Color(0xFF1F78BC),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "rehabilitationPage".tr(),
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildDisorderButton("parkinson".tr()),
                        _buildDisorderButton("alzheimer".tr()),
                        _buildDisorderButton("epilepsy".tr()),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildDisorderButton("mentalIllness".tr()),
                        _buildDisorderButton("psychosis".tr()),
                        _buildDisorderButton("shockEvents".tr()),
                      ],
                    ),

                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        width: 161.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: Color(0xFF1F78BC),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "specialists".tr(),
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    // List of doctors
                    BlocBuilder<DoctorByCategoryCubit, DoctorByCategoryState>(
                      builder: (context, state) {
                        if (state is DoctorByCategoryLoading) {
                          return CircularProgressIndicator(); // Show loading indicator
                        } else if (state is DoctorByCategoryFailure) {
                          return Text(state.errMessage); // Display error message
                        } else if (state is DoctorByCategorySuccess) {
                          return Container(
                            height: screenHeight*0.63.h,
                            child: ListView.builder(
                              itemCount: state.specialists.length,
                              itemBuilder: (context, index) {
                                return DoctorCard(specialists: state.specialists[index], doctorID: state.specialists[index].id??"",);
                              },
                            ),
                          );
                        } else {
                          return Center(child: Text('noSpecialistsFound'.tr()));
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          }
          return Container(); // Default return in case no state matches
        },
      ),
    );
  }

  // Helper method to build disorder buttons
  Widget _buildDisorderButton(String title) {
    return Container(
      width: 105.w,
      height: 68.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff69B7F3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          title,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
