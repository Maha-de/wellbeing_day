import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FqaTab extends StatelessWidget {
  const FqaTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SelectableText.rich(
            TextSpan(
              style: TextStyle(
                  fontSize: 18.sp, color: Colors.black, height: 1.5.h),
              children: [
                TextSpan(
                  text: "${"session_booking_method".tr()}\n",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
                TextSpan(
                  text: "${"session_booking_details".tr()}\n\n",
                ),
                TextSpan(
                  text: "${"why_online_session".tr()}\n",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
                TextSpan(
                  text: "${"why_online_session_details".tr()}\n\n",
                ),
                TextSpan(
                  text: "${"sessions_needed".tr()}\n",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
                TextSpan(
                  text: "${"sessions_needed_details".tr()}\n\n",
                ),
                TextSpan(
                  text: "${"how_is_info_handled".tr()}\n",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
                TextSpan(
                  text: "${"how_is_info_handled_details".tr()}\n\n",
                ),
                TextSpan(
                  text: "${"breaking_confidentiality".tr()}\n\n",
                ),
                TextSpan(
                  text: "${"what_to_expect_from_consultation".tr()}\n",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
                TextSpan(
                  text:
                      "${"what_to_expect_from_consultation_details".tr()}\n\n",
                ),
                TextSpan(
                  text: "${"what_if_late".tr()}\n",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
                TextSpan(
                  text: "${"what_if_late_details".tr()}\n",
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
