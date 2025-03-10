import 'package:doctor/cubit/get_session_by_id_cubit/get_session_by_id_cubit.dart';
import 'package:doctor/screens/specialist/send_meeting_screen.dart';
import 'package:doctor/widgets/custom_app_bar_specialist.dart';
import 'package:doctor/widgets/custom_bottom_nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../cubit/doctor_details_cubit/doctor_profile_cubit.dart';
import '../../cubit/doctor_details_cubit/doctor_profile_state.dart';
import '../../cubit/get_session_by_id_cubit/get_session_by_id_state.dart';
import '../../cubit/send_notification_cubit/send_notification_cubit.dart';
import '../../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../../cubit/user_profile_cubit/user_profile_state.dart';
import '../../models/get_session_by_id_model.dart';
import '../../models/user_profile_model.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_nav_bar_specialist.dart';

class SpecialistFreeConsultationScreen extends StatefulWidget {

  final String id;
  const SpecialistFreeConsultationScreen({super.key, required this.id});

  @override
  State<SpecialistFreeConsultationScreen> createState() =>
      _SpecialistFreeConsultationScreenState();
}

class _SpecialistFreeConsultationScreenState
    extends State<SpecialistFreeConsultationScreen> {
  late GetSessionByIdCubit userProfileCubit;
  late DoctorProfileCubit doctorProfileCubit;

  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<GetSessionByIdCubit>(context);
    doctorProfileCubit= BlocProvider.of<DoctorProfileCubit>(context);
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
String? id=prefs.getString("doctorId");
doctorProfileCubit.getUserProfile(context, id??"");
    userProfileCubit.getDoctorSessionsTypes(context, widget.id);
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
          create: (_) => doctorProfileCubit,
          child: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
            builder: (context, state) {
              if (state is DoctorProfileLoading) {
                return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ));
              } else if (state is DoctorProfileFailure) {
                return Center(
                    child: Text("Error loading profile: ${state.error}"));
              } else if (state is DoctorProfileSuccess) {
                // Once the profile is loaded, show the actual UI

                return Scaffold(
                  bottomNavigationBar:
                      SpecialistCustomBottomNavBar(currentIndex: 0),
                  appBar: CustomAppBarSpecialist(
                    userProfile: state.doctorProfile.specialist,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  body: SingleChildScrollView(
                    child:  BlocBuilder<GetSessionByIdCubit, GetSessionByIdState>(
                      builder: (context, state) {
                        if (state is GetSessionByIdLoading) {
                          return CircularProgressIndicator(); // Show loading indicator
                        } else if (state is GetSessionByIdFailure) {
                          return Text(state.error); // Display error message
                        } else if (state is GetSessionByIdSuccess) {
                          GetSessionByIdModel? session=state.session;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0, top: 15),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 15.0),
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
                                            "consultation".tr(),
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
                                          "omar".tr(),
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff19649E)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    Container(
                                      width: 343.w,
                                      height: 143.h,
                                      child: TextFormField(
                                        textAlign: TextAlign.right,
                                        decoration: InputDecoration(
                                          hintText:session.session?.description??"",
                                          hintStyle: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
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
                                      width: screenWidth * 0.9,
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.circle,
                                                size: 10, color: Colors.black),
                                            SizedBox(width: 5.w),
                                            Text("term1".tr()),
                                          ],
                                        ),
                                        SizedBox(height: 5.h),
                                        Row(
                                          children: [
                                            Icon(Icons.circle,
                                                size: 10, color: Colors.black),
                                            SizedBox(width: 5.w),
                                            Text("term2".tr()),
                                          ],
                                        ),
                                        SizedBox(height: 5.h),
                                        Row(
                                          children: [
                                            Icon(Icons.circle,
                                                size: 10, color: Colors.black),
                                            SizedBox(width: 5.w),
                                            Text("term3".tr()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15.h),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MultiBlocProvider(
                                        providers: [
                                          BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                                          BlocProvider<SendNotificationCubit>(create: (_) => SendNotificationCubit()),
                                        ],
                                        child: MeetingScreen(uId: session.session?.beneficiary?[0].id??"", groupThreapy: false,),
                                      ),
                                    ),
                                  );

                                },
                                child: Container(
                                  width: 333.w,
                                  height: 48.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xff19649E),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'approved'.tr(),
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.h),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 333.w,
                                  height: 48.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xffD5D5D5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'notHaveAppointment'.tr(),
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Color(0xff19649E),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Center(child: Text('noSpecialistsFound'.tr()));
                        }
                      },
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
