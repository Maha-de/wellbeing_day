import 'package:doctor/cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import 'package:doctor/cubit/create_session.dart/create_session_cubit.dart';
import 'package:doctor/cubit/create_session.dart/create_session_state.dart';
import 'package:doctor/cubit/update_user_cubit/update_user_cubit.dart';
import 'package:doctor/models/sessionType.dart';
import 'package:doctor/screens/sign_up_as_client.dart';
import 'package:doctor/screens/specialists_screen.dart';
import 'package:doctor/widgets/custom_bottom_nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../make_email/login.dart';
import '../models/user_profile_model.dart';
import '../widgets/custom_app_bar.dart';
import 'applicationInfo.dart';
import 'first_home_page.dart';
import 'homescreen.dart';

class InstantSessionScreen extends StatefulWidget {
  const InstantSessionScreen({super.key});

  @override
  State<InstantSessionScreen> createState() => _InstantSessionScreenState();
}

class _InstantSessionScreenState extends State<InstantSessionScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController descController = TextEditingController();
  late UserProfileCubit userProfileCubit;
  int currentIndex = 1;
  late CreateSessionCubit createSessionCubit;
  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    descController = TextEditingController();
    createSessionCubit = BlocProvider.of<CreateSessionCubit>(context);

    _loadUserProfile();
  }

  @override
  void dispose() {
    descController.dispose();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";
    userProfileCubit.getUserProfile(context, id);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        // Return false to disable the back button
        return false;
      },
      child: BlocProvider(
          create: (_) => userProfileCubit,
          child: BlocBuilder<UserProfileCubit, UserProfileState>(
            builder: (context, state) {
              if (state is UserProfileLoading) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              } else if (state is UserProfileFailure) {
                return Scaffold(
                  bottomNavigationBar: BottomNavigationBar(
                    backgroundColor: const Color(
                        0xff19649E), // Ensures the background is consistent
                    selectedItemColor:
                        Colors.white, // Sets the color of the selected icons
                    unselectedItemColor:
                        Colors.black, // Sets the color of unselected icons
                    showSelectedLabels: false, // Hides selected labels
                    showUnselectedLabels: false, // Hides unselected labels
                    currentIndex: currentIndex, // Default selected index
                    type: BottomNavigationBarType
                        .fixed, // Prevents animation on shifting types
                    items: [
                      BottomNavigationBarItem(
                        icon: SizedBox(
                          height: 27, // Adjust icon size
                          child: Image.asset(
                            "assets/images/meteor-icons_home.png",
                            // color: currentIndex == 0 ? Colors.white : Colors.black,
                            fit: BoxFit.fill,
                          ),
                        ),
                        activeIcon: SizedBox(
                          height: 27.h, // Active icon size adjustment
                          child: Image.asset(
                            "assets/images/meteor-icons_home.png",
                            color:
                                currentIndex == 0 ? Colors.white : Colors.black,
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
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginPage()), // استبدليها بصفحة تسجيل الدخول
                                    );
                                  },
                                  child: Text("login".tr()),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // إغلاق الـ Alert
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ApplicationInfo()));

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
                  appBar: CustomAppBar(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20.0, top: 15),
                                child: Center(
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
                                      "instantSession".tr(),
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: screenWidth * 0.9.w,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "conditionBriefly".tr(),
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff19649E)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Container(
                                width: screenWidth * 0.9.w,
                                height: 180.h,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "howDoYouFeel".tr(),
                                    hintStyle: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                    filled: true,
                                    fillColor: Color(0xFFD5D5D5),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 16),
                                  ),
                                  maxLines: 10,
                                ),
                              ),
                              SizedBox(height: 15.h),
                              Container(
                                width: screenWidth * 0.9.w,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "sessionTerms".tr(),
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff1F78BC)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 7.h),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.circle,
                                          size: 10, color: Colors.black),
                                      SizedBox(width: 5.w),
                                      Expanded(
                                          child: Text("term1Instant".tr())),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.circle,
                                          size: 10, color: Colors.black),
                                      SizedBox(width: 5.w),
                                      Expanded(
                                          child: Text("term2Instant".tr())),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.circle,
                                          size: 10, color: Colors.black),
                                      SizedBox(width: 5.w),
                                      Expanded(
                                          child: Text("term3Instant".tr())),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.h),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
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
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginPage()), // استبدليها بصفحة تسجيل الدخول
                                      );
                                    },
                                    child: Text("login".tr()),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context); // إغلاق الـ Alert
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
                          child: Container(
                            width: screenWidth * 0.9.w,
                            height: 48.h,
                            decoration: BoxDecoration(
                              color: Color(0xff19649E),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'continue'.tr(),
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h),
                      ],
                    ),
                  ),
                );
              } else if (state is UserProfileSuccess) {
                UserProfileModel userProfile = state.userProfile;
                return Scaffold(
                  bottomNavigationBar: CustomBottomNavBar(currentIndex: 1),
                  appBar: CustomAppBar(
                    userProfile: userProfile,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  body: BlocProvider(
                    create: (context) => createSessionCubit,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20.0, top: 15),
                                  child: Center(
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
                                        "instantSession".tr(),
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: screenWidth * 0.9.w,
                                  child: Text(
                                    "conditionBriefly".tr(),
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff19649E)),
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Form(
                                  key: _formKey,
                                  child: Container(
                                    width: screenWidth * 0.9.w,
                                    height: 180.h,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Write Your fellings,please عبر عن حالتك  ";
                                        } else if (value.length <= 10) {
                                          return "The descrpition is very short! ";
                                        }
                                        return null;
                                      },
                                      controller: descController,
                                      decoration: InputDecoration(
                                        hintText: "howDoYouFeel".tr(),
                                        hintStyle: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey),
                                        filled: true,
                                        fillColor: Color(0xFFD5D5D5),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 16),
                                      ),
                                      maxLines: 10,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                Container(
                                  width: screenWidth * 0.9.w,
                                  child: Text(
                                    "sessionTerms".tr(),
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff1F78BC)),
                                  ),
                                ),
                                SizedBox(height: 7.h),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.circle,
                                            size: 10, color: Colors.black),
                                        SizedBox(width: 5.w),
                                        Expanded(
                                            child: Text("term1Instant".tr())),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.circle,
                                            size: 10, color: Colors.black),
                                        SizedBox(width: 5.w),
                                        Expanded(
                                            child: Text("term2Instant".tr())),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.circle,
                                            size: 10, color: Colors.black),
                                        SizedBox(width: 5.w),
                                        Expanded(
                                            child: Text("term3Instant".tr())),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.h),
                              ],
                            ),
                          ),
                          BlocConsumer<CreateSessionCubit, CreateSessionState>(
                            listener: (context, state) {
                              print("statttttttttttttttttte");
                              print(state.runtimeType);
                              if (state is CreateSessionLoading) {
                              } else if (state is CreateSessionSuccess) {
                                print("success");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Session Created Successfully!")),
                                );
                              } else if (state is CreateSessionError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Error: ${state.message}")),
                                );
                              }
                            },
                            builder: (context, state) {
                              bool isLoading = state is CreateSessionLoading;

                              return GestureDetector(
                                onTap: () {
                                  try {
                                    if (_formKey.currentState == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Form is not initialized!")),
                                      );
                                    } else if (_formKey.currentState!
                                            .validate() &&
                                        !isLoading) {
                                      if (_formKey.currentState!.validate() &&
                                          !isLoading) {
                                        createSessionCubit.createSession(
                                          null,
                                          null,
                                          null,
                                          InstantSession(
                                              description: descController.text),
                                        );
                                      }
                                      ;
                                    }
                                  } catch (e, stackTrace) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("An error occurred: $e")),
                                    );
                                    debugPrint(
                                        "Error: $e\nStack Trace: $stackTrace");
                                  }
                                },
                                child: Container(
                                  width: screenWidth * 0.9.w,
                                  height: 48.h,
                                  decoration: BoxDecoration(
                                    color: isLoading
                                        ? Colors.grey
                                        : Color(0xff19649E),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: isLoading
                                        ? CircularProgressIndicator() // Show loading spinner
                                        : Text(
                                            'continue'.tr(),
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 15.h),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Container(); // Default return in case no state matches
            },
          )),
    );
  }
}
