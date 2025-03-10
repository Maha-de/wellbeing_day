import 'package:doctor/cubit/doctor_details_cubit/doctor_profile_cubit.dart';
import 'package:doctor/cubit/get_session_by_id_cubit/get_session_by_id_cubit.dart';
import 'package:doctor/screens/specialist/specialist_free_consultation_screen.dart';
import 'package:doctor/screens/specialist/specialist_instant_session_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import '../cubit/get_beneficiary_sessions_cubit/beneficiary_session_cubit.dart';
import '../cubit/get_doctor_sessions_types_cubit/doctor_session_types_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../models/doctor_session_model.dart';
import '../screens/specialist/user_profile_screen.dart';

class BeneficiaryCardHome extends StatelessWidget {
  final String fOrI;
  final Beneficiary? session;
  InstantSession? instantSessions;
  FreeConsultation? freeConsultationSessions;
  final EdSession? scheduleSessions;
  final EdSession? completedSessions;
  BeneficiaryCardHome({super.key, required this.session,this.freeConsultationSessions,this.instantSessions, this.scheduleSessions, this.completedSessions, required this.fOrI});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 344.w,
        height: 153.h,
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
                      session?.firstName??"",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 38.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoBox("sessionDetails".tr()
                        ,(){fOrI== "f"?Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider<DoctorProfileCubit>(
                                    create: (_) => DoctorProfileCubit()),
                                BlocProvider<DoctorSessionTypesCubit>(
                                    create: (_) => DoctorSessionTypesCubit()),
                                BlocProvider<BeneficiarySessionCubit>(
                                    create: (_) => BeneficiarySessionCubit()),
                                BlocProvider<GetSessionByIdCubit>(
                                    create: (_) => GetSessionByIdCubit()),
                              ],
                              child: SpecialistFreeConsultationScreen(id: freeConsultationSessions?.id??"",

                              ),
                            ),
                          ),
                        ):Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider<DoctorProfileCubit>(
                                    create: (_) => DoctorProfileCubit()),
                                BlocProvider<DoctorSessionTypesCubit>(
                                    create: (_) => DoctorSessionTypesCubit()),
                                BlocProvider<BeneficiarySessionCubit>(
                                    create: (_) => BeneficiarySessionCubit()),
                                BlocProvider<GetSessionByIdCubit>(
                                    create: (_) => GetSessionByIdCubit()),
                              ],
                              child: SpecialistInstantSessionScreen(id: instantSessions?.id??""),

                              ),
                            ),

                        );}),
                    _buildInfoBox('userDetails'.tr(),(){
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
                              id: session?.id ?? "", groupThreapy: false,
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
              child:Container(
                width: 166.w,
                height: 116.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // يجعل الكونتينر دائريًا
                  border: Border.all(color: Colors.transparent, width: 2),
                  // إطار أبيض حول الدائرة
                  image: DecorationImage(
                    image: AssetImage("assets/images/family.png"), // تأكد من المسار الصحيح
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

  Widget _buildInfoBox(String text,Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 137.w,
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.blue[800],fontSize: 14.sp,fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}