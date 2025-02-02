import 'package:doctor/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:doctor/widgets/appInfo/appDef.dart';
import 'package:doctor/widgets/appInfo/faq.dart';
import 'package:doctor/widgets/appInfo/instructions.dart';
import 'package:doctor/widgets/custom_bottom_nav_bar.dart';
import 'package:doctor/widgets/socialMediaButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return Scaffold(
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
                                ? Color(0xff69B7F3)
                                : Color(0xffA2A2A2),
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
                padding: const EdgeInsets.all(16.0),
                child: AppearedItemFromTabls(_selectedIndex)),
          ),
        ],
      ),
    );
  }

  Widget AppearedItemFromTabls(int index) {
    switch (index) {
      case 0:
        return InstructionTab();

      case 1:
        return AppDef();

      case 2:
        return FqaTab();

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
