import 'package:doctor/cubit/get_beneficiary_sessions_cubit/beneficiary_session_cubit.dart';
import 'package:doctor/cubit/get_doctor_sessions_types_cubit/doctor_session_types_cubit.dart';
import 'package:doctor/cubit/send_notification_cubit/send_notification_cubit.dart';
import 'package:doctor/models/user_profile_model.dart';
import 'package:doctor/screens/specialist/send_meeting_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cubit/doctor_details_cubit/doctor_profile_cubit.dart';
import '../../cubit/doctor_details_cubit/doctor_profile_state.dart';
import '../../cubit/get_beneficiary_sessions_cubit/beneficiary_session_state.dart';
import '../../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../../cubit/user_profile_cubit/user_profile_state.dart';
import '../../models/Doctor_id_model.dart';

class UserProfileScreen extends StatefulWidget {
  final String id;
  const UserProfileScreen({super.key, required this.id});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late UserProfileCubit userProfileCubit;
  late BeneficiarySessionCubit beneficiarySessionCubit;
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    beneficiarySessionCubit = BlocProvider.of<BeneficiarySessionCubit>(context);

    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = widget.id;

    print(id);
    userProfileCubit.getUserProfile(context, id);
    beneficiarySessionCubit.getDoctorSessionsTypes(context, id);
  }

  @override
  Widget build(BuildContext context) {
// Responsive values based on the screen size
    double profileH = MediaQuery.of(context).size.width * 0.5;
    double top = profileH * 0.5;
    double topText = profileH * 0.6;
    bool isEnglish = Localizations.localeOf(context).languageCode == 'en';
    return BlocProvider(
        create: (_) => userProfileCubit,
        child: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (state is UserProfileFailure) {
              return Scaffold(
                  body: Center(
                      child: Text("Error loading profile: ${state.error}")));
            } else if (state is UserProfileSuccess) {
              UserProfileModel? userProfile = state.userProfile;
              return Scaffold(
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                            BlocProvider<SendNotificationCubit>(create: (_) => SendNotificationCubit()),
                          ],
                          child: MeetingScreen(uId: widget.id),
                        ),
                      ),
                    );

                  },
                  backgroundColor: Colors.blue[100],
                  icon: Icon(Icons.play_arrow, color: Color(0xff19649E)),
                  label: Text("Start Session", style: TextStyle(color: Color(0xff19649E),fontWeight: FontWeight.bold,fontSize: 14)),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.endTop,

                appBar: AppBar(
                  backgroundColor: const Color(0xff19649E),
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          CoverWidget(profileHeight: profileH),
                          Positioned(
                              top: topText + profileH / 6,
                              left: 0,
                              right: 0,
                              child: BlocBuilder<BeneficiarySessionCubit,
                                  BeneficiarySessionState>(
                                builder: (context, state) {
                                  if (state is BeneficiarySessionLoading) {
                                    return CircularProgressIndicator(); // Show loading indicator
                                  } else if (state is BeneficiarySessionFailure) {
                                    return Text(
                                        state.error); // Display error message
                                  } else if (state is BeneficiarySessionSuccess) {
                                    return SingleChildScrollView(
                                      child: benDetials(
                                          userProfile.firstName ??
                                              "" +
                                                  " " +
                                                  "${userProfile.lastName ?? " "}",
                                          "${userProfile.age}",
                                          userProfile.gender ?? "",
                                          userProfile.nationality ?? "",
                                          userProfile.profession ?? "",
                                          beneficiarySessionCubit
                                              .sessionData?.scheduledSessions
                                              ?.map((session) =>
                                          '${session.sessionDate?.day}/${session.sessionDate?.month}/${session.sessionDate?.year}' ??
                                              '')
                                              .toList() ??
                                              ["noneSessions".tr()],
                                          beneficiarySessionCubit
                                              .sessionData?.completedSessions
                                              ?.map((session) =>
                                          '${session.sessionDate?.day}/${session.sessionDate?.month}/${session.sessionDate?.year}' ??
                                              '')
                                              .toList() ??
                                              ["noneSessions".tr()]),
                                    );
                                  } else {
                                    return Center(child: Text("noneSessions".tr()));
                                  }
                                },
                              )),
                          // Positioned(
                          //   top: topText,
                          //   left: MediaQuery.of(context).size.width / 2 -
                          //       (profileH + 150),
                          //   right: 0,
                          //   child: namedTextWidget(
                          //       "${userProfile.firstName ?? " "}" +
                          //           "${userProfile.lastName}",
                          //       userProfile.profession ?? ""),
                          // ),
                          // Positioned(
                          //   top: top,
                          //   left: MediaQuery.of(context).size.width / 3 +
                          //       profileH / 2,
                          //   child:
                          //       profilePage(profileH, userProfile.imageUrl ?? ""),

                          // ),
                          Positioned(
                            top: top,
                            left: !isEnglish
                                ? MediaQuery.of(context).size.width / 3 -
                                    (profileH / 2)
                                : MediaQuery.of(context).size.width / 3 +
                                    (profileH / 2),
                            child:
                                profilePage(profileH, userProfile.imageUrl ?? ""),
                          ),
                          Positioned(
                            top: topText,
                            left: !isEnglish
                                ? MediaQuery.of(context).size.width / 2 +
                                    (profileH - 150)
                                : MediaQuery.of(context).size.width / 2 -
                                    (profileH + 150),
                            // right: 0,
                            child: namedTextWidget(
                                "${userProfile.firstName ?? " "}" +
                                    "${userProfile.lastName}",
                                userProfile.profession ?? ""),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container(); // Default return in case no state matches
          },
        ));
  }
}

Widget benDetials(String name, String age, String gender, String nationality,
    String profession, List<String> schedule, List<String> complete) {
  return SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 85.h,
            ),
            Center(
              child: Text(
                "userDetails".tr(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            infoRow("name".tr(), name),
            infoRow("age".tr(), age),
            infoRow("gender".tr(), gender),
            infoRow("nationality".tr(), nationality),
            infoRow("profession".tr(), profession),
            SizedBox(
              height: 30,
            ),
            sessionSection(schedule == [] ? ["noneSessions".tr()] : schedule,
                complete == [] ? ["noneSessions".tr()] : complete),
          ],
        ),
      ),
    ),
  );
}

Widget infoRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Text("$title : ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff19649E),
              fontSize: 20,
            )),
        Text(
          value,
          style: TextStyle(
              fontSize: 20,
              color: Color(
                0xff19649E,
              )),
        ),
      ],
    ),
  );
}

Widget sessionSection(List<String> future_dates, List<String> completed_dates) {
  return BlocBuilder<BeneficiarySessionCubit, BeneficiarySessionState>(
    builder: (context, state) {
      if (state is BeneficiarySessionLoading) {
        return CircularProgressIndicator(); // Show loading indicator
      } else if (state is BeneficiarySessionFailure) {
        return Text(state.error); // Display error message
      } else if (state is BeneficiarySessionSuccess) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xff19649E),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'nextSessions'.tr(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 8),
                Column(
                  children: future_dates.map((date) => sessionBox(date)).toList(),
                ),
                SizedBox(height: 12),
                Center(
                  child: Text('completedSessions'.tr(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 8),
                Column(
                  children:
                      completed_dates.map((date) => sessionBox(date)).toList(),
                ),
              ],
            ),
          ),
        );
      } else {
        return Center(child: Text("noneSessions".tr()));
      }
    },
  );
}

Widget sessionBox(String date) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(date,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xff19649E))),
    ),
  );
}

Widget CoverWidget({required double profileHeight}) {
  return Container(
    color: Color(0xff19649E),
    width: double.infinity,
    height: profileHeight,
  );
}

Widget namedTextWidget(String name, String profession) {
  return Column(children: [
    Text(
      name,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
    ),
    SizedBox(
      height: 10,
    ),
    Text(
      profession,
      style: TextStyle(
          color: Color(0xff19649E), fontWeight: FontWeight.bold, fontSize: 20),
    ),
  ]);
}

Widget profilePage(double profileHeight, String img) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(profileHeight / 3),
    ),
    child: Padding(
      padding: EdgeInsets.all(10),
      child: CircleAvatar(
        radius: profileHeight / 3,
        backgroundColor: Colors.transparent,
        child: img == "" || img == null
            ? Image(
                image: AssetImage(
                  "assets/images/profile.png",
                ),
                fit: BoxFit.fill,
              )
            : Image(image: NetworkImage(img)),
      ),
    ),
  );
}
