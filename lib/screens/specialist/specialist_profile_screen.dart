import 'package:doctor/cubit/delete_account_cubit/delete_account_cubit.dart';
import 'package:doctor/cubit/update_user_cubit/update_user_cubit.dart';
import 'package:doctor/models/Doctor_id_model.dart';
import 'package:doctor/screens/client_profile_details.dart';
import 'package:doctor/screens/settings_screen.dart';
import 'package:doctor/screens/specialist/specialist_appointments_screen.dart';
import 'package:doctor/screens/specialist/specialist_profile_details_screen.dart';
import 'package:doctor/screens/specialist/specialist_settings_screen.dart';
import 'package:doctor/screens/specialist/specialist_work_hours_screen.dart';
import 'package:doctor/screens/splashscreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import '../../cubit/doctor_details_cubit/doctor_profile_cubit.dart';
import '../../cubit/doctor_details_cubit/doctor_profile_state.dart';
import '../../cubit/get_doctor_sessions_types_cubit/doctor_session_types_cubit.dart';
import '../../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../../cubit/user_profile_cubit/user_profile_state.dart';
import '../../models/user_profile_model.dart';
import '../../widgets/custom_bottom_nav_bar_specialist.dart';
import '../appointments_section.dart';
import '../cubit/available_slots_cubit.dart';

class SpecialistProfileScreen extends StatefulWidget {
  const SpecialistProfileScreen({super.key});

  @override
  State<SpecialistProfileScreen> createState() => _SpecialistProfileScreenState();
}

class _SpecialistProfileScreenState extends State<SpecialistProfileScreen> {
  late DoctorProfileCubit doctorProfileCubit;
  late AddImageToProfileCubit addImageToProfileCubit;
  final availableSlotsCubit = AvailableSlotsCubit();

  @override
  void initState() {
    super.initState();
    doctorProfileCubit = BlocProvider.of<DoctorProfileCubit>(context);
    addImageToProfileCubit = BlocProvider.of<AddImageToProfileCubit>(
        context); // Initialize the cubit
    _loadUserProfile();
    // Call the asynchronous method here
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('doctorId') ?? "";

    // Set the state once the user profile data is fetched
    doctorProfileCubit.getUserProfile(context, id);
  }

  @override
  Widget build(BuildContext context) {
    List<String> actions = [
      "yourProfile".tr(),
      "settings".tr(),
      "appointments".tr(),
      "signOut".tr()
    ];

    double screenWidth = MediaQuery.of(context).size.width.w;
    double screenHeight = MediaQuery.of(context).size.height.h;

    return BlocProvider(
        create: (_) => doctorProfileCubit, // Use the same cubit instance
        child: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
          builder: (context, state) {
            if (state is DoctorProfileLoading) {
              return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ));
            } else if (state is DoctorProfileFailure) {
              return Center(
                  child: Text("Error loading profile: ${state.error}"));
            } else if (state is DoctorProfileSuccess) {
              // Once the profile is loaded, show the actual UI
              DoctorByIdModel userProfile = state.doctorProfile;
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  leading: null,
                  backgroundColor: const Color(0xff19649E),
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                ),
                bottomNavigationBar: const SpecialistCustomBottomNavBar(
                  currentIndex: 3,
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: screenHeight *
                              0.2, // Adjust height proportionally
                          decoration: BoxDecoration(
                            color: Color(0xff19649E),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          // child: Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     Padding(
                          //       padding: const EdgeInsets.only(right: 16.0, top: 30),
                          //       child: GestureDetector(
                          //           onTap: (){
                          //             Navigator.pop(context);
                          //           },
                          //           child: Icon(Icons.arrow_forward, color: Colors.white)),
                          //     ),
                          //   ],
                          // ),
                        ),
                        Positioned(
                          bottom: -50,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        addImageToProfileCubit.pickImage(
                                            context, userProfile.specialist?.id ?? "");
                                        BlocProvider.of<UserProfileCubit>(
                                            context)
                                            .getUserProfile(context,
                                            userProfile.specialist?.id ?? "");
                                      });
                                    },
                                    child: Container(
                                      height: 126.h,
                                      // Adjust size proportionally
                                      width: 126.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(40),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(30),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(
                                                50), // زاوية الإطار
                                            child: userProfile.specialist?.imageUrl ==
                                                "" ||
                                                userProfile.specialist?.imageUrl ==
                                                    null
                                                ? Image.asset(
                                              "assets/images/profile.jpg",
                                              fit: BoxFit.fill,
                                            )
                                                : Image.network(
                                              userProfile.specialist?.imageUrl ??
                                                  "", // رابط الصورة
                                              fit: BoxFit
                                                  .fill, // ملء الصورة
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        addImageToProfileCubit.pickImage(
                                            context, userProfile.specialist?.id ?? "");
                                        BlocProvider.of<UserProfileCubit>(
                                            context)
                                            .getUserProfile(context,
                                            userProfile.specialist?.id ?? "");
                                      });
                                    },
                                    icon: Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: CircleAvatar(
                                        radius: 16,
                                        backgroundColor: Color(0xff19649E),
                                        child: Icon(Icons.edit,
                                            size: 16, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 35.h),
                    Positioned(
                      left: screenWidth * 0.35.w, // Adjust for better centering
                      top: -100,
                      child: Text(
                        "${doctorProfileCubit.firstNameController.text}",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20.sp, // Adjust size based on screen width
                          color: Color(0xff19649E),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h,),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 5, left: 5, right: 5, bottom: 5),
                        height: 293.h,
                        width: 343.w,// Adjust height proportionally
                        child: ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                if (index == 0) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MultiBlocProvider(providers: [
                                            BlocProvider<DoctorProfileCubit>(
                                                create: (_) =>
                                                   DoctorProfileCubit()),
                                            BlocProvider<AddImageToProfileCubit>(
                                                create: (_) =>
                                                    AddImageToProfileCubit()),
                                            BlocProvider<UpdateUserCubit>(
                                                create: (_) => UpdateUserCubit()),
                                          ], child: SpecialistProfileDetailsScreen()),
                                    ),
                                  );
                                } else if (index == 1) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MultiBlocProvider(providers: [
                                            BlocProvider<DoctorProfileCubit>(
                                                create: (_) =>
                                                    DoctorProfileCubit()),
                                            BlocProvider<DeleteAccountCubit>(
                                                create: (_) =>
                                                    DeleteAccountCubit()),
                                            BlocProvider<UpdateUserCubit>(
                                                create: (_) => UpdateUserCubit()),
                                            BlocProvider<AddImageToProfileCubit>(
                                                create: (_) =>
                                                    AddImageToProfileCubit()),
                                          ], child: SpecialistSettingsScreen()),
                                    ),
                                  );
                                } else if (index == 2) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MultiBlocProvider(
                                        providers: [
                                          BlocProvider.value(value: availableSlotsCubit),
                                          BlocProvider<DoctorProfileCubit>(create: (_) => DoctorProfileCubit()),
                                          BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                                          BlocProvider<DoctorSessionTypesCubit>(create: (_) => DoctorSessionTypesCubit()),
                                          BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                                        ],
                                        child: const SpecialistWorkHoursScreen(),
                                      ),
                                    ),
                                  );
                                }  else if (index == 3) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                          create: (_) => UserProfileCubit(),
                                          child: SplashScreen()),
                                    ),
                                  );
                                  final prefs =
                                  await SharedPreferences.getInstance();
                                  prefs.remove("doctorId");
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: 5, top: 10, left: 5, right: 5),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            actions[index],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.sp, // Adjust text size
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Color(0xff19649E),
                                          size: 25, // Adjust icon size proportionally
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin:
                                      EdgeInsets.only(top: 15, left: 12),
                                      width: 320.w,
                                      height: 2.h,
                                      color: Color(0xff19649E),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container(); // Default return in case no state matches
          },
        ));
  }
}
