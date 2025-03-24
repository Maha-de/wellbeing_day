import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor/screens/homescreen.dart';
import 'package:doctor/screens/sign_up_as_client.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/get_all_ads/get_all_ads_cubit.dart';
import '../cubit/get_specialist/get_sepcialist_cubit.dart';
import '../cubit/get_specialist/get_specialist_state.dart';
import '../cubit/get_sub_categories_cubit/get_sub_categories_cubit.dart';
import '../cubit/update_user_cubit/update_user_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../make_email/login.dart';
import '../models/user_profile_model.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/doctor_card.dart';
import 'applicationInfo.dart';
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
  late GetSpecialistCubit getSpecialistCubit;
  int currentIndex = 0;
  var images = [
    'assets/images/familyy.png',
    'assets/images/familyyy.png',
  ];

  @override
  void initState() {
    super.initState();
    getSpecialistCubit = BlocProvider.of<GetSpecialistCubit>(context);
    getSpecialistCubit.fetchSpecialists();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    _loadUserProfile();

    _startAutoPageSwitch();
  }

  PageController _pageController = PageController();
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

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";
    userProfileCubit.getUserProfile(context, id);
  }

  late Timer _timer;

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
            return Scaffold(
              appBar: CustomAppBar(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              backgroundColor: Colors.white,
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: const Color(0xff19649E),
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.black,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: currentIndex,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: SizedBox(
                      height: 27.h,
                      child: Image.asset("assets/images/meteor-icons_home.png",
                          fit: BoxFit.fill),
                    ),
                    activeIcon: SizedBox(
                      height: 27.h,
                      child: Image.asset("assets/images/meteor-icons_home.png",
                          color:
                              currentIndex == 0 ? Colors.white : Colors.black,
                          fit: BoxFit.fill),
                    ),
                    label: "home".tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox(
                      height: 27.h,
                      child: Image.asset("assets/images/nrk_category1.png",
                          fit: BoxFit.fill),
                    ),
                    activeIcon: SizedBox(
                      height: 27.h,
                      child: Image.asset("assets/images/nrk_category.png",
                          fit: BoxFit.fill),
                    ),
                    label: "menu".tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox(
                      height: 25.h,
                      child: Image.asset(
                          "assets/images/material-symbols_help-clinic-outline-rounded.png",
                          fit: BoxFit.fill),
                    ),
                    activeIcon: SizedBox(
                      height: 33.h,
                      child: Image.asset(
                          "assets/images/material-symbols_help-clinic-outline-rounded_Active.png",
                          fit: BoxFit.fill),
                    ),
                    label: "info".tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox(
                      height: 27.h,
                      child: Image.asset("assets/images/gg_profile.png",
                          fit: BoxFit.fill),
                    ),
                    activeIcon: SizedBox(
                      height: 27.h,
                      child: Image.asset("assets/images/gg_profile1.png",
                          fit: BoxFit.fill),
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
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                              child: Text("login".tr()),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SignUpAsClient()));
                              },
                              child: Text("createAccount".tr()),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
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
                          builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider<UserProfileCubit>(
                                  create: (_) => UserProfileCubit()),
                              BlocProvider<SubCategoriesCubit>(
                                  create: (_) => SubCategoriesCubit()),
                              BlocProvider<UpdateUserCubit>(
                                  create: (_) => UpdateUserCubit()),
                              BlocProvider<SubCategoriesCubit>(
                                  create: (_) => SubCategoriesCubit()),
                              BlocProvider<GetAllAdsCubit>(create: (_) => GetAllAdsCubit()),

                            ],
                            child: const HomeScreen(),
                          ),
                        ),
                      );
                      break;
                    case 2:
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ApplicationInfo()));
                      break;
                    case 0:
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FirstHomePage()));
                      break;
                  }
                },
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Container(
                      width: 343.w,
                      height: 145.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            images[index],
                            fit: BoxFit.fill,
                            width: 343.w,
                            height: 145.h,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // ✅ **إضافة البحث**
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFAFDCFF),
                        ),
                        height: 40.h,
                        width: 310.w,
                        child: TextFormField(
                          controller: context
                              .read<GetSpecialistCubit>()
                              .searchController,
                          onChanged: (value) {
                            context
                                .read<GetSpecialistCubit>()
                                .searchSpecialists(value);
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            labelText: "search".tr(),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    // ✅ **تحديث قائمة الأطباء بناءً على البحث**
                    BlocBuilder<GetSpecialistCubit, GetSpecialistState>(
                      builder: (context, state) {
                        if (state is SpecialistLoading) {
                          return CircularProgressIndicator(); // مؤشر تحميل
                        } else if (state is SpecialistFailure) {
                          return Text(state.errMessage); // رسالة خطأ
                        } else if (state is SpecialistSuccess) {
                          return Container(
                            height: screenHeight * 0.57.h,
                            width: 344.w,
                            child: ListView.builder(
                              itemCount: context
                                  .read<GetSpecialistCubit>()
                                  .filteredSpecialists
                                  .length,
                              itemBuilder: (context, index) {
                                return DoctorCard(
                                  categoryInfo:
                                      null, //to disable the appointment button in doctorDetails screen when go to it using this screen , that the categorey not defined

                                  specialistModel: context
                                      .read<GetSpecialistCubit>()
                                      .filteredSpecialists[index],
                                  doctorID: context
                                          .read<GetSpecialistCubit>()
                                          .filteredSpecialists[index]
                                          .id ??
                                      "",
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(child: Text('noSpecialistsFound'.tr()));
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          } else if (state is UserProfileSuccess) {
            UserProfileModel userProfile = state.userProfile;
            return Scaffold(
              appBar: CustomAppBar(
                userProfile: userProfile,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              backgroundColor: Colors.white,
              bottomNavigationBar: const CustomBottomNavBar(
                currentIndex: 0,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Container(
                      width: 343.w,
                      height: 145.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            images[index],
                            fit: BoxFit.fill,
                            width: 343.w,
                            height: 145.h,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // ✅ **إضافة البحث**
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFAFDCFF),
                        ),
                        height: 40.h,
                        width: 310.w,
                        child: TextFormField(
                          controller: context
                              .read<GetSpecialistCubit>()
                              .searchController,
                          onChanged: (value) {
                            context
                                .read<GetSpecialistCubit>()
                                .searchSpecialists(value);
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            labelText: "search".tr(),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    // ✅ **تحديث قائمة الأطباء بناءً على البحث**
                    BlocBuilder<GetSpecialistCubit, GetSpecialistState>(
                      builder: (context, state) {
                        if (state is SpecialistLoading) {
                          return CircularProgressIndicator(); // مؤشر تحميل
                        } else if (state is SpecialistFailure) {
                          return Text(state.errMessage); // رسالة خطأ
                        } else if (state is SpecialistSuccess) {
                          return Container(
                            height: screenHeight * 0.57.h,
                            width: 344.w,
                            child: ListView.builder(
                              itemCount: context
                                  .read<GetSpecialistCubit>()
                                  .filteredSpecialists
                                  .length,
                              itemBuilder: (context, index) {
                                return DoctorCard(
                                  categoryInfo:
                                      null, //to disable the appointment button in doctorDetails screen when go to it using this screen , that the categorey not defined
                                  specialistModel: context
                                      .read<GetSpecialistCubit>()
                                      .filteredSpecialists[index],
                                  doctorID: context
                                          .read<GetSpecialistCubit>()
                                          .filteredSpecialists[index]
                                          .id ??
                                      "",
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(child: Text('noSpecialistsFound'.tr()));
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          }
          return Container(); // Default return in case no state matches
        }));
  }
}
