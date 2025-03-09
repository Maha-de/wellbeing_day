import 'dart:async';

import 'package:doctor/models/Doctor_id_model.dart';
import 'package:doctor/screens/specialist/specialist_home_screen.dart';
import 'package:doctor/screens/specialist/specialist_second_home_screen.dart';
import 'package:doctor/widgets/custom_app_bar_specialist.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import '../../cubit/doctor_details_cubit/doctor_profile_cubit.dart';
import '../../cubit/doctor_details_cubit/doctor_profile_state.dart';
import '../../cubit/get_doctor_sessions_cubit/doctor_session_state.dart';
import '../../cubit/get_doctor_sessions_types_cubit/doctor_session_types_cubit.dart';
import '../../cubit/get_doctor_sessions_types_cubit/doctor_session_types_state.dart';
import '../../cubit/update_user_cubit/update_user_cubit.dart';
import '../../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../../cubit/user_profile_cubit/user_profile_state.dart';
import '../../models/user_profile_model.dart';
import '../../widgets/beneficiary_card.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_nav_bar_specialist.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  int _currentPage = 0;
  final int totalPages = 2;
  int listLength = 2;

  late DoctorProfileCubit userProfileCubit;
  late DoctorSessionTypesCubit doctorSessionCubit;

  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<DoctorProfileCubit>(context);
    doctorSessionCubit = BlocProvider.of<DoctorSessionTypesCubit>(context);
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('doctorId') ?? "";
    userProfileCubit.getUserProfile(context, id);
    doctorSessionCubit.getDoctorSessions(context,id);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isEnglish = Localizations.localeOf(context).languageCode == 'en';
    return BlocProvider(
        create: (_) => userProfileCubit,
        child: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
            builder: (context, state) {
          if (state is DoctorProfileLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is DoctorProfileFailure) {
            return Center(child: Text("Error loading profile: ${state.error}"));
          } else if (state is DoctorProfileSuccess) {
            DoctorByIdModel userProfile = state.doctorProfile;

            return Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: const SpecialistCustomBottomNavBar(
                currentIndex: 1,
              ),
              appBar: CustomAppBarSpecialist(
                  userProfile: userProfile.specialist,
                  screenWidth: screenWidth,
                  screenHeight: screenHeight),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 50.h,
                        width: 250.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Color(0xFF19649E),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Center(
                            child: Text(
                          "myAppointments".tr(),
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 5),
                      child: Column(
                        children: [
                          NavigationBar(
                            backgroundColor: Colors.transparent,
                            height: 50.h,
                            destinations: [
                              TextButton(
                                onPressed: () {
                                  _onItemTapped(1);
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: _currentPage == 1
                                      ? Color(0xFF19649E)
                                      : Colors.grey.shade300,
                                ),
                                child: Text(
                                  "completedSessions".tr(),
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  _onItemTapped(0);
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: _currentPage == 0
                                      ? Color(0xFF19649E)
                                      : Colors.grey.shade300,
                                ),
                                child: Text(
                                  "nextSessions".tr(),
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                            // selectedIndex: _currentPage,
                            // onDestinationSelected: _onItemTapped,
                          ),
                        ],
                      ),
                    ),
                    <Widget>[
                      SizedBox(height: 5.h),
                      BlocBuilder<DoctorSessionTypesCubit, DoctorSessionTypesState>(
                        builder: (context, state) {
                          if (state is DoctorSessionTypesLoading) {
                            return CircularProgressIndicator(); // Show loading indicator
                          } else if (state is DoctorSessionTypesFailure) {
                            return Text(state.error); // Display error message
                          } else if (state is DoctorSessionTypesSuccess) {
                            return Container(
                              height: 400,
                              width: screenWidth,
                              child:
                                  state.session.scheduledSessions?.length == 0
                                      ? Center(
                                          child: Image(
                                            image: AssetImage(
                                                "assets/images/image.png"),
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      : ListView.separated(
                                          padding: EdgeInsets.only(top: 45),
                                          itemBuilder: (context, index) {
                                            return BeneficiaryCard(
                                              session: state
                                                  .session
                                                  .scheduledSessions?[index]
                                                  .beneficiary?[0],
                                              scheduledSessions: state.session
                                                  .scheduledSessions?[index],
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return SizedBox(
                                              height: 50.h,
                                            );
                                          },
                                          itemCount: state.session
                                                  .scheduledSessions?.length ??
                                              0),
                            );
                          } else {
                            return Center(
                                child: Text('noSpecialistsFound'.tr()));
                          }
                        },
                      ),
                      BlocBuilder<DoctorSessionTypesCubit, DoctorSessionTypesState>(
                        builder: (context, state) {
                          if (state is DoctorSessionTypesLoading) {
                            return CircularProgressIndicator(); // Show loading indicator
                          } else if (state is DoctorSessionTypesFailure) {
                            return Text(state.error); // Display error message
                          } else if (state is DoctorSessionTypesSuccess) {
                            return Container(
                              height: 400.h,
                              width: screenWidth,
                              child:
                                  state.session.completedSessions?.length == 0
                                      ? Center(
                                          child: Image(
                                            image: AssetImage(
                                                "assets/images/image.png"),
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      : ListView.separated(
                                          padding: EdgeInsets.only(top: 45),
                                          itemBuilder: (context, index) {
                                            return BeneficiaryCard(
                                              session: state
                                                  .session
                                                  .completedSessions?[index]
                                                  .beneficiary?[0],
                                              completedSessions: state.session
                                                  .completedSessions?[index],
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return SizedBox(
                                              height: 50.h,
                                            );
                                          },
                                          itemCount: state.session
                                                  .scheduledSessions?.length ??
                                              0),
                            );
                          } else {
                            return Center(
                                child: Text('noSpecialistsFound'.tr()));
                          }
                        },
                      )
                    ][_currentPage],
                  ],
                ),
              ),
            );
          }
          return Container(); // Default return in case no state matches
        }));
  }
}
