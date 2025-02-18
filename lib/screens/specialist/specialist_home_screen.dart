import 'dart:async';
import 'package:doctor/screens/specialist/specialist_second_home_screen.dart';
import 'package:doctor/screens/specialist/specialist_work_hours_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import '../../cubit/doctor_details_cubit/doctor_profile_cubit.dart';
import '../../cubit/doctor_details_cubit/doctor_profile_state.dart';
import '../../cubit/get_doctor_sessions_types_cubit/doctor_session_types_cubit.dart';
import '../../cubit/get_doctor_sessions_types_cubit/doctor_session_types_state.dart';
import '../../cubit/update_user_cubit/update_user_cubit.dart';
import '../../models/Doctor_id_model.dart';
import '../../widgets/beneficiary_card_home.dart';
import '../../widgets/custom_app_bar_specialist.dart';
import '../../widgets/custom_bottom_nav_bar_specialist.dart';



class SpecialistHomeScreen extends StatefulWidget {
  const SpecialistHomeScreen({super.key});

  @override
  State<SpecialistHomeScreen> createState() => _SpecialistHomeScreenState();
}

class _SpecialistHomeScreenState extends State<SpecialistHomeScreen> {

  int selectedIndex = 0;
int listLength=0;
  final List<String> images = [
    'assets/images/family.png',
    'assets/images/familyy.png',
    'assets/images/familyyy.png',
  ];
  PageController _pageController = PageController();
  late Timer _timer;
  late DoctorProfileCubit userProfileCubit;
  late DoctorSessionTypesCubit sessionTypesCubit;
  bool isFirstButtonActive = true;
  bool _hasShownDialog = false; // Flag to track if the dialog has been shown


  @override
  void initState() {
    super.initState();
    // Check if the dialog has been shown before
    _checkIfDialogShown();
    userProfileCubit = BlocProvider.of<DoctorProfileCubit>(context);
    sessionTypesCubit = BlocProvider.of<DoctorSessionTypesCubit>(context);
    _loadUserProfile();
    _startAutoPageSwitch();
  }

  Future<void> _checkIfDialogShown() async {
    final prefs = await SharedPreferences.getInstance();
    _hasShownDialog = prefs.getBool('hasShownDialog') ?? false;

    // Check if the user navigated from the login page
    bool fromLoginPage = ModalRoute.of(context)?.settings.arguments == 'fromSignup';

    if (!_hasShownDialog && fromLoginPage) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showPopup(context);
      });

      // Save that the popup has been shown
      prefs.setBool('hasShownDialog', true);
    }
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('doctorId') ?? "";
    print(id);
    userProfileCubit.getUserProfile(context, id);
    sessionTypesCubit.getDoctorSessions(context, id);
  }
  void _startAutoPageSwitch() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {  // ✅ تأكد من وجود عملاء للـ PageController
        if (_pageController.page?.toInt() == images.length - 1) {
          _pageController.jumpToPage(0);
        } else {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
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
                return Scaffold(body: Center(child: Text("Error loading profile: ${state.error}")));
              } else if (state is DoctorProfileSuccess) {
                Specialist? userProfile = state.doctorProfile.specialist;
                return Scaffold(
                  appBar: CustomAppBarSpecialist(
                    userProfile: userProfile,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  bottomNavigationBar:const SpecialistCustomBottomNavBar(currentIndex: 0,),
                  body: Column(
                    children: [
                      SizedBox(height: 5.h),

                      // Image Slider
                      SizedBox(
                        height: 145.h,
                        width: 343.w,
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
                                    BlocProvider<DoctorProfileCubit>(create: (_) => DoctorProfileCubit()),
                                    BlocProvider<DoctorSessionTypesCubit>(create: (_) => DoctorSessionTypesCubit()),
                                    BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
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
                              color: isFirstButtonActive ? const Color(0xff1F78BC) : Colors.grey,
                            ),
                            child: Center(
                              child: Text(
                                "instantSessions".tr(),
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
                          onTap: () {
                            setState(() {
                              isFirstButtonActive = false;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider<DoctorProfileCubit>(create: (_) => DoctorProfileCubit()),
                                    BlocProvider<DoctorSessionTypesCubit>(create: (_) => DoctorSessionTypesCubit()),
                                    BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
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
                              color: isFirstButtonActive ? Colors.grey : const Color(0xff1F78BC),
                            ),
                            child: Center(
                              child: Text(
                                "freeConsultant".tr(),
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
                      SizedBox(height:50.h),
                      BlocBuilder<DoctorSessionTypesCubit, DoctorSessionTypesState>(
                        builder: (context, state) {
                          if (state is DoctorSessionTypesLoading) {
                            return CircularProgressIndicator(); // Show loading indicator
                          } else if (state is DoctorSessionTypesFailure) {
                            return Text(state.error); // Display error message
                          } else if (state is DoctorSessionTypesSuccess) {
                            return Center(
                              child: Container(
                                height: 250.h,
                                width: 344,
                                child: state.session.instantSessions?.length == 0?
                                Center(
                                  child: Image(image:AssetImage("assets/images/image.png"),fit: BoxFit.fill,),
                                ):
                                ListView.separated(

                                    itemBuilder: (context,index)
                                    {
                                      return BeneficiaryCardHome(session: state.session.instantSessions?[index].beneficiary,);
                                    }, separatorBuilder: (context,index){
                                  return SizedBox(height: 50.h,);
                                }, itemCount: state.session.instantSessions?.length??0),
                              ),
                            );
                          } else {
                            return Center(child: Text('noSpecialistsFound'.tr()));
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

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('completeDetails'.tr()),
          actions: <Widget>[
            Center(
              child: Container(
                width: 100.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: const Color(0xff19649E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF19649E),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text('go'.tr(),
                    style:  TextStyle(
                      color: Colors.white,
                      fontSize: 20.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    // Navigate to the next page when the button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider<DoctorProfileCubit>(create: (_) => DoctorProfileCubit()),
                            BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                            BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                            BlocProvider<DoctorSessionTypesCubit>(create: (_) => DoctorSessionTypesCubit()),
                          ],
                          child: const SpecialistWorkHoursScreen(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

          ],
        );
      },
    );
  }

}



