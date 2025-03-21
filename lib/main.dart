import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:doctor/cubit/get_specialist/get_sepcialist_cubit.dart';
import 'package:doctor/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:doctor/screens/client_profile_details.dart';
import 'package:doctor/screens/client_profile_screen.dart';
import 'package:doctor/screens/psychological_disorders_screen.dart';
import 'package:doctor/screens/settings_screen.dart';
import 'package:doctor/screens/splashscreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'api/dio_consumer.dart';
import 'api/user_repository.dart';
import 'cubit/doctor_sign_up_cubit/doctor_sign_up_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
      path: 'assets/translations', // مسار ملفات الترجمة
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignUpSpecialistCubit(),
          ),
          BlocProvider(
            create: (context) => UserProfileCubit(),
          ),
          BlocProvider(
            create: (context) => GetSpecialistCubit(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
      designSize: const Size(375 , 812), // حجم التصميم الأساسي، عدّله حسب UI
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          scrollBehavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse, PointerDeviceKind.trackpad},
          ),
          locale: context.locale,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          title: 'doctorapp',
          theme: ThemeData(
            fontFamily: "Tajawal",
            primarySwatch: Colors.blue,

          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
