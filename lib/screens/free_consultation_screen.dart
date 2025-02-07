import 'package:doctor/screens/sign_up_as_client.dart';
import 'package:doctor/widgets/custom_bottom_nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../make_email/login.dart';
import '../models/user_profile_model.dart';
import '../widgets/custom_app_bar.dart';
import 'applicationInfo.dart';
import 'first_home_page.dart';
import 'homescreen.dart';

class FreeConsultationScreen extends StatefulWidget {
  const FreeConsultationScreen({super.key});

  @override
  State<FreeConsultationScreen> createState() => _FreeConsultationScreenState();
}

class _FreeConsultationScreenState extends State<FreeConsultationScreen> {
  late UserProfileCubit userProfileCubit;

  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    _loadUserProfile();
  }
  int currentIndex=1;
  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";
    userProfileCubit.getUserProfile(context, id);
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
                  bottomNavigationBar:BottomNavigationBar(
                    backgroundColor: const Color(0xff19649E), // Ensures the background is consistent
                    selectedItemColor: Colors.white, // Sets the color of the selected icons
                    unselectedItemColor: Colors.black, // Sets the color of unselected icons
                    showSelectedLabels: false, // Hides selected labels
                    showUnselectedLabels: false, // Hides unselected labels
                    currentIndex: currentIndex, // Default selected index
                    type: BottomNavigationBarType.fixed, // Prevents animation on shifting types
                    items: [
                      BottomNavigationBarItem(
                        icon: SizedBox(
                          height: 27, // Adjust icon size
                          child:
                          Image.asset(
                            "assets/images/meteor-icons_home.png",
                            // color: currentIndex == 0 ? Colors.white : Colors.black,
                            fit: BoxFit.fill,
                          ),
                        ),
                        activeIcon: SizedBox(
                          height: 27, // Active icon size adjustment
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
                          height: 27,
                          child: Image.asset(
                            "assets/images/nrk_category1.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        activeIcon: SizedBox(
                          height: 27,
                          child: Image.asset(
                            "assets/images/nrk_category.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        label: "menu".tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: SizedBox(
                          height: 25, // Adjust icon size
                          child: Image.asset(
                            "assets/images/material-symbols_help-clinic-outline-rounded.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        activeIcon: SizedBox(
                          height: 33,
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
                          height: 27,
                          child: Image.asset(
                            "assets/images/gg_profile.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        activeIcon: SizedBox(
                          height: 27,
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
                              title: Text("تنبيه"),
                              content: Text("يجب عليك تسجيل الدخول أو إنشاء حساب للوصول إلى هذه الصفحة."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // إغلاق الـ Alert
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => LoginPage()), // استبدليها بصفحة تسجيل الدخول
                                    );
                                  },
                                  child: Text("تسجيل الدخول"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // إغلاق الـ Alert
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SignUpAsClient()), // استبدليها بصفحة التسجيل
                                    );
                                  },
                                  child: Text("إنشاء حساب"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // إغلاق الـ Alert بدون أي انتقال
                                  },
                                  child: Text("إلغاء"),
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

                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ApplicationInfo()));

                          break;

                        case 0:

                          Navigator.push(context, MaterialPageRoute(builder: (context) => const FirstHomePage()));

                          break;
                      }
                    },
                  ),
                  appBar: CustomAppBar(

                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0,top: 15),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),

                                child: Center(
                                  child: Container(
                                    width: 161,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF1F78BC),
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "إستشاره مجانيه",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: screenWidth * 0.9,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "عبر عن حالتك بشكل مختصر",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff19649E)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                width:screenWidth* 0.9,
                                height: 180,
                                child: TextFormField(

                                  decoration: InputDecoration(
                                    hintText: "ما هو شعورك؟ أكتب وصفاً قصيراً لحالتك لعرضها على المختص",
                                    hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
                                    filled: true,
                                    fillColor: Color(0xFFD5D5D5),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(12)),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                  ),
                                  maxLines: 10,
                                ),
                              ),
                              SizedBox(height: 15),
                              Container(
                                width: screenWidth * 0.9,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "شروط الجلسه",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff1F78BC)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 7),
                              Column(
                                children: [
                                  Row(

                                    children: [
                                      Icon(Icons.circle, size: 10, color: Colors.black),
                                      SizedBox(width: 5),
                                      Text("ستكون مده الإستشاره 15 دقيقه"),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(

                                    children: [
                                      Icon(Icons.circle, size: 10, color: Colors.black),
                                      SizedBox(width: 5),
                                      Text("عند الحاجه للتوجيه للعلاج او الأخصائي المناسب"),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(

                                    children: [
                                      Icon(Icons.circle, size: 10, color: Colors.black),
                                      SizedBox(width: 5),
                                      Text("عند عدم وضوح الحاله النفسيه او الجسديه"),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: Container(
                            width: screenWidth* 0.9,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Color(0xff19649E),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'إستمرار',
                                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is UserProfileSuccess) {
                UserProfileModel userProfile = state.userProfile;
                return Scaffold(
                  bottomNavigationBar: CustomBottomNavBar(currentIndex: 1),
                  appBar: CustomAppBar(
                    userProfile: userProfile,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                    
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0,top: 15),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                    
                                child: Center(
                                  child: Container(
                                    width: 161,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF1F78BC),
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "إستشاره مجانيه",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: screenWidth * 0.9,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "عبر عن حالتك بشكل مختصر",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff19649E)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                width:screenWidth* 0.9,
                                height: 180,
                                child: TextFormField(
                    
                                  decoration: InputDecoration(
                                    hintText: "ما هو شعورك؟ أكتب وصفاً قصيراً لحالتك لعرضها على المختص",
                                    hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
                                    filled: true,
                                    fillColor: Color(0xFFD5D5D5),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(12)),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                  ),
                                  maxLines: 10,
                                ),
                              ),
                              SizedBox(height: 15),
                              Container(
                                width: screenWidth * 0.9,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "شروط الجلسه",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff1F78BC)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 7),
                              Column(
                                children: [
                                  Row(
                    
                                    children: [
                                      Icon(Icons.circle, size: 10, color: Colors.black),
                                      SizedBox(width: 5),
                                      Text("ستكون مده الإستشاره 15 دقيقه"),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                    
                                    children: [
                                      Icon(Icons.circle, size: 10, color: Colors.black),
                                      SizedBox(width: 5),
                                      Text("عند الحاجه للتوجيه للعلاج او الأخصائي المناسب"),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                    
                                    children: [
                                      Icon(Icons.circle, size: 10, color: Colors.black),
                                      SizedBox(width: 5),
                                      Text("عند عدم وضوح الحاله النفسيه او الجسديه"),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: Container(
                            width: screenWidth* 0.9,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Color(0xff19649E),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'إستمرار',
                                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
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
