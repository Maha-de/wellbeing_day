import 'dart:async';
import 'package:doctor/screens/home_second_screen.dart';
import 'package:doctor/screens/problem_solving_screen.dart';
import 'package:doctor/screens/psychological_disorders_screen.dart';
import 'package:doctor/screens/psychological_prevention_screen.dart';
import 'package:doctor/screens/rehabilitation_screen.dart';
import 'package:doctor/screens/specialist/specialist_home_screen.dart';
import 'package:doctor/screens/therapeutic_programs_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import '../../cubit/update_user_cubit/update_user_cubit.dart';
import '../../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../../cubit/user_profile_cubit/user_profile_state.dart';
import '../../models/user_profile_model.dart';
import '../../widgets/beneficiary_card.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_bottom_nav_bar_specialist.dart';
import '../childrens_disorder_screen.dart';
import '../free_consultation_screen.dart';
import '../home_third_screen.dart';
import '../homescreen.dart';
import '../instant_session_screen.dart';


class SpecialistSecondHomeScreen extends StatefulWidget {
  const SpecialistSecondHomeScreen({super.key});

  @override
  State<SpecialistSecondHomeScreen> createState() => _SpecialistSecondHomeScreenState();
}

class _SpecialistSecondHomeScreenState extends State<SpecialistSecondHomeScreen> {

  int selectedIndex = 0;

  final List<String> images = [
    'assets/images/family.png',
    'assets/images/familyy.png',
    'assets/images/familyyy.png',
  ];
  PageController _pageController = PageController();
  late Timer _timer;
  late UserProfileCubit userProfileCubit;
  bool isFirstButtonActive = false;
  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    _loadUserProfile();
    _startAutoPageSwitch();
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
          create: (_) => userProfileCubit,
          child: BlocBuilder<UserProfileCubit, UserProfileState>(
            builder: (context, state) {
              if (state is UserProfileLoading) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              } else if (state is UserProfileFailure) {
                return Center(child: Text("Error loading profile: ${state.error}"));
              } else if (state is UserProfileSuccess) {
                UserProfileModel userProfile = state.userProfile;
                return Scaffold(
                  appBar: CustomAppBar(
                    userProfile: userProfile,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  bottomNavigationBar:const SpecialistCustomBottomNavBar(currentIndex: 0,),
                  body: Column(
                    children: [
                      SizedBox(height: 5),

                      // Image Slider
                      SizedBox(
                        height: screenHeight * 0.18,
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
                      SizedBox(height: 5),

                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isFirstButtonActive = true;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                                      BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                                      BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                                    ],
                                    child: const SpecialistHomeScreen(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.46,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: isFirstButtonActive ? const Color(0xff1F78BC) : Colors.grey,
                              ),
                              child: Center(
                                child: Text(
                                  "جلسات فورية",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isFirstButtonActive = false;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                                      BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                                      BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                                    ],
                                    child: const SpecialistSecondHomeScreen(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: isFirstButtonActive ? Colors.grey : const Color(0xff1F78BC),
                              ),
                              child: Center(
                                child: Text(
                                  "إستشارات مجانيه",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height:5),
                      // Expanded(
                      //   child: Container(
                      //
                      //     child: ListView.separated(
                      //         padding: EdgeInsets.only(top: 45),
                      //         itemBuilder: (context,index)
                      //         {
                      //           return BeneficiaryCard();
                      //         }, separatorBuilder: (context,index){
                      //       return SizedBox(height: 50,);
                      //     }, itemCount: 2),
                      //   ),
                      // )

                    ],
                  ),
                );
              }
              return Container(); // Default return in case no state matches
            },
          )),
    );
  }
}

