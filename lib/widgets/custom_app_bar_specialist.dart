import 'package:doctor/models/Doctor_id_model.dart';
import 'package:doctor/screens/notificationsScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/user_profile_model.dart';

class CustomAppBarSpecialist extends StatelessWidget implements PreferredSizeWidget {
  final Specialist? userProfile;
  final double screenWidth;
  final double screenHeight;

  const CustomAppBarSpecialist({
    Key? key,
    this.userProfile,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFAFDCFF),
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.02.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 69.w,
                      height: 66.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: userProfile?.imageUrl == "" ||
                            userProfile?.imageUrl == null
                            ? Image.asset("assets/images/profile.jpg",
                            fit: BoxFit.fill)
                            : Image.network(userProfile?.imageUrl ?? "",
                            fit: BoxFit.fill),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.01.h),
                      child: Text(
                        "greeting".tr() +
                            " " +
                            "${userProfile?.firstName ?? "guest"}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: const Color(0xff19649E),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100.h,
                  width: 110.w,
                  child: Image.asset('assets/images/img.png', fit: BoxFit.fill),
                ),
                SizedBox(
                  width: 110.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _iconButton("assets/images/phone.png", () {}),
                            SizedBox(width: screenWidth * 0.05.w),
                            _iconButton("assets/images/notification.png", () {
                              Future.microtask(() {
                                // Ensures navigation happens correctly
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Notificationsscreen()),
                                );
                              });
                            })
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding:
                            EdgeInsets.only(bottom: screenHeight * 0.005.h),
                            child: Text(
                              "contactUs".tr(),
                              style: TextStyle(
                                color: const Color(0xff19649E),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _iconButton(
                                  "assets/images/fa-brands_twitter-square.png",
                                      () {}),
                              SizedBox(width: screenWidth * 0.01.w),
                              _iconButton(
                                  "assets/images/uil_facebook.png", () {}),
                              SizedBox(width: screenWidth * 0.01.w),
                              _iconButton(
                                  "assets/images/ri_instagram-fill.png", () {}),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconButton(String assetPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 27.w,
        height: 25.h,
        child: Image.asset(assetPath, fit: BoxFit.fill),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(screenHeight * 0.21.h);
}
