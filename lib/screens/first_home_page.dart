import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor/screens/homescreen.dart';
import 'package:doctor/screens/sign_up_as_client.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/get_specialist/get_sepcialist_cubit.dart';
import '../cubit/get_specialist/get_specialist_state.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../make_email/login.dart';
import '../models/user_profile_model.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/doctor_card.dart';
import 'applicationInfo.dart';
import 'client_profile_screen.dart';

class FirstHomePage extends StatefulWidget {
  const FirstHomePage({super.key});

  @override
  State<FirstHomePage> createState() => _FirstHomePageState();
}

class _FirstHomePageState extends State<FirstHomePage> {
  var sliderIndex = 0;
  CarouselSliderController carouselControllerEx = CarouselSliderController();
  late UserProfileCubit userProfileCubit;
int currentIndex=0;
  var images = [
    'assets/images/familyy.png',
    'assets/images/familyyy.png',
  ];

  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    _loadUserProfile();
    final specialistCubit = BlocProvider.of<GetSpecialistCubit>(context);
    specialistCubit.fetchSpecialists();
    _startAutoPageSwitch();
  }
  PageController _pageController = PageController();
  void _startAutoPageSwitch() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.page?.toInt() == images.length - 1) {
        _pageController.jumpToPage(0);
      } else {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }
  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";
    userProfileCubit.getUserProfile(context, id);
  }
  late Timer _timer;


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width.w;
    double screenHeight = MediaQuery.of(context).size.height.h;
    return BlocProvider(
        create: (context) => userProfileCubit,
        child: BlocBuilder<UserProfileCubit, UserProfileState>(
            builder: (context, state) {
              if (state is UserProfileLoading) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              } else if (state is UserProfileFailure) {
                return  Scaffold(
                  appBar: CustomAppBar(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  backgroundColor: Colors.white,
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
                              title: Text("تنبيه"),
                              content: Text("يجب عليك تسجيل الدخول أو إنشاء حساب للوصول إلى هذه الصفحة."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // إغلاق الـ Alert
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => LoginPage()), // استبدليها بصفحة تسجيل الدخول
                                    );
                                  },
                                  child: Text("تسجيل الدخول"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // إغلاق الـ Alert
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SignUpAsClient()), // استبدليها بصفحة التسجيل
                                    );
                                  },
                                  child: Text("إنشاء حساب"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // إغلاق الـ Alert بدون أي انتقال
                                  },
                                  child: Text("إلغاء"),
                                ),
                              ],
                            ),
                          );
                          break;
                        case 1:

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (_) => UserProfileCubit(),
                                child: const HomeScreen(),
                              ),
                            ),
                          );
                          break;
                        case 2:

                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ApplicationInfo()));

                          break;

                        case 0:

                          Navigator.push(context, MaterialPageRoute(builder: (context) => const FirstHomePage()));

                          break;
                      }
                    },
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 10.h,),
                        Container(
                          width: 343.w,
                          height:145.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: images.length,
                            itemBuilder: (context, index) {
                              return Image.asset(
                                images[index],
                                fit: BoxFit.fill,
                                width: 343.w,
                                height:145.h,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFAFDCFF)),
                            height: 40.h,
                            width: 310.w,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                labelText: "البحث",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),

                        // List of doctors
                        BlocBuilder<GetSpecialistCubit, GetSpecialistState>(
                          builder: (context, state) {
                            if (state is SpecialistLoading) {
                              return CircularProgressIndicator(); // Show loading indicator
                            } else if (state is SpecialistFailure) {
                              return Text(state.errMessage); // Display error message
                            } else if (state is SpecialistSuccess) {
                              return Container(
                                height: screenHeight*0.57.h,
                                width: 344.w,
                                child: ListView.builder(
                                  itemCount: state.specialists.length,
                                  itemBuilder: (context, index) {
                                    return DoctorCard(specialistModel: state.specialists[index]);
                                  },
                                ),
                              );
                            } else {
                              return Center(child: Text('No specialists found.'));
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
                  appBar: CustomAppBar(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  backgroundColor: Colors.white,
                  bottomNavigationBar: const CustomBottomNavBar(
                    currentIndex: 0,
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 10.h,),
                        Container(
                          width: 343.w,
                          height:145.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: images.length,
                            itemBuilder: (context, index) {
                              return Image.asset(
                                images[index],
                                fit: BoxFit.fill,
                                width: 343.w,
                                height:145.h,
                              );
                            },
                          ),
                        ),
                         SizedBox(
                          height: 10.h,
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFAFDCFF)),
                            height: 40.h,
                            width: 310.w,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                labelText: "البحث",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ),
                         SizedBox(
                          height: 10.h,
                        ),

                        // List of doctors
                        BlocBuilder<GetSpecialistCubit, GetSpecialistState>(
                          builder: (context, state) {
                            if (state is SpecialistLoading) {
                              return CircularProgressIndicator(); // Show loading indicator
                            } else if (state is SpecialistFailure) {
                              return Text(state.errMessage); // Display error message
                            } else if (state is SpecialistSuccess) {
                              return Container(
                                height: screenHeight*0.57.h,
                                width: 344.w,
                                child: ListView.builder(
                                  itemCount: state.specialists.length,
                                  itemBuilder: (context, index) {
                                    return DoctorCard(specialistModel: state.specialists[index]);
                                  },
                                ),
                              );
                            } else {
                              return Center(child: Text('No specialists found.'));
                            }
                          },
                        )

                      ],
                    ),
                  ),
                );
              }
              return Container(); // Default return in case no state matches
            }
    )
    );
  }
}
