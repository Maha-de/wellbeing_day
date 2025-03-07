import 'package:doctor/screens/doctor_instructions.dart';
import 'package:doctor/screens/sign_up_as_client.dart';
import 'package:doctor/screens/specialist/sign_up_specialist_info_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/get_all_ads/get_all_ads_cubit.dart';
import '../cubit/get_sub_categories_cubit/get_sub_categories_cubit.dart';
import '../cubit/update_user_cubit/update_user_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../make_email/login.dart';
import 'client_instructions.dart';
import 'homescreen.dart';
import 'specialist/specialist_home_screen.dart';

class SelectionPage extends StatelessWidget {
  const SelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        // استخدام Center لمحاذاة العناصر في منتصف الصفحة
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // إضافة اللوجو بحجم 180x142.89
              Image.asset(
                'assets/images/img.png',
                width: 180.w, // تحديد العرض
                height: 142.89.h, // تحديد الارتفاع
              ),
               SizedBox(height: 20.h),
              Text(
                "chooseYourAccount".tr(),
                style:  TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
               SizedBox(height: 8.h),
              Text(
                "makeYourExperienceEasier".tr(),
                style: TextStyle(fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
               SizedBox(height: 40.h),
              // تعديل الأزرار لتكون متطابقة مع التصميم
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClientInstructions()),
                  );
                },
                style: ElevatedButton.styleFrom(

                  backgroundColor: const Color(0xff19649E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // زوايا دائرية
                  ),
                ),
                child: Container(
                  width: double.infinity.w, // ملء العرض
                  height: 52.h, // ارتفاع الزر
                  alignment: Alignment.center, // مركز النص
                  child: Text(
                    "continueAsUser".tr(),
                    style:  TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.w700,color: Colors.white), // حجم النص
                  ),
                ),
              ),
               SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DoctorInstructions()),
                  );
                },
                style: ElevatedButton.styleFrom(

                  backgroundColor: const Color(0xff19649E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Container(
                  width: double.infinity.w, // ملء العرض
                  height: 52.h, // ارتفاع الزر
                  alignment: Alignment.center, // مركز النص
                  child: Text(
                    "continueAsDoctor".tr(),
                    style:  TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.w700,color: Colors.white), // حجم النص
                  ),
                ),
              ),
               SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                            BlocProvider<SubCategoriesCubit>(create: (_) => SubCategoriesCubit()),
                            BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                            BlocProvider<SubCategoriesCubit>(create: (_) => SubCategoriesCubit()),
                            BlocProvider<GetAllAdsCubit>(create: (_) => GetAllAdsCubit()),
                          ],
                          child: const HomeScreen(),
                        ),
                      ));
                },
                style: ElevatedButton.styleFrom(

                  backgroundColor: const Color(0xff19649E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Container(
                  width: double.infinity.w, // ملء العرض
                  height: 52.h, // ارتفاع الزر
                  alignment: Alignment.center, // مركز النص
                  child: Text(
                    "continueAsGuest".tr(),
                    style:  TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.w700,color: Colors.white), // حجم النص
                  ),
                ),
              ),
               SizedBox(height: 40.h),
              // الجزء السفلي مع ترتيب النص وزر تسجيل الدخول
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    "alreadyHaveAnAccount".tr(),
                    style:  TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      "signIn".tr(),
                      style:  TextStyle(
                          color: Color(0xff19649E),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
