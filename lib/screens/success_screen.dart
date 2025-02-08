import 'package:doctor/screens/add_credit_card_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import '../cubit/update_user_cubit/update_user_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import 'client_profile_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width.w;
    final double screenHeight = MediaQuery.of(context).size.height.h;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: screenHeight * 0.7.h,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image(
                      image: const AssetImage("assets/images/success.png"),
                      height: 200.h,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 15),
                    height: 110.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "congratulations".tr(),
                          style: TextStyle(
                              color: Color(0xff19649E),
                              fontWeight: FontWeight.bold,
                              fontSize: 32.sp),
                        ),
                        Text(
                          "appointmentBookedSuccess".tr(),
                          style: TextStyle(
                              color: Color(0xff19649E),
                              fontWeight: FontWeight.w800,
                              fontSize: 24.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider<UserProfileCubit>(
                          create: (_) => UserProfileCubit()),
                      BlocProvider<AddImageToProfileCubit>(
                          create: (_) => AddImageToProfileCubit()),
                      BlocProvider<UpdateUserCubit>(
                          create: (_) => UpdateUserCubit()),
                    ],
                    child: const ClientProfileScreen(),
                  ),
                ),
                (route) => false,
              );
            },
            child: Container(
              width: 333.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: const Color(0xff19649E),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "return".tr(),
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
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
