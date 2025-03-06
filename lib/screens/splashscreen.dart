import 'package:doctor/cubit/get_doctor_sessions_cubit/doctor_session_cubit.dart';
import 'package:doctor/cubit/get_sub_categories_cubit/get_sub_categories_cubit.dart';
import 'package:doctor/screens/home_second_screen.dart';
import 'package:doctor/screens/specialist/specialist_home_screen.dart';
import 'package:doctor/screens/welcomescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/doctor_details_cubit/doctor_profile_cubit.dart';
import '../cubit/get_doctor_sessions_types_cubit/doctor_session_types_cubit.dart';
import '../cubit/update_user_cubit/update_user_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import 'homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Define a tween for scaling the image
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    // Start the animation
    _animationController.forward();

    // Navigate to the next screen after some time
    Timer(const Duration(seconds: 3), () async{
      final prefs = await SharedPreferences.getInstance();
      print(prefs.containsKey("userId"));
      print(prefs.containsKey("doctorId"));
      prefs.containsKey("userId")?
      Navigator.push(
        context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                BlocProvider<SubCategoriesCubit>(create: (_) => SubCategoriesCubit()),
                BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
              ],
              child: const HomeScreen(),
            ),
          ))
      :prefs.containsKey("doctorId")? Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<DoctorProfileCubit>(create: (_) => DoctorProfileCubit()),
              BlocProvider<DoctorSessionTypesCubit>(create: (_) => DoctorSessionTypesCubit()),
              BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
            ],
            child: const SpecialistHomeScreen(),
          ),
        ),
      ):Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: SizedBox(
            width: 225.w,
            height: 178.62.h,
            child: Image.asset('assets/images/img.png', fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

