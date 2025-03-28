import 'package:doctor/models/Doctor_id_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../cubit/doctor_details_cubit/doctor_profile_cubit.dart';
import '../../cubit/doctor_details_cubit/doctor_profile_state.dart';
import '../../cubit/reset_password_cubit/reset_password_cubit.dart';


class SpecialistChangePassword extends StatefulWidget {
  const SpecialistChangePassword({super.key});

  @override
  State<SpecialistChangePassword> createState() => _SpecialistChangePasswordState();
}

class _SpecialistChangePasswordState extends State<SpecialistChangePassword> {
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  late DoctorProfileCubit userProfileCubit;
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<DoctorProfileCubit>(context); // Initialize the cubit
    _loadUserProfile();

  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('doctorId') ?? "";

    // Set the state once the user profile data is fetched
    userProfileCubit.getUserProfile(context, id);
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width.w;
    double screenHeight = MediaQuery.of(context).size.height.h;
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
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: const Color(0xff19649E),
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                  centerTitle: true,
                  title: Text(
                    "passwordManager".tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth.w * 0.06.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: screenWidth,
                                height: screenHeight * 0.18.h, // Adjust height proportionally
                                decoration: BoxDecoration(
                                  color: Color(0xff19649E),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                // child: Padding(
                                //   padding: const EdgeInsets.only(right: 16.0, top: 40),
                                //   child: Container(
                                //     width: screenWidth * 0.9,
                                //     child: Row(
                                //       crossAxisAlignment: CrossAxisAlignment.start,
                                //       mainAxisAlignment: MainAxisAlignment.start,
                                //       children: [
                                //         Text(
                                //           "settings".tr(),
                                //           textAlign: TextAlign.center,
                                //           style: TextStyle(
                                //             fontSize: screenWidth * 0.06,
                                //             color: Colors.white,
                                //             fontWeight: FontWeight.bold,
                                //           ),
                                //         ),
                                //         SizedBox(width: 120),
                                //         GestureDetector(
                                //             onTap: (){
                                //               Navigator.pop(context);
                                //             },
                                //             child: Icon(Icons.arrow_forward, color: Colors.white)),
                                //       ],
                                //     ),
                                //   ),
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
                                        Container(
                                          height: screenWidth * 0.3.h,
                                          width: screenWidth * 0.3.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(40),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),

                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(50), // زاوية الإطار
                                                child: userProfile.specialist?.imageUrl==""||userProfile.specialist?.imageUrl==null?Image.asset("assets/images/profile.jpg",fit: BoxFit.fill,):Image.network(
                                                  userProfile.specialist?.imageUrl ?? "", // رابط الصورة
                                                  fit: BoxFit.fill, // ملء الصورة
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Positioned(
                                          bottom: 10,
                                          left: 10,
                                          child: CircleAvatar(
                                            radius: 16,
                                            backgroundColor:  Color(0xff19649E),
                                            child: Icon(Icons.edit,
                                                size: 16, color: Colors.white),
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
                          Positioned(
                            left: screenWidth * 0.35.w,
                            top: -100,
                            child: Text(
                              "${userProfileCubit.userData?.specialist?.firstName}",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: screenWidth.w * 0.06.sp,
                                color: const Color(0xff19649E),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 420.h,
                        child: Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Form(
                                      key:formKey,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "newPassword".tr(),
                                            // textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Color(0xff19649E),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: screenHeight * 0.01.h),
                                          Center(
                                            child: Container(
                                              width: 327.w,
                                              height: 48.h,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(11),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.3),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: TextFormField(
                                                controller: passwordController,
                                                validator:  (String? value) {
                                                  value = passwordController.text;
                                                  if (value == null || value.length < 8) {
                                                    return "passwordLength".tr();
                                                  }
                                                  return null;
                                                },
                                                // textDirection: TextDirection.rtl,
                                                // textAlign: TextAlign.right,
                                                obscureText: _isObscure1,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  EdgeInsets.symmetric(horizontal: 16),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(11),
                                                    borderSide: BorderSide.none,
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      _isObscure1
                                                          ? Icons.visibility_off_rounded
                                                          : Icons.visibility_rounded,
                                                      color: Colors.grey,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isObscure1 = !_isObscure1;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.01.h),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "confirmPassword".tr(),
                                          // textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Color(0xff19649E),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: screenHeight* 0.01.h),
                                        Center(
                                          child: Container(
                                            width: 327.w,
                                            height: 48.h,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(11),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.3),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: TextFormField(
                                              controller: confirmPasswordController,
                                              // textDirection: TextDirection.rtl,
                                              // textAlign: TextAlign.right,
                                              obscureText: _isObscure2,
                                              validator: (String? value) {
                                                value = passwordController.text;
                                                if (value != confirmPasswordController.text) {
                                                  return "matchPassword".tr();
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                contentPadding:
                                                EdgeInsets.symmetric(horizontal: 16),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(11),
                                                  borderSide: BorderSide.none,
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                    _isObscure2
                                                        ? Icons.visibility_off_rounded
                                                        : Icons.visibility_rounded,
                                                    color: Colors.grey,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _isObscure2 = !_isObscure2;
                                                    });
                                                  },
                                                ),
                                              ),
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: screenHeight* 0.09.h),
                              Center(
                                child: GestureDetector(
                                  onTap: (){
                                    if (formKey.currentState!.validate()) {
                                      BlocProvider.of<ResetPasswordCubit>(context)
                                          .resetPasswordByEmail(context, userProfileCubit.userData?.specialist?.email??"",
                                          passwordController.text,"doctor");
                                      passwordController.clear();
                                      confirmPasswordController.clear();
                                      FocusScopeNode currentFocus = FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }

                                    }
                                  },
                                  child: Container(
                                    width: 327.w,
                                    height: 48.h,
                                    decoration: BoxDecoration(
                                      color: Color(0xff19649E),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "update".tr(),
                                        style: TextStyle(
                                          fontSize: 24.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
