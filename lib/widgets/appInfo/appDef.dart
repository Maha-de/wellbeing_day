import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDef extends StatelessWidget {
  const AppDef({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/appdef.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "${'platform_intro'.tr()}",
            style:
                TextStyle(fontSize: 16.sp, height: 1.5.h, color: Colors.black),
          ),
          SizedBox(height: 16.h),
          const Text(
            'الخدمات المميزة:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 8.h),
          Text(
            "${'individual_family_treatment'.tr()}",
            style:
                TextStyle(fontSize: 16.sp, height: 1.5.h, color: Colors.black),
          ),
          Text(
            "${'therapeutic_program_subscription'.tr()}",
            style:
                TextStyle(fontSize: 16.sp, height: 1.5.h, color: Colors.black),
          ),
          Text(
            "${'relaxation_skills_training'.tr()}",
            style:
                TextStyle(fontSize: 16.sp, height: 1.5.h, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
