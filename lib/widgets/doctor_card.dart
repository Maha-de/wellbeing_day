import 'package:doctor/screens/doctor_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/specialist_model.dart';

class DoctorCard extends StatelessWidget {
  final Specialist specialistModel;

  const DoctorCard({super.key, required this.specialistModel});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width.w;
    final double screenHeight = MediaQuery.of(context).size.height.h;

    print("specialistModel: ${specialistModel.toString()}");
    if (specialistModel != null) {
      print("Doctor Name: ${specialistModel?.firstName} ${specialistModel?.lastName}");
    } else {
      print("No specialist data found!");
    }

    return GestureDetector(
      onTap: () {
        if (specialistModel != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorDetails(
                specialistModel: specialistModel,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("doctorInfoNotAvailable".tr()),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Expanded(
        child: Container(
          width: 344.w,
          height: 272.h,
          child: Card(
            child: Column(
              children: [
                Container(
                  height: 199.h,
                  color: Color(0xFF19649E),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 10, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 140.w,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                '${specialistModel?.firstName ?? "notFound".tr()} ${specialistModel?.lastName ?? ''}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                             SizedBox(height: 2.h),
                            Text(
                              specialistModel?.work ?? "notAvailable".tr(),
                              style:  TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                              textAlign: TextAlign.left,
                            ),
                             SizedBox(height: 15.h),
                            buildInfoRow("assets/images/heart.png",
                                "speciality".tr() + "${(specialistModel?.specialties?.mentalHealth?.isNotEmpty ?? false)
                                    ? specialistModel.specialties?.mentalHealth?.join(", ") : "notAvailable".tr()}"),
                             SizedBox(height: 4.h),
                            buildInfoRow("assets/images/PhoneCall.png",
                                'availableVideo'.tr()),
                             SizedBox(height: 4.h),
                            buildInfoRow("assets/images/experience.png",
                                "experienceYears".tr() + ' ${specialistModel?.yearsExperience ?? 0} ' + "years".tr()),
                             SizedBox(height: 4.h),
                            buildInfoRow("assets/images/translation.png",
                                "language".tr() + "arabic".tr() + "، " + "english".tr()),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 231.h,
                          width: 151.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset('assets/images/doctor.png',
                              fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    buildDetailColumn("assets/images/time.png", 'availability'.tr(),
                        "dateExample".tr()),
                    buildDetailColumn("assets/images/price.png", 'price'.tr(),
                        '${specialistModel?.sessionPrice ?? 'notAvailable'.tr()} ' + "currency".tr()
                            + ' / ' +
                            '${specialistModel?.sessionDuration ?? 'notAvailable'.tr()} ' + "timeSession".tr()
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Image.asset(
          icon,
          fit: BoxFit.fill,
          width: 21.w,
          height: 19.h,
          color: Colors.white,
        ),
         SizedBox(width: 8.w),
        Text(
          overflow: null,
          maxLines : null,
          text,
          style: TextStyle(fontSize: 14.sp, color: Colors.white,),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }

  Widget buildDetailColumn(String icon, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(icon, width: 19.w, height: 19.h),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(color: Color(0xff19649E), fontSize: 14.sp),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: Color(0xff19649E)),
          ),
        ],
      ),
    );
  }
}
