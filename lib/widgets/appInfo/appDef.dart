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
            '''تعتبر هذه المنصة وهذا التطبيق انجاز حقيقي حيث استفدنا بأقصى. حد من التكنولوجيا لخدمة الانسان فنقلنا عمل العيادة كما هو الى التطبيق بمكوناته وشروطه. من الايجابيات التي يتميز بها التطبيق: 
      امكانية الحصول على الاستشارة بسرعة او البدء بالأعراض التي يعاني منها الفرد وصولا للاستشارة او الدخول الى لائحة الاخصائيين لاختيار المناسب منهم''',
            style: TextStyle(fontSize: 16.sp, height: 1.5.h, color: Colors.black),
          ),
           SizedBox(height: 16.h),
          const Text(
            'الخدمات المميزة:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
           SizedBox(height: 8.h),
           Text(
            ' • علاج فردي او اسري',
            style: TextStyle(fontSize: 16.sp, height: 1.5.h, color: Colors.black),
          ),
           Text(
            ' • اشتراك ببرامج علاجية',
            style: TextStyle(fontSize: 16.sp, height: 1.5.h, color: Colors.black),
          ),
           Text(
            ' • تدرب على الاسترخاء والمهارات',
            style: TextStyle(fontSize: 16.sp, height: 1.5.h, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
