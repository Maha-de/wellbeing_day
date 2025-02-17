import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'doctor_instructions_2.dart';

class DoctorInstructions1 extends StatelessWidget {
  const DoctorInstructions1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 8.h),
          SelectableText.rich(
            TextSpan(
              style: TextStyle(fontSize: 16.sp, color: Colors.black, ),
              children: [
                TextSpan(
                  text: "${"importantInstructions".tr()}\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.sp),
                ),
                TextSpan(
                  text: "${"client_registration".tr()}\n",
                  style: TextStyle(fontSize: 16.sp, height: 2.h),
                ),
                TextSpan(
                  text: "${"therapeutic_relationship".tr()}\n",
                  style: TextStyle(fontSize: 16.sp, height: 2.h),

                ),
                TextSpan(
                  text: "${"payment_method".tr()}\n",
                  style: TextStyle(fontSize: 16.sp, height: 2.h),

                ),
                TextSpan(
                  text: "${"send_receipt".tr()}\n",
                  style: TextStyle(fontSize: 16.sp, height: 2.h),

                ),
                TextSpan(
                  text: "${"responsibility_for_payment".tr()}\n",
                  style: TextStyle(fontSize: 16.sp, height: 2.h),

                ),

                TextSpan(
                  text: "recommendationsForSpecialists".tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.sp),
                ),
                TextSpan(
                  text: "recommendation".tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
                TextSpan(
                  text: "${"specialist_account_creation".tr()}\n",
                  style: TextStyle(fontSize: 16.sp, height: 2.h),
                ),
                TextSpan(
                  text: "${"professional_requirements".tr()}\n",
                  style: TextStyle(fontSize: 16.sp, height: 2.h),

                ),
                TextSpan(
                  text: "${"ethical_conduct".tr()}\n",
                  style: TextStyle(fontSize: 16.sp, height: 2.h),

                ),
                TextSpan(
                  text: "${"professional_ethics".tr()}\n",
                  style: TextStyle(fontSize: 16.sp, height: 2.h),

                ),
                TextSpan(
                  text: "${"respect_laws".tr()}\n",
                  style: TextStyle(fontSize: 16.sp, height: 2.h),

                ),
                TextSpan(
                  text: "${"correct_framework".tr()}\n",
                  style: TextStyle(fontSize: 16.sp, height: 2.h),

                ),
                TextSpan(
                  text: "${"punctuality".tr()}\n",
                  style: TextStyle(fontSize: 16.sp, height: 2.h),

                ),
                TextSpan(
                  text: "${"some_notes".tr()}\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.sp),
                ),
                TextSpan(
                  text: "${"platform_usage_restriction".tr()}\n",
                  style: TextStyle(fontSize: 16.sp, height: 2.h),

                ),
                TextSpan(
                  text: "${"emergency_cases".tr()}\n",
                  style: TextStyle(fontSize: 16.sp, height: 2.h),

                ),
                TextSpan(
                  text: "${"disclaimer".tr()}\n",
                  style: TextStyle(fontSize: 16.sp, height: 2.h),

                ),
                TextSpan(
                  text: "${"company_responsibility".tr()}\n",
                  style: TextStyle(fontSize: 16.sp, height: 2.h),

                ),

              ],
            ),
          ),
          SizedBox(height: 5.h),
          SizedBox(
            width: 100.w,
            height: 40.h,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF19649E),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  DoctorInstructions2()),
              );
            },
              child: Center(
                child: Text(
                  "more".tr(),
                  style:  TextStyle(
                    color: Colors.white,
                    fontSize: 16.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),

        ],
      ),
    );
  }
}
