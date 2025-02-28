import 'dart:async';
import 'package:doctor/screens/home_second_screen.dart';
import 'package:doctor/screens/homescreen.dart';
import 'package:doctor/screens/sign_up_as_client.dart';
import 'package:doctor/screens/skill_development/achieving_balance.dart';
import 'package:doctor/screens/skill_development/achieving_goals.dart';
import 'package:doctor/screens/skill_development/achieving_success.dart';
import 'package:doctor/screens/skill_development/dialectical_strategies.dart';
import 'package:doctor/screens/skill_development/effective_relationships.dart';
import 'package:doctor/screens/skill_development/emotional_control.dart';
import 'package:doctor/screens/skill_development/improving_trust.dart';
import 'package:doctor/screens/skill_development/relaxation.dart';
import 'package:doctor/screens/skill_development/stress_management.dart';
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
import '../widgets/skill_development_widget.dart';
import 'applicationInfo.dart';
import 'first_home_page.dart';
import 'free_consultation_screen.dart';
import 'instant_session_screen.dart';

class HomeThirdScreen extends StatefulWidget {
  const HomeThirdScreen({Key? key}) : super(key: key);

  @override
  State<HomeThirdScreen> createState() => _HomeThirdScreenState();
}

class _HomeThirdScreenState extends State<HomeThirdScreen> {
  List<String> categories = [
    "mentalHealth".tr(),
    "physicalHealth".tr(),
    "skillDevelopment".tr(),
    "magazine".tr()
  ];
  int currentIndex=1;
  int selectedIndex = 2;

  final List<String> images = [
    'assets/images/family.png',
    'assets/images/familyy.png',
    'assets/images/familyyy.png',
  ];
  PageController _pageController = PageController();
  late Timer _timer;
  late UserProfileCubit userProfileCubit;

  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
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
          create: (_) => userProfileCubit,  // Use the same cubit instance
      child: BlocBuilder<UserProfileCubit, UserProfileState>(
      builder: (context, state) {
      if (state is UserProfileLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator(),));
      } else if (state is UserProfileFailure) {

        return Scaffold(
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


              SizedBox(height: screenHeight * 0.01.h),

              // Category List
              SizedBox(
                height: 32.h,
                child: ListView.separated(
                  padding: EdgeInsets.only(left: 5,right: 5),
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return SizedBox(width: screenWidth * 0.02);
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
                        width: screenWidth * 0.35,
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
              SizedBox(height: screenHeight * 0.01.h),
              Container(
                height: screenHeight * 0.18.h,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Image.asset(images[index], fit: BoxFit.fill);
                  },
                ),
              ),

              SizedBox(height: screenHeight * 0.01.h),
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
                      width: screenWidth * 0.46,
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
                      width: screenWidth * 0.45,
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
              SizedBox(height: screenHeight * 0.01.h),
              Center(
                child: Container(
                  width: 354,
                  height: 268,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          SkillDevelopmentWidget(
                            text: "emotionalControl".tr(),
                            navigateToPage: const EmotionalControl(category: 'skillDevelopment', subCategory: 'ضبط المشاعر',),
                          ),

                          SkillDevelopmentWidget(
                            text: "stressManagement".tr(),
                            navigateToPage: const StressManagement(category: 'skillDevelopment', subCategory: 'تحمل الضغوط',),
                          ),

                          SkillDevelopmentWidget(
                            text: "relax".tr(),
                            navigateToPage: const Relaxation(category: 'skillDevelopment', subCategory: 'الاسترخاء',),
                          ),

                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          SkillDevelopmentWidget(
                            text: "achievingBalance".tr(),
                            navigateToPage: const AchievingBalance(category: 'skillDevelopment', subCategory: 'تحقيق التوازن',),
                          ),

                          SkillDevelopmentWidget(
                            text: "effectiveRelationships".tr(),
                            navigateToPage: const EffectiveRelationships(category: 'skillDevelopment', subCategory: 'اضطراب الصدمة',),
                          ),

                          SkillDevelopmentWidget(
                            text: "dialecticalStrategies".tr(),
                            navigateToPage: const DialecticalStrategies(category: 'skillDevelopment', subCategory: 'استراجيات جدلية حل',),
                          ),
                        ],
                      ),
                      SizedBox(height:20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          SkillDevelopmentWidget(
                            text: "achievingSuccess".tr(),
                            navigateToPage: const AchievingSuccess(category: 'skillDevelopment', subCategory: 'تحقيق النجاح',),
                          ),

                          SkillDevelopmentWidget(
                            text: "achievingGoals".tr(),
                            navigateToPage: const AchievingGoals(category: 'skillDevelopment', subCategory: 'تحقيق الأهداف',),
                          ),

                          SkillDevelopmentWidget(
                            text: "improvingTrust".tr(),
                            navigateToPage: const ImprovingTrust(category: 'skillDevelopment', subCategory: 'تحسين الثقة',),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),


            ],
          ),
        );
      } else if (state is UserProfileSuccess) {
      // Once the profile is loaded, show the actual UI
      UserProfileModel userProfile = state.userProfile;
            return Scaffold(appBar: CustomAppBar(
              userProfile: userProfile,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
              bottomNavigationBar: CustomBottomNavBar(currentIndex: 1,),
              body: Column(
                children: [


                  SizedBox(height: 10.h),

                  // Category List
                  SizedBox(
                    height: 32.h,
                    child: ListView.separated(
                      padding: EdgeInsets.only(left: 5,right: 5),
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) {
                        return SizedBox(width: screenWidth * 0.02);
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
                            width: screenWidth * 0.35,
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
                  SizedBox(height:10.h),
                  Container(
                    height: screenHeight * 0.18.h,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Image.asset(images[index], fit: BoxFit.fill);
                      },
                    ),
                  ),
      
                  SizedBox(height: 15.h),
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
                          width: screenWidth * 0.46,
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
                          width: screenWidth * 0.45,
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
                  SizedBox(height: 15.h),
                  Center(
                    child: Container(
                      width: 354,
                      height: 268,
                      child: Column(
                        children: [
                          Row(

                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              SkillDevelopmentWidget(
                                  text: "emotionalControl".tr(),
                                navigateToPage: const EmotionalControl(category: 'skillDevelopment', subCategory: 'ضبط المشاعر',),
                              ),

                              SkillDevelopmentWidget(
                                text: "stressManagement".tr(),
                                navigateToPage: const StressManagement(category: 'skillDevelopment', subCategory: 'تحمل الضغوط',),
                              ),

                              SkillDevelopmentWidget(
                                text: "relax".tr(),
                                navigateToPage: const Relaxation(category: 'skillDevelopment', subCategory: 'الاسترخاء',),
                              ),

                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              SkillDevelopmentWidget(
                                text: "achievingBalance".tr(),
                                navigateToPage: const AchievingBalance(category: 'skillDevelopment', subCategory: 'تحقيق التوازن',),
                              ),

                              SkillDevelopmentWidget(
                                text: "effectiveRelationships".tr(),
                                navigateToPage: const EffectiveRelationships(category: 'skillDevelopment', subCategory: 'اضطراب الصدمة',),
                              ),

                              SkillDevelopmentWidget(
                                text: "dialecticalStrategies".tr(),
                                navigateToPage: const DialecticalStrategies(category: 'skillDevelopment', subCategory: 'استراجيات جدلية حل',),
                              ),

                            ],
                          ),
                          SizedBox(height:20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              SkillDevelopmentWidget(
                                text: "achievingSuccess".tr(),
                                navigateToPage: const AchievingSuccess(category: 'skillDevelopment', subCategory: 'تحقيق النجاح',),
                              ),

                              SkillDevelopmentWidget(
                                text: "achievingGoals".tr(),
                                navigateToPage: const AchievingGoals(category: 'skillDevelopment', subCategory: 'تحقيق الأهداف',),
                              ),

                              SkillDevelopmentWidget(
                                text: "improvingTrust".tr(),
                                navigateToPage: const ImprovingTrust(category: 'skillDevelopment', subCategory: 'تحسين الثقة',),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
      
      
                ],
              ),
            );
          }
          return Container(); // Default return in case no state matches
        },
      )
      ),
    );
  }
}
