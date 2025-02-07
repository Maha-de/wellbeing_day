import 'dart:async';
import 'package:doctor/screens/sign_up_as_client.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import '../cubit/update_user_cubit/update_user_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../make_email/login.dart';
import '../models/user_profile_model.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'applicationInfo.dart';
import 'client_profile_screen.dart';
import 'first_home_page.dart';
import 'free_consultation_screen.dart';
import 'home_third_screen.dart';
import 'homescreen.dart';
import 'instant_session_screen.dart';

class HomeSecondScreen extends StatefulWidget {
  const HomeSecondScreen({super.key});

  @override
  State<HomeSecondScreen> createState() => _HomeSecondScreenState();
}

class _HomeSecondScreenState extends State<HomeSecondScreen>
    with SingleTickerProviderStateMixin {
  List<String> categories = [
    "mentalHealth".tr(),
    "physicalHealth".tr(),
    "skillDevelopment".tr(),
    "magazine".tr()
  ];
  int currentIndex=1;
  int selectedIndex = 1; // Changed from RxInt to int

  final List<String> images = [
    'assets/images/family.png',
    'assets/images/familyy.png',
    'assets/images/familyyy.png',
  ];
  PageController _pageController = PageController();
  late Timer _timer;
  late UserProfileCubit userProfileCubit;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _loadUserProfile();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoPageSwitch();
    });
  }


  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";
    userProfileCubit.getUserProfile(context, id);
  }

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

  @override
  void dispose() {
    _timer.cancel();
    _fadeController.dispose();
    super.dispose();
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
              _fadeController.forward();
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (state is UserProfileFailure) {
              _fadeController.forward();
              return FadeTransition(
                opacity: _fadeAnimation,
                child: Scaffold(
                  appBar: CustomAppBar(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
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
                  body: Column(
                    children: [
                      // Top Container

                      SizedBox(height: screenHeight * 0.01.h),

                      // Category List
                      SizedBox(
                        height: 32.h,
                        child: ListView.separated(
                          padding: EdgeInsets.only(left: 5,right: 5),
                          itemCount: categories.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return SizedBox(width: screenWidth * 0.02.w);
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (index == categories.length - 1) {
                                    // Do nothing if it's the last item
                                    selectedIndex = selectedIndex; // Keep the current index
                                  } else {
                                    selectedIndex = index; // Update the selected index
                                  }
                                });

                                // Navigate only if it's not the last item
                                if (index != categories.length - 1) {
                                  Widget page;

                                  if (selectedIndex == 0) {
                                    page = const HomeScreen();
                                  } else if (selectedIndex == 1) {
                                    page = const HomeSecondScreen();
                                  } else if (selectedIndex == 2) {
                                    page = const HomeThirdScreen();
                                  } else {
                                    page = const HomeScreen();
                                  }

                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) =>
                                          BlocProvider(
                                            create: (_) => UserProfileCubit(),
                                            child: page,
                                          ),
                                      transitionDuration: const Duration(milliseconds: 1),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                width: screenWidth * 0.35.w,
                                height: 32.h,
                                decoration: BoxDecoration(
                                  color: index == categories.length - 1
                                      ? const Color(0xffAFDCFF) // Always blue for the last item
                                      : (selectedIndex == index ? const Color(0xff19649E) :
                                  const Color(0xffD5D5D5)),

                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    categories[index],
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02.h),
                      // Image Carousel
                      Container(
                        height: screenHeight * 0.18.h,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              images[index],
                              fit: BoxFit.fill,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05.h),
                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                                      BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                                      BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                                    ],
                                    child: const FreeConsultationScreen(),
                                  ),

                                ),
                                    (route) => false,
                              );
                            },
                            child: Container(
                              width: screenWidth * 0.46.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xff1F78BC),
                              ),
                              child: Center(
                                child: Text(
                                  "consultation".tr(),
                                  style:  TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                                      BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                                      BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                                    ],
                                    child: const InstantSessionScreen(),
                                  ),

                                ),
                                    (route) => false,
                              );
                            },
                            child: Container(
                              width: screenWidth * 0.45.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xff1F78BC),
                              ),
                              child: Center(
                                child: Text(
                                  "instantSession".tr(),
                                  style:  TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.1.h),
                      // Health Services
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3.w,
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
                                    "HealthCare".tr(),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3.w,
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
                                    "SportsSystem".tr(),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3.w,
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
                                    "diet".tr(),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.03.h),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3.w,
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
                                "examinations".tr(),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is UserProfileSuccess) {
              UserProfileModel userProfile = state.userProfile;
              _fadeController.forward();
              return FadeTransition(
                opacity: _fadeAnimation,
                child: Scaffold(
                  appBar: CustomAppBar(
                    userProfile: userProfile,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  bottomNavigationBar: CustomBottomNavBar(currentIndex: 1,),
                  body: Column(
                    children: [
                      // Top Container

                      SizedBox(height: screenHeight * 0.01.h),

                      // Category List
                      SizedBox(
                        height: 32.h,
                        child: ListView.separated(
                          padding: EdgeInsets.only(left: 5,right: 5),
                          itemCount: categories.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return SizedBox(width: screenWidth * 0.02.w);
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (index == categories.length - 1) {
                                    // Do nothing if it's the last item
                                    selectedIndex = selectedIndex; // Keep the current index
                                  } else {
                                    selectedIndex = index; // Update the selected index
                                  }
                                });

                                // Navigate only if it's not the last item
                                if (index != categories.length - 1) {
                                  Widget page;

                                  if (selectedIndex == 0) {
                                    page = const HomeScreen();
                                  } else if (selectedIndex == 1) {
                                    page = const HomeSecondScreen();
                                  } else if (selectedIndex == 2) {
                                    page = const HomeThirdScreen();
                                  } else {
                                    page = const HomeScreen();
                                  }

                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) =>
                                          BlocProvider(
                                            create: (_) => UserProfileCubit(),
                                            child: page,
                                          ),
                                      transitionDuration: const Duration(milliseconds: 1),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                width: screenWidth * 0.35.w,
                                height: 32.h,
                                decoration: BoxDecoration(
                                  color: index == categories.length - 1
                                      ? const Color(0xffAFDCFF) // Always blue for the last item
                                      : (selectedIndex == index ? const Color(0xff19649E) :
                                  const Color(0xffD5D5D5)),

                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    categories[index],
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02.h),
                      // Image Carousel
                      Container(
                        height: screenHeight * 0.18.h,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              images[index],
                              fit: BoxFit.fill,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05.h),
                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                                      BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                                      BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                                    ],
                                    child: const FreeConsultationScreen(),
                                  ),

                                ),
                                    (route) => false,
                              );
                            },
                            child: Container(
                              width: screenWidth * 0.46.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xff1F78BC),
                              ),
                              child: Center(
                                child: Text(
                                  "consultation".tr(),
                                  style:  TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                                      BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                                      BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                                    ],
                                    child: const InstantSessionScreen(),
                                  ),

                                ),
                                    (route) => false,
                              );
                            },
                            child: Container(
                              width: screenWidth * 0.45.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xff1F78BC),
                              ),
                              child: Center(
                                child: Text(
                                  "instantSession".tr(),
                                  style:  TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.1.h),
                      // Health Services
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                      width: MediaQuery.of(context).size.width * 0.3.w,
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
                                    "HealthCare".tr(),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3.w,
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
                                    "SportsSystem".tr(),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3.w,
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
                                    "diet".tr(),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.03.h),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3.w,
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
                                "examinations".tr(),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
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
            return Container(); // Default return in case no state matches
          },
        ),
      ),
    );
  }
}