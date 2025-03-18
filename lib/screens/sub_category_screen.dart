import 'dart:developer';

import 'package:doctor/cubit/get_specialist/get_sepcialist_cubit.dart';
import 'package:doctor/cubit/get_sub_sub_catrgory_cubit/get_sub_sub_category_cubit.dart';

import 'package:doctor/models/catgoryInfo.dart';
import 'package:doctor/models/sessionType.dart';

import 'package:doctor/cubit/get_treatment_program_cubit/get_treatment_program_cubit.dart';

import 'package:doctor/screens/anxiety_screen.dart';
import 'package:doctor/screens/personality_disorder_screen.dart';
import 'package:doctor/screens/sign_up_as_client.dart';
import 'package:doctor/screens/sub_sub_category_screen.dart';
import 'package:doctor/widgets/custom_app_bar.dart';
import 'package:doctor/widgets/custom_bottom_nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import '../cubit/doctor_by_category_cubit/doctor_by_category_cubit.dart';
import '../cubit/doctor_by_category_cubit/doctor_by_category_state.dart';
import '../cubit/get_specialist/get_specialist_state.dart';
import '../cubit/get_sub_categories_cubit/get_sub_categories_cubit.dart';
import '../cubit/get_sub_categories_cubit/get_sub_categories_state.dart';
import '../cubit/update_user_cubit/update_user_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../make_email/login.dart';
import '../models/user_profile_model.dart';
import '../widgets/doctor_card.dart';
import 'applicationInfo.dart';
import 'depression_screen.dart';
import 'first_home_page.dart';
import 'homescreen.dart';

class SubCategoryScreen extends StatefulWidget {
  final String category;
  final String subCategory;

  const SubCategoryScreen(
      {super.key, required this.category, required this.subCategory});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  late UserProfileCubit userProfileCubit;
  late DoctorByCategoryCubit doctorByCategoryCubit;
  late SubCategoriesCubit subCategoriesCubit;
  List<String> sub=[];
  @override
  void initState() {
    super.initState();

    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    doctorByCategoryCubit = BlocProvider.of<DoctorByCategoryCubit>(context);
    subCategoriesCubit = BlocProvider.of<SubCategoriesCubit>(context);
    _loadUserProfile();
  }

  int currentIndex = 1;
  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";
    userProfileCubit.getUserProfile(context, id);

    subCategoriesCubit.fetchSubCategories(context,widget.category);
    List<String> subs1 = subCategoriesCubit.model
        ?.firstWhere((sub) =>
    sub.name == widget.subCategory)
        .subcategory ??
        [];
    sub=subs1;
    Map<String, String> subCategoryMapping = {
      "Psychological Disorders": "اضطرابات نفسية",
      "Personality Disorder": "اضطراب شخصي",
      "Addiction": "الادمان",
      "Trauma Disorder": "اضطراب الصدمة",
      "Therapeutic Programs": "برامج علاجية",
      "Group Therapy": "علاج جماعي",
      "Childhood Disorders": "اضطرابات الأطفال",
      "Problem Solving": "حل مشكلات",
      "Guidance and Counseling": "ارشاد وتوجيه",
      "Prevention and Psychological Follow-up": "وقاية ومتابعة نفسية",
      "Rehabilitation and Support": "اعادة تأهيل ودعم",
      "Diet Plan": "نظام غذائي",
      "Exercise Plan": "نظام رياضي",
      "Regular Check-ups": "فحوص دورية",
      "Health Care": "عناية صحية",
      "Relaxation": "الاسترخاء",
      "Stress Management": "تحمل الضغوط",
      "Emotional Control": "ضبط المشاعر",
      "Dialectical Strategies": "استراتيجيات جدلية حل",
      "Achieving Balance": "تحقيق التوازن",
      "Improving Confidence": "تحسين الثقة",
      "Achieving Goals": "تحقيق الأهداف",
      "Achieving Success": "تحقيق النجاح",
      "Effective Relationships": "العلاقات الفعالة"
    };

// التحقق مما إذا كان النص بالإنجليزية أم العربية
    bool isEnglish(String text) {
      final englishRegex = RegExp(r'^[A-Za-z\s]+$');
      return englishRegex.hasMatch(text);
    }

// إذا كانت إنجليزية، يتم الترجمة، وإلا تبقى كما هي
    String translatedSubCategory = isEnglish(widget.subCategory)
        ? (subCategoryMapping[widget.subCategory] ?? widget.subCategory)
        : widget.subCategory;

// استدعاء الدالة مع الفئة المترجمة
    doctorByCategoryCubit.fetchSpecialistsbycategory(widget.category, translatedSubCategory,context);

    doctorByCategoryCubit.fetchSpecialistsbycategory(widget.category,widget.subCategory,context);

  }

  @override
  Widget build(BuildContext context) {

    print(
        "-----------**********************************----------------------");

    print(widget.category + widget.subCategory);
    double screenWidth = MediaQuery.of(context).size.width.w;
    double screenHeight = MediaQuery.of(context).size.height.h;
    bool isEnglish = Localizations.localeOf(context).languageCode == 'en';

    return BlocProvider(
      create: (_) => userProfileCubit,
      child: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is UserProfileFailure) {
            return Scaffold(
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
                        color: currentIndex == 0 ? Colors.white : Colors.black,
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
                          builder: (context) => BlocProvider(
                            create: (_) => UserProfileCubit(),
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
              appBar: CustomAppBar(
                screenWidth: screenWidth.w,
                screenHeight: screenHeight.h,
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      Center(
                        child: BlocBuilder<SubCategoriesCubit, SubCategoriesState>(
                          builder: (context, state) {
                            if (state is SubCategoriesLoading) {
                              return CircularProgressIndicator(); // Show loading indicator
                            } else if (state is SubCategoriesFailure) {
                              return Text(
                                  state.errMessage); // Display error message
                            } else if (state is SubCategoriesSuccess) {
                              List<String> subs = state.subCategories
                                  ?.firstWhere((sub) =>
                              sub.name == widget.subCategory)
                                  .subcategory ??
                                  [];
                              return  subs.isEmpty||subs==null?SizedBox(): Container(
                                width: 200.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color: Color(0xFF1F78BC),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      topLeft: Radius.circular(20)),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  widget.subCategory,
                                  style: TextStyle(
                                      fontSize: isEnglish ? 17.sp : 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              );
                            } else {
                              return Center(
                                  child: Text('noSpecialistsFound'.tr()));
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        child: BlocBuilder<SubCategoriesCubit, SubCategoriesState>(
                          builder: (context, state) {
                            if (state is SubCategoriesLoading) {
                              return CircularProgressIndicator(); // Show loading indicator
                            } else if (state is SubCategoriesFailure) {
                              return Text(
                                  state.errMessage); // Display error message
                            } else if (state is SubCategoriesSuccess) {
                              List<String> subs = state.subCategories
                                  ?.firstWhere((sub) =>
                              sub.name == widget.subCategory)
                                  .subcategory ??
                                  [];
                              return  subs.isEmpty||subs==null?SizedBox(): SizedBox(
                                height: 40.h,
                              );
                            } else {
                              return Center(
                                  child: Text('noSpecialistsFound'.tr()));
                            }
                          },
                        ),
                      ),
                      Center(
                        child: BlocBuilder<SubCategoriesCubit, SubCategoriesState>(
                          builder: (context, state) {
                            if (state is SubCategoriesLoading) {
                              return CircularProgressIndicator(); // Show loading indicator
                            } else if (state is SubCategoriesFailure) {
                              return Text(
                                  state.errMessage); // Display error message
                            } else if (state is SubCategoriesSuccess) {
                              List<String> subs = state.subCategories
                                      ?.firstWhere((sub) =>
                                          sub.name == widget.subCategory)
                                      .subcategory ??
                                  [];
                              return  subs.isEmpty||subs==null?SizedBox(): SizedBox(
                                width: 338.w,
                                height: 252.h,
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, // 3 items per row
                                    crossAxisSpacing:
                                        8, // spacing between columns
                                    mainAxisSpacing: 8, // spacing between rows
                                    childAspectRatio:
                                        1.5, // aspect ratio of the grid items
                                  ),
                                  itemCount:
                                      subs.length, // total number of items
                                  itemBuilder: (context, index) {

                                    return  GestureDetector(
                                      onTap: () {
                                        print("Clicked on: ${subs[index]}");

                                        if (subs[index] == "Depression" || subs[index] == "الاكتئاب") {
                                          print("Navigating to DepressionScreen");

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
                                                          SubSubCategoriesCubit>(
                                                      create: (_) =>
                                                          SubSubCategoriesCubit()),

                                                ],
                                                child: DepressionScreen(),
                                              ),
                                            ),
                                          );

                                        } else if (subs[index] == "Anxiety" || subs[index] == "القلق") {
                                          print("Navigating to AnxietyScreen");

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
                                                          SubSubCategoriesCubit>(
                                                      create: (_) =>
                                                          SubSubCategoriesCubit()),

                                                ],
                                                child: AnxietyScreen(),
                                              ),
                                            ),
                                          );
                                        } else {

                                          print("Navigating to SubSubCategoryScreen with: ${subs[index]}");
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MultiBlocProvider(
                                                providers: [
                                                  BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                                                  BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                                                  BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                                                  BlocProvider<DoctorByCategoryCubit>(create: (_) => DoctorByCategoryCubit()),
                                                  BlocProvider<SubSubCategoriesCubit>(create: (_) => SubSubCategoriesCubit()),
                                                ],
                                                child: SubSubCategoryScreen(Category: 'mentalHealth', subCategory: subs[index] ?? ""),

                                              ),
                                            ),
                                          );
                                        }
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
                                            subs[index],
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
                                ),
                              );
                            } else {
                              return Center(
                                  child: Text('noSpecialistsFound'.tr()));
                            }
                          },
                        ),
                      )

                      ,
                      SizedBox(
                        height: 30.h,
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 25),
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
                            "specialists".tr(),
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      // List of doctors
                      BlocBuilder<DoctorByCategoryCubit, DoctorByCategoryState>(
                        builder: (context, state) {
                          if (state is DoctorByCategoryLoading) {
                            return CircularProgressIndicator(); // Show loading indicator
                          } else if (state is DoctorByCategoryFailure) {
                            return Text(
                                state.errMessage); // Display error message
                          } else if (state is DoctorByCategorySuccess) {
                            return Container(
                              height: screenHeight * 0.63.h,
                              child: ListView.builder(
                                itemCount: state.specialists.length,
                                itemBuilder: (context, index) {
                                  return DoctorCard(
                                    sessionType:
                                        RegularSession(), /////////////////////
                                    categoryInfo: CategoryInfo(
                                        pubCategory: widget.category,
                                        subCategory: widget.subCategory),
                                    specialists: state.specialists[index],
                                    doctorID: state.specialists[index].id ?? "",
                                  );
                                },
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
                ),
              ),
            );
          } else if (state is UserProfileSuccess) {
            UserProfileModel userProfile = state.userProfile;
            return Scaffold(
              bottomNavigationBar: CustomBottomNavBar(currentIndex: 1),
              appBar: CustomAppBar(
                userProfile: userProfile,
                screenWidth: screenWidth.w,
                screenHeight: screenHeight.h,
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: BlocBuilder<SubCategoriesCubit, SubCategoriesState>(
                          builder: (context, state) {
                            if (state is SubCategoriesLoading) {
                              return CircularProgressIndicator(); // Show loading indicator
                            } else if (state is SubCategoriesFailure) {
                              return Text(
                                  state.errMessage); // Display error message
                            } else if (state is SubCategoriesSuccess) {
                              List<String> subs = state.subCategories
                                  ?.firstWhere((sub) =>
                              sub.name == widget.subCategory)
                                  .subcategory ??
                                  [];
                              return  subs.isEmpty||subs==null?SizedBox(): Container(
                                width: 200.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color: Color(0xFF1F78BC),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      topLeft: Radius.circular(20)),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  widget.subCategory,
                                  style: TextStyle(
                                      fontSize: isEnglish ? 17.sp : 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              );
                            } else {
                              return Center(
                                  child: Text('noSpecialistsFound'.tr()));
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        child: BlocBuilder<SubCategoriesCubit, SubCategoriesState>(
                          builder: (context, state) {
                            if (state is SubCategoriesLoading) {
                              return CircularProgressIndicator(); // Show loading indicator
                            } else if (state is SubCategoriesFailure) {
                              return Text(
                                  state.errMessage); // Display error message
                            } else if (state is SubCategoriesSuccess) {
                              List<String> subs = state.subCategories
                                  ?.firstWhere((sub) =>
                              sub.name == widget.subCategory)
                                  .subcategory ??
                                  [];
                              return  subs.isEmpty||subs==null?SizedBox(): SizedBox(
                                height: 40.h,
                              );
                            } else {
                              return Center(
                                  child: Text('noSpecialistsFound'.tr()));
                            }
                          },
                        ),
                      ),

                      Center(
                        child: BlocBuilder<SubCategoriesCubit,
                            SubCategoriesState>(
                          builder: (context, state) {
                            if (state is SubCategoriesLoading) {
                              return CircularProgressIndicator(); // Show loading indicator
                            } else if (state is SubCategoriesFailure) {
                              return Text(
                                  state.errMessage); // Display error message
                            } else if (state is SubCategoriesSuccess) {
                              List<String> subs = state.subCategories
                                      ?.firstWhere((sub) =>
                                          sub.name == widget.subCategory)
                                      .subcategory ??
                                  [];
                              return subs.isEmpty||subs==null? SizedBox():SizedBox(

                                width: 338.w,
                                height: 252.h,
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, // 3 items per row
                                    crossAxisSpacing:
                                        8, // spacing between columns
                                    mainAxisSpacing: 8, // spacing between rows
                                    childAspectRatio:
                                        1.4, // aspect ratio of the grid items
                                  ),
                                  itemCount:
                                      subs.length, // total number of items
                                  itemBuilder: (context, index) {

                                    return  GestureDetector(
                                      onTap: () {
                                        print("Clicked on: ${subs[index]}");

                                        if (subs[index] == "Depression" || subs[index] == "الاكتئاب") {
                                          print("Navigating to DepressionScreen");
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MultiBlocProvider(
                                                providers: [
                                                  BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                                                  BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                                                  BlocProvider<GetTreatmentProgramCubit>(create: (_) => GetTreatmentProgramCubit()),
                                                  BlocProvider<DoctorByCategoryCubit>(create: (_) => DoctorByCategoryCubit()),
                                                  BlocProvider<SubSubCategoriesCubit>(create: (_) => SubSubCategoriesCubit()),
                                                ],
                                                child: DepressionScreen(),
                                              ),
                                            ),
                                          );
                                        } else if (subs[index] == "Anxiety" || subs[index] == "القلق") {
                                          print("Navigating to AnxietyScreen");
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MultiBlocProvider(
                                                providers: [
                                                  BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                                                  BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                                                  BlocProvider<GetTreatmentProgramCubit>(create: (_) => GetTreatmentProgramCubit()),
                                                  BlocProvider<DoctorByCategoryCubit>(create: (_) => DoctorByCategoryCubit()),
                                                  BlocProvider<SubSubCategoriesCubit>(create: (_) => SubSubCategoriesCubit()),
                                                ],
                                                child: AnxietyScreen(),
                                              ),
                                            ),
                                          );
                                        } else {
                                          print("Navigating to SubSubCategoryScreen with: ${subs[index]}");
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MultiBlocProvider(
                                                providers: [
                                                  BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                                                  BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                                                  BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                                                  BlocProvider<DoctorByCategoryCubit>(create: (_) => DoctorByCategoryCubit()),
                                                  BlocProvider<SubSubCategoriesCubit>(create: (_) => SubSubCategoriesCubit()),
                                                ],
                                                child: SubSubCategoryScreen(Category: 'mentalHealth', subCategory: subs[index] ?? ""),
                                              ),
                                            ),
                                          );
                                        }

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
                                            subs[index],
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
                                ),
                              );
                            } else {
                              return Center(
                                  child: Text('noSpecialistsFound'.tr()));
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
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
                            "specialists".tr(),
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      // List of doctors
                      BlocBuilder<DoctorByCategoryCubit, DoctorByCategoryState>(
                        builder: (context, state) {
                          if (state is DoctorByCategoryLoading) {
                            return CircularProgressIndicator(); // Show loading indicator
                          } else if (state is DoctorByCategoryFailure) {
                            return Text(
                                state.errMessage); // Display error message
                          } else if (state is DoctorByCategorySuccess) {
                            return Container(
                              height: screenHeight * 0.63.h,
                              child: ListView.builder(
                                itemCount: state.specialists.length,
                                itemBuilder: (context, index) {
                                  return DoctorCard(
                                    sessionType: RegularSession(),
                                    categoryInfo: CategoryInfo(
                                        pubCategory: widget.category,
                                        subCategory: widget.subCategory),
                                    specialists: state.specialists[index],
                                    doctorID: state.specialists[index].id ?? "",
                                  );
                                },
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
                ),
              ),
            );
          }
          return Container(); // Default return in case no state matches
        },
      ),
    );
  }

  // Helper method to build disorder buttons
  Widget _buildDisorderButton(String title) {
    return Container(
      width: 105.w,
      height: 68.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff69B7F3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          title,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
