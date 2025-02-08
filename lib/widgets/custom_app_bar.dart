import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/user_profile_model.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final UserProfileModel? userProfile;
  final double screenWidth;
  final double screenHeight;

  const CustomAppBar({
    Key? key,
    this.userProfile,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth.w;
        double height = constraints.maxHeight.h;

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
                padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.02.h),
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
                            child: userProfile?.imageUrl == "" || userProfile?.imageUrl == null
                                ? Image.asset("assets/images/profile.jpg", fit: BoxFit.fill)
                                : Image.network(userProfile?.imageUrl ?? "", fit: BoxFit.fill),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.01.h),
                          child: Text(
                            "greeting".tr() + " " + "${userProfile?.firstName ?? "guest"}",
                            style: TextStyle(
                              fontSize: width * 0.04.sp,
                              color: const Color(0xff19649E),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100.h,
                      width: 110 * 0.3.w,
                      child: Image.asset('assets/images/img.png', fit: BoxFit.fill),
                    ),
                    SizedBox(
                      width: width * 0.26.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: height * 0.15.h, bottom: height * 0.05.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                _iconButton("assets/images/phone.png"),
                                SizedBox(width: width * 0.05.w),
                                _iconButton("assets/images/notification.png"),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: height * 0.005.h),
                                child: Text(
                                  "تواصل معنا",
                                  style: TextStyle(
                                    color: const Color(0xff19649E),
                                    fontSize: width * 0.04.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _iconButton("assets/images/fa-brands_twitter-square.png"),
                                  SizedBox(width: width * 0.01.w),
                                  _iconButton("assets/images/uil_facebook.png"),
                                  SizedBox(width: width * 0.01.w),
                                  _iconButton("assets/images/ri_instagram-fill.png"),
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
      },
    );
  }

  Widget _iconButton(String assetPath) {
    return GestureDetector(
      onTap: () {},
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
