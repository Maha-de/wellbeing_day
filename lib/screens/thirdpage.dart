import 'package:doctor/screens/selectionpage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // توسيط العناصر عموديًا
            children: [
              // صورة الطبيب
              Image.asset(
                'assets/images/welcometwo.png', // أضف مسار الصورة الصحيح
                height: 200.h,
              ),

               SizedBox(height: 24.0.h),

              // النص الرئيسي
              Text(
                "chooseSpecialist".tr(),
                style:  TextStyle(
                  fontSize: 20.0.sp, // حجم الخط أصغر لتناسب التصميم
                  fontWeight: FontWeight.bold,
                ),
              ),

               SizedBox(height: 12.0.h),

              // النص الوصفي
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  "thirdWelcomeScreen".tr(),
                  textAlign: TextAlign.center,
                  style:  TextStyle(
                    fontSize: 14.0.sp, // حجم الخط
                    color: Colors.black87,
                    height: 1.5.h,
                  ),
                ),
              ),

               SizedBox(height: 24.0.h),

              // زر البدء
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  SelectionPage()),
                  );  // أضف الوظيفة المناسبة هنا
                },
                child: Container(
                  width: 100.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: const Color(0xff19649E),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "start".tr(),
                      style:  TextStyle(
                        color: Colors.white,
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
