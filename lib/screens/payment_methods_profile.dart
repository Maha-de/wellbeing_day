import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../models/user_profile_model.dart';
import '../widgets/custom_app_bar.dart';
import 'add_credit_card_screen.dart';

class PaymentMethodsProfile extends StatefulWidget {
  const PaymentMethodsProfile({super.key});

  @override
  State<PaymentMethodsProfile> createState() => _PaymentMethodsProfileState();
}

class _PaymentMethodsProfileState extends State<PaymentMethodsProfile> {

  late UserProfileCubit userProfileCubit;
  late AddImageToProfileCubit addImageToProfileCubit;
  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    addImageToProfileCubit = BlocProvider.of<AddImageToProfileCubit>(context);// Initialize the cubit
    _loadUserProfile();
    // Call the asynchronous method here
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";

    // Set the state once the user profile data is fetched
    userProfileCubit.getUserProfile(context, id);
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
        create: (_) => userProfileCubit,  // Use the same cubit instance
        child: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return Scaffold(body: Center(child: CircularProgressIndicator(),));
            } else if (state is UserProfileFailure) {
              return Center(child: Text("Error loading profile: ${state.error}"));
            } else if (state is UserProfileSuccess) {
              // Once the profile is loaded, show the actual UI
              UserProfileModel userProfile = state.userProfile;
              return Scaffold(
                backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(onPressed: (){Navigator.pop(context);},),
        backgroundColor: const Color(0xff19649E),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          "وسائل الدفع",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: screenWidth * 0.06.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
                body: Column(children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: screenHeight * 0.21.h,  // Adjust height proportionally
                        decoration: BoxDecoration(
                          color: Color(0xff19649E),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
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
                        // ), // child: Row(
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
                                  onTap: (){
                                    setState(() {
                                      addImageToProfileCubit.pickImage(context,userProfile.id??"");
                                      BlocProvider.of<UserProfileCubit>(context).getUserProfile(context, userProfile.id??"");
                                    });

                                  },
                                  child: Container(
                                    height: screenWidth * 0.3.h,
                                    // Adjust size proportionally
                                    width: screenWidth * 0.3.w,
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
                                          child: userProfile.imageUrl==""||userProfile.imageUrl==null?Image.asset("assets/images/profile.jpg",fit: BoxFit.fill,):Image.network(
                                            userProfile.imageUrl ?? "", // رابط الصورة
                                            fit: BoxFit.fill, // ملء الصورة
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: (){
                                    setState(() {
                                      addImageToProfileCubit.pickImage(context,userProfile.id??"");
                                      BlocProvider.of<UserProfileCubit>(context).getUserProfile(context, userProfile.id??"");
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
                  SizedBox(height: 50.h),
                  Positioned(
                    left: screenWidth * 0.35, // Adjust for better centering
                    top: -100,
                    child: Text(
                      "${userProfileCubit.userData?.firstName}",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: screenWidth * 0.06,
                        // Adjust size based on screen width
                        color: Color(0xff19649E),
                      ),
                    ),
                  ),
                  Center(
                    child:SizedBox(
                      height: screenHeight*0.39.h,
                      child: Center(
                        child: Container(
                          width: 343.w,
                          height: 150.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xff1F78BC)
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(right: 10),
                                width: 307,
                                child: Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                     Image(image: AssetImage("assets/images/neo.png"),width: 70.29.w,height: 30.h,fit: BoxFit.fill,),
                                    IconButton(
                                        onPressed: (){},
                                        icon:  Image(image: AssetImage("assets/images/left_arrow.png"),width: 12.w,height: 22.h,))
                                  ],
                                ),
                              ),
                              Center(
                                child: Container(
                                  width: 295.w,
                                  height: 1.h,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(right: 10),
                                width: 307,
                                child: Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                     Image(image: AssetImage("assets/images/visa.png"),width: 70.29.w,height: 20.h,fit: BoxFit.fill,),
                                    IconButton(
                                        onPressed: (){

                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddCreditCardScreen()));

                                        },
                                        icon:  Image(image: AssetImage("assets/images/left_arrow.png"),width: 12.w,height: 22.h,))
                                  ],
                                ),
                              ),
                              Center(
                                child: Container(
                                  width: 295.w,
                                  height: 1.h,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(right: 10),
                                width: 307.w,
                                child: Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                     Image(image: AssetImage("assets/images/logos_mastercard.png"),width: 70.29.w,height: 30.h,fit: BoxFit.fill,),
                                    IconButton(onPressed: (){}, icon:  Image(image: AssetImage("assets/images/left_arrow.png"),width: 12.w,height: 22.h,))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],),
    );
      }
      return Container();
    },
    ));
}
}
