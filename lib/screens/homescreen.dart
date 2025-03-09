import 'dart:async';
import 'package:doctor/cubit/create_session.dart/create_session_cubit.dart';
import 'package:doctor/cubit/get_all_ads/get_all_ads_cubit.dart';
import 'package:doctor/make_email/login.dart';
import 'package:doctor/screens/group_therapy.dart';
import 'package:doctor/screens/home_second_screen.dart';
import 'package:doctor/screens/problem_solving_screen.dart';
import 'package:doctor/screens/psychological_disorders_screen.dart';
import 'package:doctor/screens/psychological_prevention_screen.dart';
import 'package:doctor/screens/rehabilitation_screen.dart';
import 'package:doctor/screens/sign_up_as_client.dart';
import 'package:doctor/screens/sub_category_screen.dart';
import 'package:doctor/screens/therapeutic_programs_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import '../cubit/doctor_by_category_cubit/doctor_by_category_cubit.dart';
import '../cubit/get_all_ads/get_all_ads_state.dart';
import '../cubit/get_sub_categories_cubit/get_sub_categories_cubit.dart';
import '../cubit/get_sub_categories_cubit/get_sub_categories_state.dart';
import '../cubit/update_user_cubit/update_user_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../models/user_profile_model.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'applicationInfo.dart';
import 'childrens_disorder_screen.dart';
import 'first_home_page.dart';
import 'free_consultation_screen.dart';
import 'guidanceAndInstructions.dart';
import 'home_third_screen.dart';
import 'instant_session_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SubCategoriesCubit subCategoriesCubit;
  List<String> categories = [
    "mentalHealth".tr(),
    "physicalHealth".tr(),
    "skillDevelopment".tr(),
    "magazine".tr()
  ];
  int selectedIndex = 0;
  final List<String> images = [
    'assets/images/family.png',
    'assets/images/familyy.png',
    'assets/images/familyyy.png',
  ];
  PageController _pageController = PageController();
  late Timer _timer;
  late UserProfileCubit userProfileCubit;
  late GetAllAdsCubit getAllAdsCubit;

  int currentIndex = 1;
  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    subCategoriesCubit = BlocProvider.of<SubCategoriesCubit>(context);
    getAllAdsCubit = BlocProvider.of<GetAllAdsCubit>(context);
    _loadUserProfile();
    _startAutoPageSwitch();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";
    print(id);
    getAllAdsCubit.fetchAllAdv();
    subCategoriesCubit.fetchSubCategories(context, "mentalHealth");
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
                return Scaffold(
                  appBar: CustomAppBar(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    backgroundColor: const Color(
                        0xff19649E), // Ensures the background is consistent
                    selectedItemColor:
                        Colors.white, // Sets the color of the selected icons
                    unselectedItemColor:
                        Colors.black, // Sets the color of unselected icons
                    showSelectedLabels: false, // Hides selected labels
                    showUnselectedLabels: false, // Hides unselected labels
                    currentIndex: currentIndex, // Default selected index
                    type: BottomNavigationBarType
                        .fixed, // Prevents animation on shifting types
                    items: [
                      BottomNavigationBarItem(
                        icon: SizedBox(
                          height: 27.h, // Adjust icon size
                          child: Image.asset(
                            "assets/images/meteor-icons_home.png",
                            // color: currentIndex == 0 ? Colors.white : Colors.black,
                            fit: BoxFit.fill,
                          ),
                        ),
                        activeIcon: SizedBox(
                          height: 27.h, // Active icon size adjustment
                          child: Image.asset(
                            "assets/images/meteor-icons_home.png",
                            color:
                                currentIndex == 0 ? Colors.white : Colors.black,
                            fit: BoxFit.fill,
                          ),
                        ),
                        label: "home".tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: SizedBox(
                          height: 27.h,
                          child: Image.asset(
                            "assets/images/nrk_category1.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        activeIcon: SizedBox(
                          height: 27.h,
                          child: Image.asset(
                            "assets/images/nrk_category.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        label: "menu".tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: SizedBox(
                          height: 25.h, // Adjust icon size
                          child: Image.asset(
                            "assets/images/material-symbols_help-clinic-outline-rounded.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        activeIcon: SizedBox(
                          height: 33.h,
                          // width: 50,
                          child: Image.asset(
                            "assets/images/material-symbols_help-clinic-outline-rounded_Active.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        label: "info".tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: SizedBox(
                          height: 27.h,
                          child: Image.asset(
                            "assets/images/gg_profile.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        activeIcon: SizedBox(
                          height: 27.h,
                          child: Image.asset(
                            "assets/images/gg_profile1.png",
                            fit: BoxFit.fill,
                          ),
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
                                    Navigator.pop(context); // إغلاق الـ Alert
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginPage()), // استبدليها بصفحة تسجيل الدخول
                                    );
                                  },
                                  child: Text("login".tr()),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // إغلاق الـ Alert
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignUpAsClient()), // استبدليها بصفحة التسجيل
                                    );
                                  },
                                  child: Text("createAccount".tr()),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(
                                        context); // إغلاق الـ Alert بدون أي انتقال
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
                                    BlocProvider<GetAllAdsCubit>(
                                        create: (_) => GetAllAdsCubit()),
                                  ],
                                  child: const HomeScreen(),
                                ),
                              ));
                          break;
                        case 2:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ApplicationInfo()));

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
                  body: Column(
                    children: [
                      // Header

                      SizedBox(height: 10.h),

                      // Category List
                      SizedBox(
                        height: 32.h,
                        child: ListView.separated(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          itemCount: categories.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return SizedBox(width: screenWidth * 0.02.w);
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (index == categories.length - 1) {
                                    // Do nothing if it's the last item
                                    selectedIndex =
                                        selectedIndex; // Keep the current index
                                  } else {
                                    selectedIndex =
                                        index; // Update the selected index
                                  }
                                });

                                // Navigate only if it's not the last item
                                if (index != categories.length - 1) {
                                  Widget page;

                                  if (selectedIndex == 0) {
                                    page = const HomeScreen();
                                  } else if (selectedIndex == 1) {
                                    page = const HomeSecondScreen();
                                  } else if (selectedIndex == 2) {
                                    page = const HomeThirdScreen();
                                  } else {
                                    page = const HomeScreen();
                                  }

                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          MultiBlocProvider(
                                        providers: [
                                          BlocProvider(
                                              create: (_) =>
                                                  UserProfileCubit()),
                                          BlocProvider(
                                              create: (_) =>
                                                  DoctorByCategoryCubit()),
                                          BlocProvider(
                                              create: (_) =>
                                                  SubCategoriesCubit()),
                                          BlocProvider(
                                              create: (_) => GetAllAdsCubit()),
                                        ],
                                        child: page,
                                      ),
                                      transitionDuration:
                                          const Duration(milliseconds: 1),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                width: screenWidth * 0.35.w,
                                height: 32.h,
                                decoration: BoxDecoration(
                                  color: index == categories.length - 1
                                      ? const Color(
                                          0xffAFDCFF) // Always blue for the last item
                                      : (selectedIndex == index
                                          ? const Color(0xff19649E)
                                          : const Color(0xffD5D5D5)),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    categories[index],
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 15.h),

                      // Image Slider
                      SizedBox(
                        height: screenHeight * 0.18.h,
                        width: screenWidth * 0.9.w,
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
                      SizedBox(height: 15.h),

                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider<UserProfileCubit>(
                                          create: (_) => UserProfileCubit()),
                                      BlocProvider<AddImageToProfileCubit>(
                                          create: (_) =>
                                              AddImageToProfileCubit()),
                                      BlocProvider<UpdateUserCubit>(
                                          create: (_) => UpdateUserCubit()),
                                      BlocProvider<CreateSessionCubit>(
                                          create: (_) => CreateSessionCubit()),
                                    ],
                                    child: const FreeConsultationScreen(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: screenWidth * 0.46.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xff1F78BC),
                              ),
                              child: Center(
                                child: Text(
                                  "consultation".tr(),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider<UserProfileCubit>(
                                          create: (_) => UserProfileCubit()),
                                      BlocProvider<AddImageToProfileCubit>(
                                          create: (_) =>
                                              AddImageToProfileCubit()),
                                      BlocProvider<UpdateUserCubit>(
                                          create: (_) => UpdateUserCubit()),
                                      BlocProvider<CreateSessionCubit>(
                                          create: (_) => CreateSessionCubit()),
                                    ],
                                    child: const InstantSessionScreen(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: screenWidth * 0.45.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xff1F78BC),
                              ),
                              child: Center(
                                child: Text(
                                  "instantSession".tr(),
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
                      SizedBox(height: 15.h),
                      Center(
                        child: SizedBox(
                          width: 338.w,
                          height: 252.h,
                          child: BlocBuilder<SubCategoriesCubit,
                              SubCategoriesState>(
                            builder: (context, state) {
                              if (state is SubCategoriesLoading) {
                                return CircularProgressIndicator(); // Show loading indicator
                              } else if (state is SubCategoriesFailure) {
                                return Text(
                                    state.errMessage); // Display error message
                              } else if (state is SubCategoriesSuccess) {
                                return GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, // 3 items per row
                                    crossAxisSpacing:
                                        8, // spacing between columns
                                    mainAxisSpacing: 8, // spacing between rows
                                    childAspectRatio:
                                        1.5, // aspect ratio of the grid items
                                  ),
                                  itemCount: subCategoriesCubit.categories
                                      .length, // total number of items
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MultiBlocProvider(
                                              providers: [
                                                BlocProvider<UserProfileCubit>(
                                                    create: (_) =>
                                                        UserProfileCubit()),
                                                BlocProvider<
                                                        AddImageToProfileCubit>(
                                                    create: (_) =>
                                                        AddImageToProfileCubit()),
                                                BlocProvider<UpdateUserCubit>(
                                                    create: (_) =>
                                                        UpdateUserCubit()),
                                                BlocProvider<
                                                        DoctorByCategoryCubit>(
                                                    create: (_) =>
                                                        DoctorByCategoryCubit()),
                                                BlocProvider<
                                                        SubCategoriesCubit>(
                                                    create: (_) =>
                                                        SubCategoriesCubit()),
                                              ],
                                              child: SubCategoryScreen(
                                                category: 'mentalHealth',
                                                subCategory: subCategoriesCubit
                                                        .categories[index] ??
                                                    "",
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 100.w,
                                        height: 68.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color(0xff69B7F3),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            subCategoriesCubit
                                                    .categories[index] ??
                                                "",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
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
                      )
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //       children: [
                      //         for (var label in [
                      //           "therapeuticPrograms",
                      //           "groupTherapy",
                      //           "psychologicalDisorders"
                      //         ])
                      //           GestureDetector(
                      //             onTap: (){
                      //
                      //               if(label=="psychologicalDisorders"){
                      //
                      //                 Navigator.push(
                      //                   context,
                      //                   MaterialPageRoute(
                      //                     builder: (context) => MultiBlocProvider(
                      //                       providers: [
                      //                         BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                      //                         BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                      //                         BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                      //                         BlocProvider<DoctorByCategoryCubit>(create: (_) => DoctorByCategoryCubit()),
                      //
                      //                       ],
                      //                       child: const PsychologicalDisordersScreen(category: 'mentalHealth', subCategory: "اضطرابات نفسية",),
                      //                     ),
                      //
                      //                   ),
                      //
                      //                 );}
                      //
                      //               else if(label=="groupTherapy"){
                      //
                      //                 Navigator.push(
                      //                   context,
                      //                   MaterialPageRoute(
                      //                     builder: (context) => MultiBlocProvider(
                      //                       providers: [
                      //                         BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                      //                         BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                      //                         BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                      //                         BlocProvider<DoctorByCategoryCubit>(create: (_) => DoctorByCategoryCubit()),
                      //                       ],
                      //                       child: const GroupTherapy(),
                      //                     ),
                      //
                      //                   ),
                      //
                      //                 );
                      //               }
                      //               else if(label=="therapeuticPrograms"){
                      //                 Navigator.push(
                      //                   context,
                      //                   MaterialPageRoute(
                      //                     builder: (context) => MultiBlocProvider(
                      //                       providers: [
                      //                         BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                      //                         BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                      //                         BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                      //                         BlocProvider<DoctorByCategoryCubit>(create: (_) => DoctorByCategoryCubit()),
                      //                       ],
                      //                       child: const TherapeuticProgramsScreen(category: 'mentalHealth', subCategory: "برامج علاجية"),
                      //                     ),
                      //
                      //                   ),
                      //
                      //                 );
                      //               }
                      //
                      //             },
                      //             child: Container(
                      //               width: 100.w,
                      //               height: 68.h,
                      //               decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(20),
                      //                 color: const Color(0xff69B7F3),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.black.withOpacity(0.2),
                      //                     spreadRadius: 2,
                      //                     blurRadius: 4,
                      //                     offset: const Offset(0, 2),
                      //                   ),
                      //                 ],
                      //               ),
                      //               child: Center(
                      //                 child: Text(
                      //                   label.tr(),
                      //                   textAlign: TextAlign.center,
                      //                   style:  TextStyle(
                      //                     fontSize: 16.sp,
                      //                     color: Colors.white,
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //       ],
                      //     ),
                      //     SizedBox(height: 16.h),
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         for (var label in [
                      //           "guidanceAndInstructions",
                      //           "diagnoseAndMotivation",
                      //           "childrenDisorder"
                      //         ])
                      //           Row(
                      //             children: [
                      //
                      //
                      //               GestureDetector(
                      //                 onTap: (){
                      //                   if(label== "diagnoseAndMotivation".tr()){  Navigator.push(
                      //                     context,
                      //                     MaterialPageRoute(
                      //                       builder: (context) => MultiBlocProvider(
                      //                         providers: [
                      //                           BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                      //                           BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                      //                           BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                      //                           BlocProvider<DoctorByCategoryCubit>(create: (_) => DoctorByCategoryCubit()),
                      //                         ],
                      //                         child:  ProblemSolvingScreen(category: 'mentalHealth', subCategory: "حل مشكلات", category1:"diagnoseAndMotivation".tr(),),
                      //                       ),
                      //
                      //                     ),
                      //
                      //                   );}
                      //                   else if(label=="guidanceAndInstructions"){  Navigator.push(
                      //                     context,
                      //                     MaterialPageRoute(
                      //                       builder: (context) => MultiBlocProvider(
                      //                         providers: [
                      //                           BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                      //                           BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                      //                           BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                      //                           BlocProvider<DoctorByCategoryCubit>(create: (_) => DoctorByCategoryCubit()),
                      //                         ],
                      //                         child: const Guidance_instructions(category: 'mentalHealth', subCategory: "إرشاد وتوجيه"),
                      //                       ),
                      //
                      //                     ),
                      //
                      //                   );}
                      //                   else if(label=="childrenDisorder"){  Navigator.push(
                      //                     context,
                      //                     MaterialPageRoute(
                      //                       builder: (context) => MultiBlocProvider(
                      //                         providers: [
                      //                           BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                      //                           BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                      //                           BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                      //                           BlocProvider<DoctorByCategoryCubit>(create: (_) => DoctorByCategoryCubit()),
                      //                         ],
                      //                         child: const ChildrensDisorderScreen(category: 'mentalHealth', subCategory: "اضطرابات الأطفال"),
                      //                       ),
                      //
                      //                     ),
                      //
                      //                   );}
                      //
                      //                 },
                      //                 child: Container(
                      //
                      //                   width: 100.w,
                      //                   height: 73.h,
                      //                   decoration: BoxDecoration(
                      //                     border: Border.all(
                      //                         color: label=="diagnoseAndMotivation" ?
                      //                         Color(0xff19649E) : Colors.transparent , width: 4),
                      //
                      //                     borderRadius: BorderRadius.circular(20),
                      //                     color: const Color(0xff69B7F3),
                      //                     boxShadow: [
                      //                       BoxShadow(
                      //                         color: Colors.black.withOpacity(0.2),
                      //                         spreadRadius: 2,
                      //                         blurRadius: 4,
                      //                         offset: const Offset(0, 2),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                   child: Center(
                      //                     child: Text(
                      //                       label.tr(),
                      //                       textAlign: TextAlign.center,
                      //                       style: TextStyle(
                      //                         fontSize: 16.sp,
                      //                         color: Colors.white,
                      //                         fontWeight: FontWeight.bold,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //               SizedBox(
                      //                 width: 2.5.w,
                      //               )
                      //             ],
                      //           ),
                      //       ],
                      //     ),
                      //     SizedBox(height: 16.h),
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //       children: [
                      //         for (var label in [
                      //           "PsychologicalPreventionAndFollowUp",
                      //           "rehabilitation"
                      //         ])
                      //           GestureDetector(
                      //             onTap: (){
                      //               if(label=="rehabilitation"){  Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                   builder: (context) => MultiBlocProvider(
                      //                     providers: [
                      //                       BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                      //                       BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                      //                       BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                      //                       BlocProvider<DoctorByCategoryCubit>(create: (_) => DoctorByCategoryCubit()),
                      //                     ],
                      //                     child: const RehabilitationScreen(category: 'mentalHealth', subCategory: "اعادة تأهيل ودعم"),
                      //                   ),
                      //
                      //                 ),
                      //
                      //               );}
                      //               else if(label=="PsychologicalPreventionAndFollowUp"){  Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                   builder: (context) => MultiBlocProvider(
                      //                     providers: [
                      //                       BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                      //                       BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                      //                       BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                      //                       BlocProvider<DoctorByCategoryCubit>(create: (_) => DoctorByCategoryCubit()),
                      //                     ],
                      //                     child: const PsychologicalPreventionScreen(category: 'mentalHealth', subCategory: "وقاية ومتابعة نفسية"),
                      //                   ),
                      //
                      //                 ),
                      //
                      //               );}
                      //
                      //             },
                      //             child: Container(
                      //               width: 120.w,
                      //               height: 73.h,
                      //               decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(20),
                      //                 color: const Color(0xff69B7F3),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.black.withOpacity(0.2),
                      //                     spreadRadius: 2,
                      //                     blurRadius: 4,
                      //                     offset: const Offset(0, 2),
                      //                   ),
                      //                 ],
                      //               ),
                      //               child: Center(
                      //                 child: Text(
                      //                   label.tr(),
                      //                   textAlign: TextAlign.center,
                      //                   style:  TextStyle(
                      //                     fontSize: 16.sp,
                      //                     color: Colors.white,
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //       ],
                      //     ),
                      //   ],
                      // )
                    ],
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
                  bottomNavigationBar: const CustomBottomNavBar(
                    currentIndex: 1,
                  ),
                  body: Column(
                    children: [
                      // Header

                      SizedBox(height: 10.h),

                      // Category List
                      SizedBox(
                        height: 32.h,
                        child: ListView.separated(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          itemCount: categories.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return SizedBox(width: screenWidth * 0.02.w);
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (index == categories.length - 1) {
                                    // Do nothing if it's the last item
                                    selectedIndex =
                                        selectedIndex; // Keep the current index
                                  } else {
                                    selectedIndex =
                                        index; // Update the selected index
                                  }
                                });

                                // Navigate only if it's not the last item
                                if (index != categories.length - 1) {
                                  Widget page;

                                  if (selectedIndex == 0) {
                                    page = const HomeScreen();
                                  } else if (selectedIndex == 1) {
                                    page = const HomeSecondScreen();
                                  } else if (selectedIndex == 2) {
                                    page = const HomeThirdScreen();
                                  } else {
                                    page = const HomeScreen();
                                  }

                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          MultiBlocProvider(
                                        providers: [
                                          BlocProvider(
                                              create: (_) =>
                                                  UserProfileCubit()),
                                          BlocProvider(
                                              create: (_) =>
                                                  DoctorByCategoryCubit()),
                                          BlocProvider(
                                              create: (_) =>
                                                  SubCategoriesCubit()),
                                          BlocProvider(
                                              create: (_) => GetAllAdsCubit()),
                                        ],
                                        child: page,
                                      ),
                                      transitionDuration:
                                          const Duration(milliseconds: 1),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                width: screenWidth * 0.35.w,
                                height: 32.h,
                                decoration: BoxDecoration(
                                  color: index == categories.length - 1
                                      ? const Color(
                                          0xffAFDCFF) // Always blue for the last item
                                      : (selectedIndex == index
                                          ? const Color(0xff19649E)
                                          : const Color(0xffD5D5D5)),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    categories[index],
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 15.h),

                      // Image Slider
                      SizedBox(
                        height: screenHeight * 0.18.h,
                        width: screenWidth * 0.9.w,
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
                      SizedBox(height: 15.h),

                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider<UserProfileCubit>(
                                          create: (_) => UserProfileCubit()),
                                      BlocProvider<AddImageToProfileCubit>(
                                          create: (_) =>
                                              AddImageToProfileCubit()),
                                      BlocProvider<UpdateUserCubit>(
                                          create: (_) => UpdateUserCubit()),
                                      BlocProvider<CreateSessionCubit>(
                                          create: (_) => CreateSessionCubit()),
                                    ],
                                    child: const FreeConsultationScreen(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: screenWidth * 0.46.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xff1F78BC),
                              ),
                              child: Center(
                                child: Text(
                                  "consultation".tr(),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider<UserProfileCubit>(
                                          create: (_) => UserProfileCubit()),
                                      BlocProvider<AddImageToProfileCubit>(
                                          create: (_) =>
                                              AddImageToProfileCubit()),
                                      BlocProvider<UpdateUserCubit>(
                                          create: (_) => UpdateUserCubit()),
                                      BlocProvider<CreateSessionCubit>(
                                          create: (_) => CreateSessionCubit()),
                                    ],
                                    child: const InstantSessionScreen(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: screenWidth * 0.45.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xff1F78BC),
                              ),
                              child: Center(
                                child: Text(
                                  "instantSession".tr(),
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
                      SizedBox(height: 15.h),
                      Center(
                        child: SizedBox(
                          width: 338.w,
                          height: 252.h,
                          child: BlocBuilder<SubCategoriesCubit,
                              SubCategoriesState>(
                            builder: (context, state) {
                              if (state is SubCategoriesLoading) {
                                return CircularProgressIndicator(); // Show loading indicator
                              } else if (state is SubCategoriesFailure) {
                                return Text(
                                    state.errMessage); // Display error message
                              } else if (state is SubCategoriesSuccess) {
                                return GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, // 3 عناصر في كل صف
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: 1.4,
                                  ),
                                  itemCount:
                                      subCategoriesCubit.categories.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (subCategoriesCubit
                                                    .categories[index] ==
                                                "Group Therapy" ||
                                            subCategoriesCubit
                                                    .categories[index] ==
                                                "علاج جماعي") {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MultiBlocProvider(
                                                providers: [
                                                  BlocProvider<
                                                          UserProfileCubit>(
                                                      create: (_) =>
                                                          UserProfileCubit()),
                                                  BlocProvider<
                                                          AddImageToProfileCubit>(
                                                      create: (_) =>
                                                          AddImageToProfileCubit()),
                                                  BlocProvider<UpdateUserCubit>(
                                                      create: (_) =>
                                                          UpdateUserCubit()),
                                                  BlocProvider<
                                                          DoctorByCategoryCubit>(
                                                      create: (_) =>
                                                          DoctorByCategoryCubit()),
                                                  BlocProvider<
                                                          SubCategoriesCubit>(
                                                      create: (_) =>
                                                          SubCategoriesCubit()),
                                                ],
                                                child: GroupTherapy(),
                                              ),
                                            ),
                                          );
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MultiBlocProvider(
                                                providers: [
                                                  BlocProvider<
                                                          UserProfileCubit>(
                                                      create: (_) =>
                                                          UserProfileCubit()),
                                                  BlocProvider<
                                                          AddImageToProfileCubit>(
                                                      create: (_) =>
                                                          AddImageToProfileCubit()),
                                                  BlocProvider<UpdateUserCubit>(
                                                      create: (_) =>
                                                          UpdateUserCubit()),
                                                  BlocProvider<
                                                          DoctorByCategoryCubit>(
                                                      create: (_) =>
                                                          DoctorByCategoryCubit()),
                                                  BlocProvider<
                                                          SubCategoriesCubit>(
                                                      create: (_) =>
                                                          SubCategoriesCubit()),
                                                ],
                                                child: SubCategoryScreen(
                                                  category: 'mentalHealth',
                                                  subCategory:
                                                      subCategoriesCubit
                                                                  .categories[
                                                              index] ??
                                                          "",
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: subCategoriesCubit
                                                          .categories[index] ==
                                                      "Problem Solving" ||
                                                  subCategoriesCubit
                                                          .categories[index] ==
                                                      "حل مشكلات"
                                              ? Border.all(
                                                  color: Color(0xff19649E),
                                                  width: 3.5)
                                              : null,
                                          color: const Color(0xff69B7F3),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            subCategoriesCubit
                                                    .categories[index] ??
                                                "",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
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
