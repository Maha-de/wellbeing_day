import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor/screens/homescreen.dart';
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
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/doctor_card.dart';
import 'client_profile_screen.dart';

class FirstHomePage extends StatefulWidget {
  const FirstHomePage({super.key});

  @override
  State<FirstHomePage> createState() => _FirstHomePageState();
}

class _FirstHomePageState extends State<FirstHomePage> {
  var sliderIndex = 0;
  CarouselSliderController carouselControllerEx = CarouselSliderController();
  late UserProfileCubit userProfileCubit;

  var images = [
    'assets/images/family.png',
    'assets/images/familyy.png',
    'assets/images/familyyy.png',
  ];

  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    _loadUserProfile();
    final specialistCubit = BlocProvider.of<GetSpecialistCubit>(context);
    specialistCubit.fetchSpecialists();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";
    userProfileCubit.getUserProfile(context, id);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width.w;
    double screenHeight = MediaQuery.of(context).size.height.h;
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
                  bottomNavigationBar: const CustomBottomNavBar(
                    currentIndex: 0,
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: screenHeight * 0.24,
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
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 70, 20, 20),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 66.w,
                                          height: 66.h,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                50),
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
                                         SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          "greeting".tr() + "\n ${userProfile.firstName}",
                                          textAlign: TextAlign.center,
                                          style:  TextStyle(
                                            fontSize: 16.sp,
                                            color: Color(0xff19649E),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 40),
                                    child: SizedBox(
                                      height: 100.h,
                                      width: 110.w,
                                      child: Image.asset('assets/images/img.png',
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .end,
                                          children: [
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.phone,
                                                  size: 35,
                                                  color: Colors.red,
                                                )),
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.notifications_outlined,
                                                  size: 40,
                                                  color: Color(0xff19649E),
                                                )),
                                          ],
                                        ),
                                         SizedBox(
                                          height: 20.h,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30),
                                          child: Column(
                                            children: [
                                               Text(
                                                "تواصل معنا",
                                                style: TextStyle(
                                                  color: Color(0xff19649E),
                                                  fontSize: 17.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                               SizedBox(
                                                height: 10.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: SizedBox(
                                                      width: 27.66.w,
                                                      height: 25.33.h,
                                                      child: Image.asset(
                                                          "assets/images/fa-brands_twitter-square.png",
                                                          fit: BoxFit.fill),
                                                    ),
                                                  ),
                                                   SizedBox(width: 5.w),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: SizedBox(
                                                      width: 27.66.w,
                                                      height: 25.33.h,
                                                      child: Image.asset(
                                                          "assets/images/uil_facebook.png",
                                                          fit: BoxFit.fill),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: SizedBox(
                                                      width: 27.66.w,
                                                      height: 25.33.h,
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
                         SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width.w,
                          child: CarouselSlider(
                            carouselController: carouselControllerEx,
                            options: CarouselOptions(
                                height: 180.h,
                                autoPlay: true,
                                onPageChanged: (index, _) {
                                  sliderIndex = index;
                                  setState(() {});
                                }),
                            items: images.map((i) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Image.asset(
                                      i,
                                      fit: BoxFit.cover,
                                    )),
                              );
                            }).toList(),
                          ),
                        ),
                         SizedBox(
                          height: 20.h,
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xFFAFDCFF)),
                            height: 50.h,
                            width: 380.w,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                labelText: "البحث",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ),
                         SizedBox(
                          height: 10.h,
                        ),

                        // List of doctors
                        BlocBuilder<GetSpecialistCubit, GetSpecialistState>(
                          builder: (context, state) {
                            if (state is SpecialistLoading) {
                              return CircularProgressIndicator(); // Show loading indicator
                            } else if (state is SpecialistFailure) {
                              return Text(state.errMessage); // Display error message
                            } else if (state is SpecialistSuccess) {
                              return Container(
                                height: screenHeight*0.57.h,
                                child: ListView.builder(
                                  itemCount: state.specialists.length,
                                  itemBuilder: (context, index) {
                                    return DoctorCard(specialistModel: state.specialists[index]);
                                  },
                                ),
                              );
                            } else {
                              return Center(child: Text('No specialists found.'));
                            }
                          },
                        )

                      ],
                    ),
                  ),
                );
              }
              return Container(); // Default return in case no state matches
            }
    )
    );
  }
}
