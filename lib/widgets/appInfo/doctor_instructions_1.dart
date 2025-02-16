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
          SizedBox(height: 8),
          SelectableText.rich(
            TextSpan(
              style: TextStyle(fontSize: 16, color: Colors.black, height: 2),
              children: [
                TextSpan(
                  text: "${"importantInstructions".tr()}\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                TextSpan(
                  text: "${"client_registration".tr()}\n",
                  style: TextStyle(fontSize: 16),
                ),
                TextSpan(
                  text: "${"therapeutic_relationship".tr()}\n",
                ),
                TextSpan(
                  text: "${"payment_method".tr()}\n",
                ),
                TextSpan(
                  text: "${"send_receipt".tr()}\n",
                ),
                TextSpan(
                  text: "${"responsibility_for_payment".tr()}\n",
                ),

                TextSpan(
                  text: "recommendationsForSpecialists".tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                TextSpan(
                  text: "recommendation".tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                TextSpan(
                  text: "${"specialist_account_creation".tr()}\n",
                  style: TextStyle(fontSize: 16),
                ),
                TextSpan(
                  text: "${"professional_requirements".tr()}\n",
                ),
                TextSpan(
                  text: "${"ethical_conduct".tr()}\n",
                ),
                TextSpan(
                  text: "${"professional_ethics".tr()}\n",
                ),
                TextSpan(
                  text: "${"respect_laws".tr()}\n",
                ),
                TextSpan(
                  text: "${"correct_framework".tr()}\n",
                ),
                TextSpan(
                  text: "${"punctuality".tr()}\n",
                ),
                TextSpan(
                  text: "${"some_notes".tr()}\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                TextSpan(
                  text: "${"platform_usage_restriction".tr()}\n",
                ),
                TextSpan(
                  text: "${"emergency_cases".tr()}\n",
                ),
                TextSpan(
                  text: "${"disclaimer".tr()}\n",
                ),
                TextSpan(
                  text: "${"company_responsibility".tr()}\n",
                ),

              ],
            ),
          ),
          SizedBox(height: 10.h),
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
