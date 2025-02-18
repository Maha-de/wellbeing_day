import 'package:doctor/screens/specialist/specialist_free_consultation_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;

import '../cubit/doctor_details_cubit/doctor_profile_cubit.dart';
import '../cubit/get_beneficiary_sessions_cubit/beneficiary_session_cubit.dart';
import '../cubit/get_doctor_sessions_types_cubit/doctor_session_types_cubit.dart';
import '../cubit/update_user_cubit/update_user_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../models/doctor_sessions_types_model.dart';
import '../screens/specialist/user_profile_screen.dart';

class BeneficiaryCard extends StatelessWidget {
  final Beneficiary? session;
  EdSession? scheduledSessions;
  EdSession? completedSessions;
  BeneficiaryCard(
      {super.key,
      required this.session,
      this.completedSessions,
      this.scheduledSessions});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 325.w,
        height: 185.h,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color(0xff19649E),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          clipBehavior: Clip.none, // يسمح بخروج الصورة خارج الحدود
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      session?.firstName ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 38),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoBox(
                        '${scheduledSessions?.sessionDate == null ? '${completedSessions?.sessionDate?.day}/${completedSessions?.sessionDate?.month}/${completedSessions?.sessionDate?.year}' : '${scheduledSessions?.sessionDate?.day}/${scheduledSessions?.sessionDate?.month}/${scheduledSessions?.sessionDate?.year}'}',
                        () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider<DoctorProfileCubit>(
                                  create: (_) => DoctorProfileCubit()),
                              BlocProvider<DoctorSessionTypesCubit>(
                                  create: (_) => DoctorSessionTypesCubit()),
                              BlocProvider<UpdateUserCubit>(
                                  create: (_) => UpdateUserCubit()),
                            ],
                            child: const SpecialistFreeConsultationScreen(),
                          ),
                        ),
                      );
                    }),
                    _buildInfoBox('userDetails'.tr(), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider<UserProfileCubit>(
                                  create: (_) => UserProfileCubit()),
                              BlocProvider<DoctorSessionTypesCubit>(
                                  create: (_) => DoctorSessionTypesCubit()),
                              BlocProvider<BeneficiarySessionCubit>(
                                  create: (_) => BeneficiarySessionCubit()),
                            ],
                            child: UserProfileScreen(
                              id: session?.id ?? "",
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: -55,
              child: Container(
                width: 118.w,
                height: 118.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // يجعل الكونتينر دائريًا
                  border: Border.all(color: Colors.transparent, width: 2),
                  // إطار أبيض حول الدائرة
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/images/family.png"), // تأكد من المسار الصحيح
                    fit: BoxFit.fill, // يجعل الصورة تملأ الدائرة بشكل مناسب
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox(String text, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 137,
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.blue[800],
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
