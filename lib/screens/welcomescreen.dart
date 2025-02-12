import 'package:doctor/screens/secondpage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // زر "تخطي" في أعلى الشاشة
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  'skip'.tr(),
                  style:  TextStyle(
                    color: Color(0xff19649E),
                    fontSize: 16.0.sp,
                  ),
                ),
              ),
            ),

            // مسافة فارغة لتوسيط المحتوى في النصف السفلي
            const Spacer(flex: 2),

            // الصورة والنصوص في النصف السفلي
            Expanded(

              flex: 15,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // صورة الطبيب
                  Image.asset(
                    'assets/images/doctor.png', // أضف مسار الصورة الصحيح
                    height: 200.h,
                  ),

               SizedBox(height: 24.0.h),

                  // نص الترحيب
                   Text(
                    'welcome'.tr(),
                    style:  TextStyle(
                      fontSize: 24.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                   SizedBox(height: 16.0.h),

                  // النص الوصفي
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      'firstWelcomeScreen'.tr(),
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                        fontSize: 16.0.sp,
                        color: Colors.black87,
                        height: 1.5.h,
                      ),
                    ),
                  ),

                   SizedBox(height: 24.0.h),

                  // زر الانتقال للصفحة التالية
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SecondPage()),
                      );
                    },
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xff19649E), width: 2),
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Color(0xff19649E),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // مسافة فارغة بين النصف السفلي والنهاية
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
