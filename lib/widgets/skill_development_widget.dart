import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import '../cubit/doctor_by_category_cubit/doctor_by_category_cubit.dart';
import '../cubit/update_user_cubit/update_user_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';

class SkillDevelopmentWidget extends StatelessWidget {
  final String text;
  final Widget navigateToPage;

  const SkillDevelopmentWidget({super.key, required this.text, required this.navigateToPage, });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                BlocProvider<DoctorByCategoryCubit>(create: (_) => DoctorByCategoryCubit()),
              ],
              child: navigateToPage,
            ),

          ),
        );
      },
      child: Container(
        width: 100.w,
        height: 68.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xff69B7F3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text( textAlign: TextAlign.center,
            text,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
