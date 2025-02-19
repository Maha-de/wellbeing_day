import 'dart:developer';

import 'package:doctor/cubit/user_notification_cubit.dart/user_notification_cubit.dart';
import 'package:doctor/cubit/user_notification_cubit.dart/user_notification_state.dart';
import 'package:doctor/widgets/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notificationsscreen extends StatefulWidget {
  const Notificationsscreen({super.key});

  @override
  State<Notificationsscreen> createState() => _NotificationsscreenState();
}

class _NotificationsscreenState extends State<Notificationsscreen> {
  late UserNotificationCubit userNotificationCubit;

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String role = prefs.getString('role') ?? "";
    if (role == "1") {
      String id = prefs.getString('doctorId') ?? "";
      if (id.isNotEmpty) {
        userNotificationCubit = context.read<UserNotificationCubit>();
        userNotificationCubit.fetchDoctorSessions(
          id,
        );
      } else {
        log('No doctor ID found in SharedPreferences');
      }
    } else if (role == "0") {
      String id = prefs.getString('userId') ?? "";
      if (id.isNotEmpty) {
        userNotificationCubit = context.read<UserNotificationCubit>();
        userNotificationCubit.fetchBenificarySessions(
          id,
        );
      } else {
        log('No Benfic ID found');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEnglish = Localizations.localeOf(context).languageCode == 'en';

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xff19649E),
        ),
        title: Center(
          child: Container(
            width: 200,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF1F78BC),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              "notifications".tr(),
              style: TextStyle(
                fontSize: isEnglish ? 17 : 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<UserNotificationCubit, UserNotificationState>(
          builder: (context, state) {
            if (state is UserNotificationLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UserNotificationSuccess) {
              final todaySessions = state.TodaySessions;

              if (todaySessions.isEmpty) {
                return const Center(
                  child: Text(
                    "لا توجد جلسات اليوم",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ListView.builder(
                  itemCount: todaySessions.length,
                  itemBuilder: (context, index) {
                    final session = todaySessions[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.white12.withOpacity(0.8),
                          ),
                        ], borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text("اشعار جديد"),
                                  session.notificationType.isNotEmpty
                                      ? Text(
                                          session.notificationType,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: session.notificationType ==
                                                    "جلسة مجانية"
                                                ? Color(0xFF1F78BC)
                                                : Colors.red,
                                          ),
                                        )
                                      : Text(
                                          'جلستك في',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1F78BC)),
                                        ),
                                  Text(
                                    session.date,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage("assets/images/img.png"),
                              backgroundColor: Color(0xff69B7F3),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is UserNotificationFailure) {
              return Center(
                child: Column(
                  children: [
                    Text(
                      "${state.errMessage}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
