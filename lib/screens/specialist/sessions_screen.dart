import 'dart:async';

import 'package:doctor/models/Doctor_id_model.dart';
import 'package:doctor/widgets/custom_app_bar_specialist.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cubit/doctor_details_cubit/doctor_profile_cubit.dart';
import '../../cubit/doctor_details_cubit/doctor_profile_state.dart';
import '../../cubit/get_doctor_sessions_types_cubit/doctor_session_types_cubit.dart';
import '../../cubit/get_doctor_sessions_types_cubit/doctor_session_types_state.dart';
import '../../widgets/beneficiary_card.dart';
import '../../widgets/custom_bottom_nav_bar_specialist.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  int _currentPage = 0;
  late DoctorProfileCubit userProfileCubit;
  late DoctorSessionTypesCubit doctorSessionCubit;

  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<DoctorProfileCubit>(context);
    doctorSessionCubit = BlocProvider.of<DoctorSessionTypesCubit>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('doctorId') ?? "";
    doctorSessionCubit.getDoctorSessions(context, id);
    userProfileCubit.getUserProfile(context, id);
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (_) => userProfileCubit,
      child: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
        builder: (context, state) {
          if (state is DoctorProfileLoading) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (state is DoctorProfileFailure) {
            return Center(child: Text("Error loading profile: ${state.error}"));
          } else if (state is DoctorProfileSuccess) {
            DoctorByIdModel userProfile = state.doctorProfile;

            return Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: const SpecialistCustomBottomNavBar(currentIndex: 1),
              appBar: CustomAppBarSpecialist(
                userProfile: userProfile.specialist,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30.h),
                    _buildHeader(),
                    SizedBox(height: 10.h),
                    _buildNavigationBar(),
                    _buildSessionList(screenWidth),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Align(
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
            style: TextStyle(fontSize: 20.sp, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNavButton("completedSessions", 0),
          SizedBox(width: 10.w),
          _buildNavButton("nextSessions", 1),
        ],
      ),
    );
  }

  Widget _buildNavButton(String label, int index) {
    return TextButton(
      onPressed: () => _onItemTapped(index),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        backgroundColor: _currentPage == index ? Color(0xFF19649E) : Colors.grey.shade300,
      ),
      child: Text(
        label.tr(),
        style: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.bold,
          color: _currentPage == index ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildSessionList(double screenWidth) {
    return IndexedStack(
      index: _currentPage,
      children: [
        _buildSessionBloc((state) => state.session.completedSessions, screenWidth),
        _buildSessionBloc((state) => state.session.scheduledSessions, screenWidth),

      ],
    );
  }

  Widget _buildSessionBloc(List<dynamic>? Function(DoctorSessionTypesSuccess) getSessions, double screenWidth) {
    return BlocBuilder<DoctorSessionTypesCubit, DoctorSessionTypesState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is DoctorSessionTypesLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is DoctorSessionTypesFailure) {
          return Center(child: Text(state.error));
        } else if (state is DoctorSessionTypesSuccess) {
          return _buildSessionsList(getSessions(state), screenWidth);
        }
        return Center(child: Text('noSpecialistsFound'.tr()));
      },
    );
  }

  Widget _buildSessionsList(List<dynamic>? sessions, double screenWidth) {
    if (sessions == null || sessions.isEmpty) {
      return Center(
        child: Image.asset("assets/images/image.png", fit: BoxFit.fill),
      );
    }
    return SizedBox(
      height: 400.h,
      width: screenWidth,
      child: ListView.separated(
        padding: EdgeInsets.only(top: 45),
        itemBuilder: (context, index) {
          return BeneficiaryCard(session: sessions[index].beneficiary?[0], scheduledSessions: sessions[index]);
        },
        separatorBuilder: (context, index) => SizedBox(height: 50.h),
        itemCount: sessions.length,
      ),
    );
  }
}
