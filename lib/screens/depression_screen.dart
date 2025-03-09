import 'package:doctor/models/sessionType.dart';
import 'package:doctor/screens/sign_up_as_client.dart';
import 'package:doctor/screens/specialists_screen.dart';
import 'package:doctor/widgets/custom_bottom_nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import '../cubit/update_user_cubit/update_user_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../make_email/login.dart';
import '../models/user_profile_model.dart';
import 'applicationInfo.dart';
import 'first_home_page.dart';
import 'homescreen.dart';

class DepressionScreen extends StatefulWidget {
  const DepressionScreen({super.key});

  @override
  State<DepressionScreen> createState() => _DepressionScreenState();
}

class _DepressionScreenState extends State<DepressionScreen> {
  late UserProfileCubit userProfileCubit;

  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    _loadUserProfile();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";
    userProfileCubit.getUserProfile(context, id);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    int currentIndex = 1;
    return BlocProvider(
        create: (_) => userProfileCubit, // Use the same cubit instance
        child: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return Scaffold(
                  body: Center(
                child: CircularProgressIndicator(),
              ));
            } else if (state is UserProfileFailure) {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.keyboard_backspace_rounded,
                      size: 30,
                    ),
                    color: Color(0xff19649E),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
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
                                "depression".tr(),
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.02.h),
                        // "أهمية البرامج" Section
                        Text(
                          "importanceOfPrograms".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.01.h),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            initialValue: "depPlanDesc".tr(),
                            maxLines:
                                null, // Allows the field to expand for multiline input
                            style: TextStyle(fontSize: 14.sp, height: 1.6.h),

                            decoration: const InputDecoration(
                              alignLabelWithHint: true,
                              border: InputBorder.none, // Removes the underline
                              contentPadding: EdgeInsets
                                  .zero, // Matches the original padding
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight.h * 0.03.h),
                        // "الخطة / العلاج" Section
                        Text(
                          "planSection".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.01.h),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 35),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            maxLines:
                                null, // Allows the field to expand for multiline input
                            style: TextStyle(fontSize: 14.sp, height: 1.6.h),
                            decoration: const InputDecoration(
                              border: InputBorder.none, // Removes the underline
                              contentPadding: EdgeInsets
                                  .zero, // Matches the original padding
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.03.h),
                        // "الأهداف" Section
                        Text(
                          "goals".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.01.h),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 35),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            maxLines:
                                null, // Allows the field to expand for multiline input
                            style: TextStyle(fontSize: 14.sp, height: 1.6.h),
                            decoration: const InputDecoration(
                              border: InputBorder.none, // Removes the underline
                              contentPadding: EdgeInsets
                                  .zero, // Matches the original padding
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.045.h),
                        // ""المراحل"" Section
                        Text(
                          "stages".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.01.h),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            maxLines:
                                null, // Allows the field to expand for multiline input
                            style: TextStyle(fontSize: 14.sp, height: 1.6.h),
                            decoration: const InputDecoration(
                              border: InputBorder.none, // Removes the underline
                              contentPadding: EdgeInsets
                                  .zero, // Matches the original padding
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.03.h),
                        // ""التقنيات"" Section
                        Text(
                          "techniques".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.01.h),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            maxLines:
                                null, // Allows the field to expand for multiline input
                            style: TextStyle(fontSize: 14.sp, height: 1.6.h),
                            decoration: const InputDecoration(
                              border: InputBorder.none, // Removes the underline
                              contentPadding: EdgeInsets
                                  .zero, // Matches the original padding
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.03.h),
                        // "الأهداف" Section
                        Text(
                          "sessions".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.01.h),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            maxLines:
                                null, // Allows the field to expand for multiline input
                            style: TextStyle(fontSize: 14.sp, height: 1.6.h),
                            decoration: const InputDecoration(
                              border: InputBorder.none, // Removes the underline
                              contentPadding: EdgeInsets
                                  .zero, // Matches the original padding
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.03.h),
                        // "الأهداف" Section
                        Text(
                          "trainSkill".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.01.h),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            maxLines:
                                null, // Allows the field to expand for multiline input
                            style: TextStyle(fontSize: 14.sp, height: 1.6.h),
                            decoration: const InputDecoration(
                              border: InputBorder.none, // Removes the underline
                              contentPadding: EdgeInsets
                                  .zero, // Matches the original padding
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.05.h),
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
                                  ],
                                  child: SpecialistsScreen(
                                    sessionType: RegularSession(),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: screenWidth.w * 0.9.w,
                            height: 48.h,
                            decoration: BoxDecoration(
                              color: Color(0xff19649E),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "continue".tr(),
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.03.h),
                      ],
                    ),
                  ),
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
                            content: Text(
                              "guestAccessibilityAlert".tr(),
                            ),
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
              );
            } else if (state is UserProfileSuccess) {
              // Once the profile is loaded, show the actual UI
              UserProfileModel userProfile = state.userProfile;

              // return BlocBuilder<UserProfileCubit, UserProfileState>(
              //   builder: (context, state) {
              //     if (state is UserProfileLoading) {
              //       return Scaffold(body: Center(child: CircularProgressIndicator()));
              //     } else if (state is UserProfileFailure) {
              //       return Center(child: Text("Error loading profile: ${state.error}"));
              //     } else if (state is UserProfileSuccess) {
              //       UserProfileModel userProfile = state.userProfile;

              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.keyboard_backspace_rounded,
                      size: 30,
                    ),
                    color: Color(0xff19649E),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
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
                                "depression".tr(),
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.02.h),
                        // "أهمية البرامج" Section
                        Text(
                          "importanceOfPrograms".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.01.h),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            initialValue: "depPlanDesc".tr(),
                            maxLines:
                                null, // Allows the field to expand for multiline input
                            style: TextStyle(fontSize: 14.sp, height: 1.6.h),

                            decoration: const InputDecoration(
                              alignLabelWithHint: true,
                              border: InputBorder.none, // Removes the underline
                              contentPadding: EdgeInsets
                                  .zero, // Matches the original padding
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight.h * 0.03.h),
                        // "الخطة / العلاج" Section
                        Text(
                          "planSection".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.01.h),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 35),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            maxLines:
                                null, // Allows the field to expand for multiline input
                            style: TextStyle(fontSize: 14.sp, height: 1.6),
                            decoration: const InputDecoration(
                              border: InputBorder.none, // Removes the underline
                              contentPadding: EdgeInsets
                                  .zero, // Matches the original padding
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.03.h),
                        // "الأهداف" Section
                        Text(
                          "goals".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.01.h),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 35),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            maxLines:
                                null, // Allows the field to expand for multiline input
                            style: TextStyle(fontSize: 14.sp, height: 1.6.h),
                            decoration: const InputDecoration(
                              border: InputBorder.none, // Removes the underline
                              contentPadding: EdgeInsets
                                  .zero, // Matches the original padding
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.045.h),
                        // "الأهداف" Section
                        Text(
                          "stages".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.01.h),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            maxLines:
                                null, // Allows the field to expand for multiline input
                            style: TextStyle(fontSize: 14.sp, height: 1.6.h),
                            decoration: const InputDecoration(
                              border: InputBorder.none, // Removes the underline
                              contentPadding: EdgeInsets
                                  .zero, // Matches the original padding
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.03.h),
                        // "الأهداف" Section
                        Text(
                          "techniques".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.01.h),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            maxLines:
                                null, // Allows the field to expand for multiline input
                            style: TextStyle(fontSize: 14.sp, height: 1.6.h),
                            decoration: const InputDecoration(
                              border: InputBorder.none, // Removes the underline
                              contentPadding: EdgeInsets
                                  .zero, // Matches the original padding
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.03.h),
                        // "الأهداف" Section
                        Text(
                          "sessions".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.01.h),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            maxLines:
                                null, // Allows the field to expand for multiline input
                            style: TextStyle(fontSize: 14.sp, height: 1.6.h),
                            decoration: const InputDecoration(
                              border: InputBorder.none, // Removes the underline
                              contentPadding: EdgeInsets
                                  .zero, // Matches the original padding
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.03.h),
                        // "الأهداف" Section
                        Text(
                          "trainSkill".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.01.h),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            maxLines:
                                null, // Allows the field to expand for multiline input
                            style: TextStyle(fontSize: 14.sp, height: 1.6.h),
                            decoration: const InputDecoration(
                              border: InputBorder.none, // Removes the underline
                              contentPadding: EdgeInsets
                                  .zero, // Matches the original padding
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.05.h),
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
                                  ],
                                  child: SpecialistsScreen(
                                    sessionType: RegularSession(),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Center(
                            child: Container(
                              width: screenWidth.w * 0.9.w,
                              height: 48.h,
                              decoration: BoxDecoration(
                                color: Color(0xff19649E),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "continue".tr(),
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight.h * 0.03.h),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: CustomBottomNavBar(currentIndex: 1),
              );
            }
            return Container(); // Default return in case no state matches
          },
        ));
  }
}
