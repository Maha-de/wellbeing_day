import 'package:doctor/cubit/doctor_details_cubit/doctor_profile_cubit.dart';
import 'package:doctor/models/catgoryInfo.dart';
import 'package:doctor/models/sessionType.dart';
import 'package:doctor/screens/doctor_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../models/Doctor_id_model.dart';
import '../models/doctor_by_category_model.dart';
import '../models/specialist_model.dart' as s;

class DoctorCard extends StatelessWidget {
  final s.Specialists? specialistModel;
  final Specialists? specialists;
  final String doctorID;
  final Specialist? sessionDoctor;
  final String? id;
  final CategoryInfo? categoryInfo;
  final SessionType? sessionType;
  DoctorCard(
      {super.key,
      this.specialistModel,
      required this.doctorID,
      this.specialists,
      this.sessionDoctor,
      this.id,
      this.categoryInfo,
      this.sessionType});

  @override
  Widget build(BuildContext context) {
    print("--------------DoctorCard----------------------");
    // print((sessionType as InstantSession).description);

    final double screenWidth = MediaQuery.of(context).size.width.w;
    final double screenHeight = MediaQuery.of(context).size.height.h;

    print("specialistModel: ${specialistModel.toString()}");
    if (specialistModel != null) {
      print(
          "Doctor Name: ${specialistModel?.firstName} ${specialistModel?.lastName}");
    } else {
      print("No specialist data found!");
    }

    return GestureDetector(
      onTap: () {
        if (doctorID != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider<UserProfileCubit>(
                      create: (_) => UserProfileCubit()),
                  BlocProvider<DoctorProfileCubit>(
                      create: (_) => DoctorProfileCubit()),
                ],
                child: DoctorDetails(
                    sessionType: sessionType  ,
                    doctorID: doctorID,
                    categoryInfo: categoryInfo),
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
      child: Container(
        width: 345.w,
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
                      padding:
                          const EdgeInsets.only(right: 5, top: 10, left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 140.w,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              '${specialists?.firstName ?? specialistModel?.firstName ?? sessionDoctor?.firstName ?? "notFound".tr()} ${specialistModel?.lastName ?? sessionDoctor?.lastName ?? specialists?.lastName ?? ''}',
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
                            specialists?.work ??
                                sessionDoctor?.work ??
                                specialistModel?.work ??
                                "notAvailable".tr(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 15.h),
                          buildInfoRow(
                              "assets/images/heart.png",
                              "speciality".tr() +
                                  "${(specialists?.specialties?.mentalHealth?.isNotEmpty ?? false) ? specialists?.specialties?.mentalHealth?.join(", ") : (sessionDoctor?.specialties?.mentalHealth?.isNotEmpty ?? false) ? sessionDoctor?.specialties?.mentalHealth?.join(", ") : (specialistModel?.specialties?.mentalHealth?.isNotEmpty ?? false) ? specialistModel?.specialties?.mentalHealth?.join(", ") : "notAvailable".tr()}"),
                          SizedBox(height: 4.h),
                          buildInfoRow("assets/images/PhoneCall.png",
                              'availableVideo'.tr()),
                          SizedBox(height: 4.h),
                          buildInfoRow(
                              "assets/images/experience.png",
                              "experienceYears".tr() +
                                  ' ${specialists?.yearsExperience ?? specialistModel?.yearsExperience ?? sessionDoctor?.yearsExperience ?? 0} ' +
                                  "years".tr()),
                          SizedBox(height: 4.h),
                          buildInfoRow(
                              "assets/images/translation.png",
                              "language".tr() +
                                  "arabic".tr() +
                                  "، " +
                                  "english".tr()),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Container(
                        height: 210.h,
                        width: 164.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:
                            _getImageWidget(), // استدعاء الدالة التي تعالج الصورة
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
                  buildDetailColumn("assets/images/time.png",
                      'availability'.tr(), "dateExample".tr()),
                  buildDetailColumn(
                      "assets/images/price.png",
                      'price'.tr(),
                      '${specialistModel?.sessionPrice ?? specialistModel?.sessionPrice ?? sessionDoctor?.sessionPrice ?? 'notAvailable'.tr()} ' +
                          "currency".tr() +
                          ' / ' +
                          '${specialistModel?.sessionDuration ?? specialistModel?.sessionDuration ?? sessionDoctor?.sessionDuration ?? 'notAvailable'.tr()} ' +
                          "timeSession".tr()),
                ],
              ),
            ],
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
        Container(
          width: 184.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 180.w,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  text,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
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
          Container(
            width: 160.w,
            child: Center(
              child: Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: Color(0xff19649E)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getImageWidget() {
    String? imageUrl = sessionDoctor?.imageUrl ??
        specialistModel?.imageUrl ??
        specialists?.imageUrl;

    if (imageUrl != null && imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/images/doctor.png', fit: BoxFit.cover);
        },
      );
    }

    imageUrl = specialistModel?.imageUrl;

    if (imageUrl != null && imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/images/doctor.png', fit: BoxFit.cover);
        },
      );
    }

    // الصورة الافتراضية في حالة عدم توفر أي صورة
    return Image.asset('assets/images/doctor.png', fit: BoxFit.cover);
  }
}
