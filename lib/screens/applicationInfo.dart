import 'package:doctor/core/strings.dart';
import 'package:doctor/widgets/appInfo/appDef.dart';
import 'package:doctor/widgets/appInfo/faq.dart';
import 'package:doctor/widgets/appInfo/instructions.dart';
import 'package:doctor/widgets/custom_bottom_nav_bar.dart';
import 'package:doctor/widgets/socialMediaButton.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

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
  int _selectedIndex = 0;

  final List<String> tabs = [
    "contactLinks".tr(),
    "fqa".tr(),
    "AppDef".tr(),
    "instructions".tr(),
  ];
  // late UserProfileCubit userProfileCubit;
  // @override
  // void initState() {
  //   super.initState();
  //   userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
  //   _loadUserProfile();
  // }

  void openWhatsApp() async {
    String message = Uri.encodeComponent("contactMssgForWhats".tr());
    String whatsappUrl = "https://wa.me/${contactNumber}?text=$message";

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl),
          mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch WhatsApp";
    }
  }

  void _openGmail(String email) async {
    String emailUrl = Uri.encodeFull(
        "mailto:$email?subject=${"titleOfEmail".tr()}&body=${"contactMssgForWhats".tr()}");

    if (await canLaunchUrl(Uri.parse(emailUrl))) {
      await launchUrl(Uri.parse(emailUrl),
          mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open Gmail';
    }
  }
  // Future<void> _loadUserProfile() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String id = prefs.getString('userId') ?? "";
  //
  //   // Set the state once the user profile data is fetched
  //   userProfileCubit.getUserProfile(context, id);
  // }

  @override
  Widget build(BuildContext context) {
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
                height: 145.h,
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
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
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
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: AppearedItemFromTabls(_selectedIndex)),
          ),
        ],
      ),
    );
  }

  Widget AppearedItemFromTabls(int index) {
    switch (index) {
      case 3:
        return const InstructionTab();

      case 2:
        return const AppDef();

      case 1:
        return const FqaTab();

      case 0:
        return contactTab();

      default:
        return contactTab();
    }
  }

  Widget contactTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SocialMediaButton(
            label: "whatsApp".tr(),
            icon: FontAwesomeIcons.whatsapp,
            color: Colors.green,
            onPressed: openWhatsApp,
          ),
          SocialMediaButton(
            label: "facebook".tr(),
            icon: FontAwesomeIcons.facebook,
            color: Colors.blue,
            onPressed: () {},
          ),
          SocialMediaButton(
              label: "instagram".tr(),
              icon: FontAwesomeIcons.instagram,
              color: Colors.pink,
              onPressed: () {}),
          SocialMediaButton(
            label: "twitter".tr(),
            icon: FontAwesomeIcons.twitter,
            color: Colors.lightBlue,
            onPressed: () {},
          ),
          SocialMediaButton(
            label: "youTube".tr(),
            icon: FontAwesomeIcons.youtube,
            color: Colors.red,
            onPressed: () {},
          ),
          SocialMediaButton(
            label: "wellbeingallday@gmail.com",
            icon: FontAwesomeIcons.google,
            color: Colors.orange,
            onPressed: () => _openGmail("wellbeingallday@gmail.com"),
          ),
          SocialMediaButton(
            label: "wellbeingallday@outlook.com",
            icon: FontAwesomeIcons.microsoft,
            color: Colors.blue,
            onPressed: () => _openGmail("wellbeingallday@outlook.com"),
          ),
          Container(
            height: 60.h,
            decoration: BoxDecoration(
              color: const Color(0xFFAFDCFF),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Center(
              child: Expanded(
                child: Text(
                  textAlign: TextAlign.center,
                  "address1".tr(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 60.h,
            decoration: BoxDecoration(
              color: const Color(0xFFAFDCFF),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Center(
              child: Expanded(
                child: Text(
                  textAlign: TextAlign.center,
                  "address2".tr(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
