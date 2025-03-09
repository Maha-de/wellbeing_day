import 'dart:async';
import 'package:doctor/models/Doctor_id_model.dart';
import 'package:doctor/screens/home_second_screen.dart';
import 'package:doctor/screens/problem_solving_screen.dart';
import 'package:doctor/screens/psychological_disorders_screen.dart';
import 'package:doctor/screens/psychological_prevention_screen.dart';
import 'package:doctor/screens/rehabilitation_screen.dart';
import 'package:doctor/screens/specialist/specialist_home_screen.dart';
import 'package:doctor/screens/therapeutic_programs_screen.dart';
import 'package:doctor/widgets/custom_app_bar_specialist.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import '../../cubit/doctor_details_cubit/doctor_profile_cubit.dart';
import '../../cubit/doctor_details_cubit/doctor_profile_state.dart';
import '../../cubit/get_all_ads/get_all_ads_cubit.dart';
import '../../cubit/get_all_ads/get_all_ads_state.dart';
import '../../cubit/get_doctor_sessions_types_cubit/doctor_session_types_cubit.dart';
import '../../cubit/get_doctor_sessions_types_cubit/doctor_session_types_state.dart';
import '../../cubit/update_user_cubit/update_user_cubit.dart';
import '../../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../../cubit/user_profile_cubit/user_profile_state.dart';
import '../../models/user_profile_model.dart';
import '../../widgets/beneficiary_card.dart';
import '../../widgets/beneficiary_card_home.dart';
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
  State<SpecialistSecondHomeScreen> createState() =>
      _SpecialistSecondHomeScreenState();
}

class _SpecialistSecondHomeScreenState
    extends State<SpecialistSecondHomeScreen> {
  int selectedIndex = 0;

  final List<String> images = [
    'assets/images/family.png',
    'assets/images/familyy.png',
    'assets/images/familyyy.png',
  ];
  PageController _pageController = PageController();
  late Timer _timer;
  late DoctorProfileCubit userProfileCubit;
  late DoctorSessionTypesCubit sessionTypesCubit;
  bool isFirstButtonActive = false;
  late GetAllAdsCubit getAllAdsCubit;
  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<DoctorProfileCubit>(context);
    sessionTypesCubit = BlocProvider.of<DoctorSessionTypesCubit>(context);
    getAllAdsCubit = BlocProvider.of<GetAllAdsCubit>(context);
    _loadUserProfile();
    _startAutoPageSwitch();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('doctorId') ?? "";
    getAllAdsCubit.fetchAllAdv();
    userProfileCubit.getUserProfile(context, id);
    sessionTypesCubit.getDoctorSessions(context, id);
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
    double screenWidth = MediaQuery.of(context).size.width.w;
    double screenHeight = MediaQuery.of(context).size.height.h;

    return WillPopScope(
      onWillPop: () async {
        // Return false to disable the back button
        return false;
      },
      child: BlocProvider(
          create: (_) => userProfileCubit,
          child: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
            builder: (context, state) {
              if (state is DoctorProfileLoading) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              } else if (state is DoctorProfileFailure) {
                return Scaffold(
                    body: Center(
                        child: Text("Error loading profile: ${state.error}")));
              } else if (state is DoctorProfileSuccess) {
                Specialist? userProfile = state.doctorProfile.specialist;
                return Scaffold(
                  appBar: CustomAppBarSpecialist(
                    userProfile: userProfile,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  bottomNavigationBar: const SpecialistCustomBottomNavBar(
                    currentIndex: 0,
                  ),
                  body: Column(
                    children: [
                      SizedBox(height: 5.h),

                      // Image Slider
                      Container(
                        height: 145.h,
                        width: 343.w,
                        child: BlocBuilder<GetAllAdsCubit, GetAllAdsState>(
                          builder: (context, state) {
                            if (state is GetAllAdsLoading) {
                              return CircularProgressIndicator(); // Show loading indicator
                            } else if (state is GetAllAdsFailure) {
                              return Text(
                                  state.errMessage); // Display error message
                            } else if (state is GetAllAdsSuccess) {
                              return PageView.builder(
                                controller: _pageController,
                                itemCount: state.adv.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          20), // تعديل الحواف
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            state.adv[index].photo ?? ""),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Center(
                                  child: Text('noSpecialistsFound'.tr()));
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 5.h),

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
                                      BlocProvider<DoctorProfileCubit>(
                                          create: (_) => DoctorProfileCubit()),
                                      BlocProvider<DoctorSessionTypesCubit>(
                                          create: (_) =>
                                              DoctorSessionTypesCubit()),
                                      BlocProvider<UpdateUserCubit>(
                                          create: (_) => UpdateUserCubit()),
                                      BlocProvider<GetAllAdsCubit>(
                                          create: (_) => GetAllAdsCubit()),
                                    ],
                                    child: const SpecialistHomeScreen(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 170.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: isFirstButtonActive
                                    ? const Color(0xff1F78BC)
                                    : Colors.grey,
                              ),
                              child: Center(
                                child: Text(
                                  "instantSessions".tr(),
                                  style: TextStyle(
                                    fontSize: 18.sp,
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
                                      BlocProvider<DoctorProfileCubit>(
                                          create: (_) => DoctorProfileCubit()),
                                      BlocProvider<DoctorSessionTypesCubit>(
                                          create: (_) =>
                                              DoctorSessionTypesCubit()),
                                      BlocProvider<UpdateUserCubit>(
                                          create: (_) => UpdateUserCubit()),
                                      BlocProvider<GetAllAdsCubit>(
                                          create: (_) => GetAllAdsCubit()),
                                    ],
                                    child: const SpecialistSecondHomeScreen(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 170.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: isFirstButtonActive
                                    ? Colors.grey
                                    : const Color(0xff1F78BC),
                              ),
                              child: Center(
                                child: Text(
                                  "freeConsultant".tr(),
                                  style: TextStyle(
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
                      SizedBox(height: 50.h),
                      BlocBuilder<DoctorSessionTypesCubit,
                          DoctorSessionTypesState>(
                        builder: (context, state) {
                          if (state is DoctorSessionTypesLoading) {
                            return CircularProgressIndicator(); // Show loading indicator
                          } else if (state is DoctorSessionTypesFailure) {
                            return Text(state.error); // Display error message
                          } else if (state is DoctorSessionTypesSuccess) {
                            return Center(
                              child: Container(
                                height: 250.h,
                                width: 344.w,
                                child:
                                    state.session.freeConsultations?.length == 0
                                        ? Center(
                                            child: Image(
                                              image: AssetImage(
                                                  "assets/images/image.png"),
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        : ListView.separated(
                                            itemBuilder: (context, index) {
                                              return BeneficiaryCardHome(
                                                session: state
                                                    .session
                                                    .freeConsultations?[index]
                                                    .beneficiary,
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return SizedBox(
                                                height: 50.h,
                                              );
                                            },
                                            itemCount: state
                                                    .session
                                                    .freeConsultations
                                                    ?.length ??
                                                0),
                              ),
                            );
                          } else {
                            return Center(
                                child: Text('noSpecialistsFound'.tr()));
                          }
                        },
                      )
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
