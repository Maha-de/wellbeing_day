import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../models/user_profile_model.dart';
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
    return BlocProvider(
        create: (context) => userProfileCubit,
    child: BlocBuilder<UserProfileCubit, UserProfileState>(
    builder: (context, state) {
      if (state is UserProfileLoading) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else if (state is UserProfileFailure) {
        return Center(
            child: Text("Error loading profile: ${state.error}"));
      } else if (state is UserProfileSuccess) {
        UserProfileModel userProfile = state.userProfile;
        return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0,),

          body: Column(
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  color: Color(0xFFAFDCFF),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 70, 20, 20),
                          child: Column(
                            children: [
                              Container(
                                width: 66,
                                height: 50,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child:
                                    userProfile.imageUrl == "" ||
                                        userProfile.imageUrl == null
                                        ? Image.asset(
                                        "assets/images/profile.jpg",
                                        fit: BoxFit.fill)
                                        : Image.network(
                                        userProfile.imageUrl ?? "",
                                        fit: BoxFit.fill),

                                ),
                              ),
                              const SizedBox(height: 10,),

                              Text(
                                "greeting".tr() + " ${userProfile.firstName}",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff19649E),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, right: 40),
                          child:
                          SizedBox(
                            height: 100,
                            width: 110,
                            child: Image.asset(
                                'assets/images/img.png', fit: BoxFit.fill),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child:
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(onPressed: () {},
                                      icon: const Icon(Icons.phone, size: 35,
                                        color: Colors.red,)),
                                  IconButton(onPressed: () {},
                                      icon: const Icon(
                                        Icons.notifications_outlined, size: 40,
                                        color: Color(0xff19649E),)),
                                ],
                              ),
                              const SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Column(
                                  children: [


                                    const Text("تواصل معنا",
                                      style: TextStyle(
                                        color: Color(0xff19649E),
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),


                                    const SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,

                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: SizedBox(
                                            width: 27.66,
                                            height: 25.33,
                                            child: Image.asset(
                                                "assets/images/fa-brands_twitter-square.png",
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        GestureDetector(
                                          onTap: () {},
                                          child: SizedBox(
                                            width: 27.66,
                                            height: 25.33,
                                            child: Image.asset(
                                                "assets/images/uil_facebook.png",
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        GestureDetector(
                                          onTap: () {},
                                          child: SizedBox(
                                            width: 27.66,
                                            height: 25.33,
                                            child: Image.asset(
                                                "assets/images/ri_instagram-fill.png",
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

              ),
              const SizedBox(height: 30,),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color(0xFF19649E),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: const Center(
                      child: Text(
                        "مواعيدي",
                        style: TextStyle(fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,),
                      )),
                ),
              ),
              const SizedBox(height: 30,),

              NavigationBar(
                backgroundColor: Colors.transparent,
                height: 50,
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
              const SizedBox(height: 30,),
              <Widget>[

                Column(
                  children: [
                    DoctorCard(),
                    const SizedBox(height: 30,),

                    Padding(
                      padding: const EdgeInsets.only(right: 30, left: 30),
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
                            child: const Text(
                              "إعادة جدوله",
                              style: TextStyle(
                                  fontSize: 20,
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
                            child: const Text(
                              "إلغاء الموعد",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                DoctorCard(),
                DoctorCard(),

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
      width: 100,
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
          index == 0 ? "القادمة" : index == 1 ? "مكتمل" : "تم الإلغاء",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

}



