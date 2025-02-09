import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/get_specialist/get_sepcialist_cubit.dart';
import '../cubit/get_specialist/get_specialist_state.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../models/user_profile_model.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/doctor_card.dart';


class AppointmentsSection extends StatefulWidget {
  const AppointmentsSection({super.key});

  @override
  State<AppointmentsSection> createState() => _AppointmentsSectionState();
}

class _AppointmentsSectionState extends State<AppointmentsSection> {


  int _currentPage = 0;
  final int totalPages = 3;

  late UserProfileCubit userProfileCubit;


  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    _loadUserProfile();

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
    bool isEnglish = Localizations.localeOf(context).languageCode == 'en';

    return BlocProvider(
        create: (context) => userProfileCubit,
    child: BlocBuilder<UserProfileCubit, UserProfileState>(
    builder: (context, state) {
      if (state is UserProfileLoading) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else if (state is UserProfileFailure) {
        return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3,),
         appBar:CustomAppBar(
           screenWidth: screenWidth,
           screenHeight: screenHeight,
         ),
          body: Column(
            children: [
               SizedBox(height: 30.h,),
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
                        "appointments".tr(),
                        style: TextStyle(fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,),
                      )),
                ),
              ),
               SizedBox(height: 30.h,),

              NavigationBar(
                backgroundColor: Colors.transparent,
                height: 50.h,
                destinations: [

                  NavigationDestination(
                    icon: _buildIcon(0),
                    label: "",
                  ),
                  NavigationDestination(
                    icon: _buildIcon(1),
                    label: "",
                  ),
                  NavigationDestination(
                    icon: _buildIcon(2),
                    label: "",
                  ),

                ],
                selectedIndex: _currentPage,
                onDestinationSelected: _onItemTapped,
              ),
               SizedBox(height: 30.h,),
              <Widget>[

                Column(
                  children: [
                    // DoctorCard(),
                     SizedBox(height: 30.h,),

                    Padding(
                      padding: const EdgeInsets.only(right: 30, left: 30, top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              // minimumSize: const Size(350, 50),
                                backgroundColor: const Color(0xFF19649E),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child:  Text(
                              "reschedule".tr(),
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              // minimumSize: const Size(350, 50),
                                backgroundColor: const Color(0xFF19649E),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child: Text(
                              "cancelAppointment".tr(),
                              style: TextStyle(
                                  fontSize: isEnglish ? 17.sp : 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                // DoctorCard(),
                // DoctorCard(),

              ]
              [_currentPage],
            ],
          ),
        );
      } else if (state is UserProfileSuccess) {
        UserProfileModel userProfile = state.userProfile;
        return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3,),
          appBar: CustomAppBar(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
          body: Column(
            children: [

               SizedBox(height: 30.h,),
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
                  child:  Center(
                      child: Text(
                        "appointments".tr(),
                        style: TextStyle(fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,),
                      )),
                ),
              ),
              SizedBox(height: 30.h,),

              NavigationBar(
                backgroundColor: Colors.transparent,
                height: 50.h,
                destinations: [

                  NavigationDestination(
                    icon: _buildIcon(0),
                    label: "",
                  ),
                  NavigationDestination(
                    icon: _buildIcon(1),
                    label: "",
                  ),
                  NavigationDestination(
                    icon: _buildIcon(2),
                    label: "",
                  ),

                ],
                selectedIndex: _currentPage,
                onDestinationSelected: _onItemTapped,
              ),
              <Widget>[

                Column(
                  children: [


                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child:  BlocBuilder<GetSpecialistCubit, GetSpecialistState>(
                        builder: (context, state) {
                          if (state is SpecialistLoading) {
                            return CircularProgressIndicator(); // Show loading indicator
                          } else if (state is SpecialistFailure) {
                            return Text(state.errMessage); // Display error message
                          } else if (state is SpecialistSuccess) {
                            return Container(
                              height: 360.h,
                              child: ListView.builder(
                                itemCount: state.specialists.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 329.h,
                                   decoration: BoxDecoration(
                                     color: Colors.white,
                                     borderRadius: BorderRadius.circular(20)
                                   ),
                                    
                                    child: Column(
                                      children: [
                                        DoctorCard(specialistModel: state.specialists[index]),
                                        Container(

                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width:160.w,
                                                height:40.h,
                                                decoration: BoxDecoration(
                                                    color: Color(0xFF19649E),
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "reschedule".tr(),
                                                    style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),

                                              ),
                                              Container(
                                                width:160.w,
                                                height:40.h,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF19649E),
                                                  borderRadius: BorderRadius.circular(20)
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "cancelAppointment".tr(),
                                                    style: TextStyle(
                                                        fontSize: isEnglish ? 17.sp : 20.sp,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),

                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return Center(child: Text('noSpecialistsFound'.tr()));
                          }
                        },
                      ),
                    )
                  ],
                ),
                Column(
                  children: [


                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child:  BlocBuilder<GetSpecialistCubit, GetSpecialistState>(
                        builder: (context, state) {
                          if (state is SpecialistLoading) {
                            return CircularProgressIndicator(); // Show loading indicator
                          } else if (state is SpecialistFailure) {
                            return Text(state.errMessage); // Display error message
                          } else if (state is SpecialistSuccess) {
                            return Container(
                              height: 360.h,
                              child: ListView.separated(
                                separatorBuilder: (context,index){
                                  return SizedBox(height: 12.h,);
                                },
                                itemCount: state.specialists.length,
                                itemBuilder: (context, index) {
                                  return DoctorCard(specialistModel: state.specialists[index]);
                                },
                              ),
                            );
                          } else {
                            return Center(child: Text('noSpecialistsFound'.tr()));
                          }
                        },
                      ),
                    )
                  ],
                ),
                Column(
                  children: [


                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child:  BlocBuilder<GetSpecialistCubit, GetSpecialistState>(
                        builder: (context, state) {
                          if (state is SpecialistLoading) {
                            return CircularProgressIndicator(); // Show loading indicator
                          } else if (state is SpecialistFailure) {
                            return Text(state.errMessage); // Display error message
                          } else if (state is SpecialistSuccess) {
                            return Container(
                              height: 360.h,
                              child: ListView.separated(
                                separatorBuilder: (context,index){
                                  return SizedBox(height: 12.h,);
                                },
                                itemCount: state.specialists.length,
                                itemBuilder: (context, index) {
                                  return DoctorCard(specialistModel: state.specialists[index]);
                                },
                              ),
                            );
                          } else {
                            return Center(child: Text('noSpecialistsFound'.tr()));
                          }
                        },
                      ),
                    )
                  ],
                ),

                // DoctorCard(),
                // DoctorCard(),

              ]
              [_currentPage],
            ],
          ),
        );
      }
      return Container(); // Default return in case no state matches
    }
    )
    );
  }
  Widget _buildIcon(int index) {
    return Container(
      width: 100.w,
      child: TextButton(
        onPressed: () {
          _onItemTapped(index);
        },
        style: TextButton.styleFrom(
          minimumSize: const Size(50, 32), // Set minimum size for the button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          foregroundColor: Colors.grey.shade300,
          backgroundColor: _currentPage == index ? const Color(0xFF19649E) : Colors.grey.shade300,
        ),
        child: Text(
          index == 0 ? "coming".tr() : index == 1 ? "completed".tr() : "canceled".tr(),
          style:  TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

}



