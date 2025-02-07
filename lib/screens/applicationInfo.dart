import 'package:doctor/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:doctor/screens/sign_up_as_client.dart';
import 'package:doctor/widgets/appInfo/appDef.dart';
import 'package:doctor/widgets/appInfo/faq.dart';
import 'package:doctor/widgets/appInfo/instructions.dart';
import 'package:doctor/widgets/custom_bottom_nav_bar.dart';
import 'package:doctor/widgets/socialMediaButton.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../make_email/login.dart';
import '../models/user_profile_model.dart';
import 'first_home_page.dart';
import 'homescreen.dart';

class ApplicationInfo extends StatefulWidget {
  const ApplicationInfo({super.key});

  @override
  State<ApplicationInfo> createState() => _ApplicationInfoState();
}

class _ApplicationInfoState extends State<ApplicationInfo> {
  @override
  Widget build(BuildContext context) {
    return const SocialMediaPage();
  }
}

class SocialMediaPage extends StatefulWidget {
  const SocialMediaPage({super.key});

  @override
  _SocialMediaPageState createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  int _selectedIndex = 3;

  final List<String> tabs = [
    "التعليمات",
    "تعريف التطبيق",
    "الأسئلة الشائعة",
    "الاتصال"
  ];
  late UserProfileCubit userProfileCubit;
  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    _loadUserProfile();
  }
  int currentIndex=2;
  void openWhatsApp() async {
    String message =
        Uri.encodeComponent("هل تريد الدفع عن طريق أي وسائل أخرى؟");
    String whatsappUrl = "https://wa.me/?text=$message";

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl),
          mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch WhatsApp";
    }
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";

    // Set the state once the user profile data is fetched
    userProfileCubit.getUserProfile(context, id);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
        create: (_) => userProfileCubit,  // Use the same cubit instance
        child: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return Scaffold(body: Center(child: CircularProgressIndicator(),));
            } else if (state is UserProfileFailure) {


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
                body: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 145,
                          decoration: BoxDecoration(
                            color: const Color(0xff1B659F),
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(45),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 80,
                          left: 0,
                          right: 0,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(tabs.length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = index;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 8),
                                    margin: const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      color: _selectedIndex == index
                                          ? const Color(0xff69B7F3)
                                          : const Color(0xffA2A2A2),
                                      borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      tabs[index],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 50, 30, 50),
                          child: AppearedItemFromTabls(_selectedIndex)),
                    ),
                  ],
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
                bottomNavigationBar: const CustomBottomNavBar(
                  currentIndex: 2,
                ),
                body: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 145,
                          decoration: BoxDecoration(
                            color: const Color(0xff1B659F),
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(45),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 80,
                          left: 0,
                          right: 0,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(tabs.length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = index;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 8),
                                    margin: const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      color: _selectedIndex == index
                                          ? const Color(0xff69B7F3)
                                          : const Color(0xffA2A2A2),
                                      borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      tabs[index],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 50, 30, 50),
                          child: AppearedItemFromTabls(_selectedIndex)),
                    ),
                  ],
                ),
              );
            }
            return Container(); // Default return in case no state matches
          },
        )
    );
  }

  Widget AppearedItemFromTabls(int index) {
    switch (index) {
      case 0:
        return const InstructionTab();

      case 1:
        return const AppDef();

      case 2:
        return const FqaTab();

      case 3:
        return contactTab();

      default:
        return contactTab();
    }
  }

  Widget contactTab() {
    return Column(
      children: [
        SocialMediaButton(
          label: "واتساب",
          icon: FontAwesomeIcons.whatsapp,
          color: Colors.green,
          onPressed: openWhatsApp,
        ),
        SocialMediaButton(
          label: "فيسبوك",
          icon: FontAwesomeIcons.facebook,
          color: Colors.blue,
          onPressed: openWhatsApp,
        ),
        SocialMediaButton(
          label: "إنستجرام",
          icon: FontAwesomeIcons.instagram,
          color: Colors.pink,
          onPressed: openWhatsApp,
        ),
        SocialMediaButton(
          label: "تويتر",
          icon: FontAwesomeIcons.twitter,
          color: Colors.lightBlue,
          onPressed: openWhatsApp,
        ),
        SocialMediaButton(
          label: "يوتيوب",
          icon: FontAwesomeIcons.youtube,
          color: Colors.red,
          onPressed: openWhatsApp,
        ),
      ],
    );
  }
}
