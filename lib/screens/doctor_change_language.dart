import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import '../cubit/doctor_details_cubit/doctor_profile_cubit.dart';
import '../cubit/doctor_details_cubit/doctor_profile_state.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../models/Doctor_id_model.dart';
import '../models/user_profile_model.dart';

class DoctorChangeLanguage extends StatefulWidget {
  const DoctorChangeLanguage({super.key});

  @override
  State<DoctorChangeLanguage> createState() => _DoctorChangeLanguageState();
}

class _DoctorChangeLanguageState extends State<DoctorChangeLanguage> {

  int _currentPage = 0;
  final int totalPages = 2;

  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  late DoctorProfileCubit userProfileCubit;
  late AddImageToProfileCubit addImageToProfileCubit;

  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<DoctorProfileCubit>(context);
    addImageToProfileCubit = BlocProvider.of<AddImageToProfileCubit>(context);// Initialize the cubit
    _loadUserProfile();
    // Call the asynchronous method here
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('doctorId') ?? "";

    // Set the state once the user profile data is fetched
    userProfileCubit.getUserProfile(context, id);
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
        create: (_) => userProfileCubit,  // Use the same cubit instance
        child: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
          builder: (context, state) {
            if (state is DoctorProfileLoading) {
              return Scaffold(body: Center(child: CircularProgressIndicator(),));
            } else if (state is DoctorProfileFailure) {
              return Center(child: Text("Error loading profile: ${state.error}"));
            } else if (state is DoctorProfileSuccess) {
              // Once the profile is loaded, show the actual UI
              DoctorByIdModel userProfile = state.doctorProfile;
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: const Color(0xff19649E),
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                  centerTitle: true,
                  title: Text(
                    "changeLanguage".tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth.w * 0.06.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                body: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: screenWidth,
                          height: screenHeight.h * 0.18.h, // Adjust height proportionally
                          decoration: const BoxDecoration(
                            color: Color(0xff19649E),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
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
                                    onTap: (){
                                      setState(() async{
                                        final prefs = await SharedPreferences.getInstance();
                                        String? id=prefs.getString('doctorId');
                                        addImageToProfileCubit.pickImage(context,id??"");
                                        BlocProvider.of<UserProfileCubit>(context).getUserProfile(context, id??"");
                                      });

                                    },
                                    child: Container(
                                      height: screenWidth.w * 0.3.h,
                                      // Adjust size proportionally
                                      width: screenWidth.w * 0.3.w,
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
                                            borderRadius: BorderRadius.circular(50), // زاوية الإطار
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
                                    onPressed: (){
                                      setState(() async{
                                        final prefs = await SharedPreferences.getInstance();
                                        String? id=prefs.getString('doctorId');
                                        addImageToProfileCubit.pickImage(context,id??"");
                                        BlocProvider.of<UserProfileCubit>(context).getUserProfile(context, id??"");
                                      });
                                    },
                                    icon: Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: CircleAvatar(
                                        radius: 16,
                                        backgroundColor: Color(0xff19649E),
                                        child: Icon(Icons.edit, size: 16, color: Colors.white),
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
                    SizedBox(height: 55.h),
                    Text(
                      "${userProfile.specialist?.firstName} "+"doctor".tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: screenWidth * 0.06.sp,
                        color: const Color(0xff19649E),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 40, 25, 5),
                      child: Column(
                        children: [
                          Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF19649E),
                              borderRadius: BorderRadius.circular(10), // Circular shape
                            ),
                            child: NavigationBar(

                              backgroundColor: Colors.transparent,
                              height: 50.h,
                              destinations: [
                                TextButton(
                                  onPressed: () {
                                    _onItemTapped(0);
                                    EasyLocalization.of(context)?.setLocale(const Locale('ar'));

                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    backgroundColor:
                                    _currentPage == 0 ? Colors.white : Colors.transparent,
                                  ),
                                  child: Text(
                                    "arabic".tr(),
                                    style: TextStyle(
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.bold,
                                      color: _currentPage == 0
                                          ? const Color(0xFF19649E)
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _onItemTapped(1);
                                    EasyLocalization.of(context)?.setLocale(const Locale('en'));

                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    backgroundColor:
                                    _currentPage == 1 ? Colors.white : Colors.transparent,
                                  ),
                                  child: Text(
                                    "english".tr(),
                                    style: TextStyle(
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.bold,
                                        color: _currentPage == 1
                                            ? const Color(0xFF19649E)
                                            : Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 150.h,),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {

                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(700, 50), backgroundColor: const Color(0xFF19649E),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: Text(
                                "update".tr(),
                                style:  TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
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
