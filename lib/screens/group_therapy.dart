import 'package:doctor/cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import 'package:doctor/cubit/get_treatment_program_cubit/get_treatment_program_cubit.dart';
import 'package:doctor/cubit/update_user_cubit/update_user_cubit.dart';
import 'package:doctor/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:doctor/models/sessionType.dart';
import 'package:doctor/screens/sign_up_as_client.dart';
import 'package:doctor/screens/specialists_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/create_session.dart/create_session_cubit.dart';
import '../cubit/create_session.dart/create_session_state.dart';
import '../cubit/get_all_ads/get_all_ads_cubit.dart';
import '../cubit/get_sub_categories_cubit/get_sub_categories_cubit.dart';
import '../cubit/get_treatment_program_cubit/get_treatment_program_state.dart';
import '../make_email/login.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'applicationInfo.dart';
import 'first_home_page.dart';
import 'homescreen.dart' show HomeScreen;

class GroupTherapy extends StatefulWidget {
  const GroupTherapy({super.key});

  @override
  State<GroupTherapy> createState() => _GroupTherapyState();
}

class _GroupTherapyState extends State<GroupTherapy> {
  final List<String> problemSlots = [];
  final List<String> goalSlots = [];

  final Map<String, bool> _problems = {
    "addictionCheck".tr(): false,
    "familyDispute".tr(): false,
    "anxiety".tr(): false,
    "depression".tr(): false,
    "socialPhobia".tr(): false,
    "obsessiveDisorder".tr(): false,
    "other".tr(): false,
  };

  final Map<String, bool> _goals = {
    "therapy".tr(): false,
    "emotionalVenting".tr(): false,
    "socialSkill".tr(): false,
    "solveProblems".tr(): false,
    "other".tr(): false,
  };

  final _formKey = GlobalKey<FormState>();
  late CreateSessionCubit createSessionCubit;
  TextEditingController descController = TextEditingController();
  late UserProfileCubit userProfileCubit;
  late GetTreatmentProgramCubit getTreatmentProgramCubit;

  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    descController = TextEditingController();
    createSessionCubit = BlocProvider.of<CreateSessionCubit>(context);
    getTreatmentProgramCubit= BlocProvider.of<GetTreatmentProgramCubit>(context);
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";
    getTreatmentProgramCubit.fetchProgramByName(context, "Group Therapy");
    userProfileCubit.getUserProfile(context, id);
  }

  // final _positivesController = TextEditingController();
  int currentIndex=1;
  @override
  void dispose() {
    descController.dispose();

    // _positivesController.dispose();
    super.dispose();
  }

  String? _validateCheckboxes(Map<String, bool> map, String errorMessage) {
    bool isAnySelected = map.values.any((value) => value == true);
    return isAnySelected ? null : errorMessage;
  }

  List<String> _getSelectedStrings(Map<String, bool> map) {
    return map.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
  }

  // void _submitForm() {
  //   bool isFormValid = _formKey.currentState!.validate();
  //
  //   String? problemError =
  //       _validateCheckboxes(_problems, "Please select at least one problem.");
  //   String? goalError =
  //       _validateCheckboxes(_goals, "Please select at least one goal.");
  //
  //   if (isFormValid && problemError == null && goalError == null) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => MultiBlocProvider(
  //           providers: [
  //             BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
  //             BlocProvider<AddImageToProfileCubit>(
  //                 create: (_) => AddImageToProfileCubit()),
  //             BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
  //           ],
  //           child: SpecialistsScreen(
  //             sessionType: GruopTherapSession(),
  //           ),
  //         ),
  //       ),
  //     );
  //     // ScaffoldMessenger.of(context).showSnackBar(
  //     //   const SnackBar(content: Text("Form submitted successfully!")),
  //     // );
  //   } else {
  //     String errorMessage = "";
  //     if (!isFormValid) {
  //       errorMessage = "Please fill in all required fields.";
  //     } else if (problemError != null) {
  //       errorMessage = problemError;
  //     } else if (goalError != null) {
  //       errorMessage = goalError;
  //     }
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(errorMessage)),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height.h;
    double screenWidth = MediaQuery.of(context).size.width.w;
    return BlocProvider(
        create: (_) => getTreatmentProgramCubit, // Use the same cubit instance
        child: BlocBuilder<GetTreatmentProgramCubit, GetTreatmentProgramState>(
          builder: (context, state) {
            if (state is GetTreatmentProgramLoading) {
              return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ));
            } else if (state is GetTreatmentProgramFailure) {
              return Scaffold(
                backgroundColor: Colors.white,
                bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: const Color(
                      0xff19649E), // Ensures the background is consistent
                  selectedItemColor:
                  Colors.white, // Sets the color of the selected icons
                  unselectedItemColor:
                  Colors.black, // Sets the color of unselected icons
                  showSelectedLabels: false, // Hides selected labels
                  showUnselectedLabels: false, // Hides unselected labels
                  currentIndex: currentIndex, // Default selected index
                  type: BottomNavigationBarType
                      .fixed, // Prevents animation on shifting types
                  items: [
                    BottomNavigationBarItem(
                      icon: SizedBox(
                        height: 27.h, // Adjust icon size
                        child: Image.asset(
                          "assets/images/meteor-icons_home.png",
                          // color: currentIndex == 0 ? Colors.white : Colors.black,
                          fit: BoxFit.fill,
                        ),
                      ),
                      activeIcon: SizedBox(
                        height: 27.h, // Active icon size adjustment
                        child: Image.asset(
                          "assets/images/meteor-icons_home.png",
                          color:
                          currentIndex == 0 ? Colors.white : Colors.black,
                          fit: BoxFit.fill,
                        ),
                      ),
                      label: "home".tr(),
                    ),
                    BottomNavigationBarItem(
                      icon: SizedBox(
                        height: 27.h,
                        child: Image.asset(
                          "assets/images/nrk_category1.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      activeIcon: SizedBox(
                        height: 27.h,
                        child: Image.asset(
                          "assets/images/nrk_category.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      label: "menu".tr(),
                    ),
                    BottomNavigationBarItem(
                      icon: SizedBox(
                        height: 25.h, // Adjust icon size
                        child: Image.asset(
                          "assets/images/material-symbols_help-clinic-outline-rounded.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      activeIcon: SizedBox(
                        height: 33.h,
                        // width: 50,
                        child: Image.asset(
                          "assets/images/material-symbols_help-clinic-outline-rounded_Active.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      label: "info".tr(),
                    ),
                    BottomNavigationBarItem(
                      icon: SizedBox(
                        height: 27.h,
                        child: Image.asset(
                          "assets/images/gg_profile.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      activeIcon: SizedBox(
                        height: 27.h,
                        child: Image.asset(
                          "assets/images/gg_profile1.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      label: "profile".tr(),
                    ),
                  ],
                  onTap: (index) {
                    switch (index) {
                      case 3:
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("alert".tr()),
                            content: Text(
                              "guestAccessibilityAlert".tr(),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // إغلاق الـ Alert
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoginPage()), // استبدليها بصفحة تسجيل الدخول
                                  );
                                },
                                child: Text("login".tr()),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // إغلاق الـ Alert
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SignUpAsClient()), // استبدليها بصفحة التسجيل
                                  );
                                },
                                child: Text("createAccount".tr()),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(
                                      context); // إغلاق الـ Alert بدون أي انتقال
                                },
                                child: Text("cancel".tr()),
                              ),
                            ],
                          ),
                        );
                        break;
                      case 1:
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                                  BlocProvider<SubCategoriesCubit>(create: (_) => SubCategoriesCubit()),
                                  BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                                  BlocProvider<GetAllAdsCubit>(create: (_) => GetAllAdsCubit()),
                                ],
                                child: const HomeScreen(),
                              ),
                            ));
                        break;
                      case 2:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ApplicationInfo()));

                        break;

                      case 0:

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                                  BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                                  BlocProvider<SubCategoriesCubit>(create: (_) => SubCategoriesCubit()),
                                  BlocProvider<GetAllAdsCubit>(create: (_) => GetAllAdsCubit()),
                                ],
                                child: const FirstHomePage(),
                              ),
                            ));
                        break;
                    }
                  },
                ),
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(35.0.h),
                  child: AppBar(
                    backgroundColor: Colors.white,
                    iconTheme: const IconThemeData(
                      color: Color(0xff19649E),
                    ),
                  ),
                ),
                body: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child:
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 50.h,
                          width: 250.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color(0xFF19649E),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "theGroupTherapy".tr(),
                              style: TextStyle(fontSize: 20.sp, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Text(
                          "whatGroupTherapy".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01.h),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          readOnly: true,
                          maxLines: null,
                          style: TextStyle(fontSize: 14.sp, height: 1.6.h),
                          decoration: InputDecoration(
                            hintText: getTreatmentProgramCubit.programs?.treatmentPlan??"GroupTherapyDef".tr(),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return "Please enter what group therapy means to you.";
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01.h),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Text(
                          "positives".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01.h),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          readOnly: true,
                          initialValue: getTreatmentProgramCubit.programs?.importance??"",
                          // controller: _positivesController,
                          maxLines: null,
                          style: TextStyle(fontSize: 14.sp, height: 1.6.h),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return "Please enter the positives of group therapy.";
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01.h),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Text(
                          "problemsExperiencing".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Wrap(
                            children: _problems.keys.map((problem) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width / 2.w,
                                child: CheckboxListTile(
                                  checkColor: Colors.white,
                                  activeColor: const Color(0xff19649E),
                                  side: const BorderSide(
                                      color: Color(0xff19649E), width: 2),
                                  title: Text(problem, textAlign: TextAlign.start),
                                  value: _problems[problem],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _problems[problem] = value ?? false;
                                    });
                                  },
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01.h),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Text(
                          "goals".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Wrap(
                            children: _goals.keys.map((goal) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width / 2.w,
                                child: CheckboxListTile(
                                  title: Text(goal, textAlign: TextAlign.start),
                                  value: _goals[goal],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _goals[goal] = value ?? false;
                                    });
                                  },
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),

                      BlocConsumer<CreateSessionCubit, CreateSessionState>(
                        listener: (context, state) {
                          print("statttttttttttttttttte");
                          print(state.runtimeType);
                          if (state is CreateSessionLoading) {
                            // يمكنك إضافة أي منطق إضافي هنا أثناء التحميل
                          } else if (state is CreateSessionSuccess) {
                            print("success");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Session Created Successfully!")),
                            );
                          } else if (state is CreateSessionError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: ${state.message}")),
                            );
                          }
                        },
                        builder: (context, state) {
                          bool isLoading = state is CreateSessionLoading;

                          return GestureDetector(
                            onTap: () {
                              try {
                                if (!isLoading) {
                                  List<String> selectedProblems = _getSelectedStrings(_problems);
                                  List<String> selectedGoals = _getSelectedStrings(_goals);

                                  createSessionCubit.createSession(
                                    null,
                                    null,
                                    null,
                                    GruopTherapSession(problems: selectedProblems), // تأكد من إنشاء GruopTherapSession() بشكل صحيح
                                  );
                                }
                              } catch (e, stackTrace) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("An error occurred: $e")),
                                );
                                debugPrint("Error: $e\nStack Trace: $stackTrace");
                              }
                            },
                            child: Center(
                              child: Container(
                                width: screenWidth * 0.7.w,
                                height: 48.h,
                                decoration: BoxDecoration(
                                  color: isLoading
                                      ? Colors.grey
                                      : Color(0xff19649E),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: isLoading
                                      ? CircularProgressIndicator() // Show loading spinner
                                      : Text(
                                    'approve'.tr(),
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),


                      SizedBox(height: screenHeight * 0.05.h),
                    ]),
                  ),
                ),
              );
            }
            else if (state is GetTreatmentProgramSuccess) {
              // Once the profile is loaded, show the actual UI


              return Scaffold(
                backgroundColor: Colors.white,
                bottomNavigationBar: const CustomBottomNavBar(
                  currentIndex: 1,
                ),
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(35.0.h),
                  child: AppBar(
                    backgroundColor: Colors.white,
                    iconTheme: const IconThemeData(
                      color: Color(0xff19649E),
                    ),
                  ),
                ),
                body: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child:
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 50.h,
                          width: 250.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color(0xFF19649E),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "theGroupTherapy".tr(),
                              style: TextStyle(fontSize: 20.sp, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Text(
                          "whatGroupTherapy".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01.h),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          readOnly: true,
                          maxLines: null,
                          style: TextStyle(fontSize: 14.sp, height: 1.6.h),
                          decoration: InputDecoration(
                            hintText: state.programs?.treatmentPlan??"GroupTherapyDef".tr(),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return "Please enter what group therapy means to you.";
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01.h),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Text(
                          "positives".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01.h),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          readOnly: true,
                          initialValue: state.programs?.importance??"",
                          // controller: _positivesController,
                          maxLines: null,
                          style: TextStyle(fontSize: 14.sp, height: 1.6.h),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return "Please enter the positives of group therapy.";
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01.h),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Text(
                          "problemsExperiencing".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Wrap(
                            children: _problems.keys.map((problem) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width / 2.w,
                                child: CheckboxListTile(
                                  checkColor: Colors.white,
                                  activeColor: const Color(0xff19649E),
                                  side: const BorderSide(
                                      color: Color(0xff19649E), width: 2),
                                  title: Text(problem, textAlign: TextAlign.start),
                                  value: _problems[problem],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _problems[problem] = value ?? false;
                                    });
                                  },
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01.h),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Text(
                          "goals".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Wrap(
                            children: _goals.keys.map((goal) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width / 2.w,
                                child: CheckboxListTile(
                                  title: Text(goal, textAlign: TextAlign.start),
                                  value: _goals[goal],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _goals[goal] = value ?? false;
                                    });
                                  },
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),

                      BlocConsumer<CreateSessionCubit, CreateSessionState>(
                        listener: (context, state) {
                          print("statttttttttttttttttte");
                          print(state.runtimeType);
                          if (state is CreateSessionLoading) {
                            // يمكنك إضافة أي منطق إضافي هنا أثناء التحميل
                          } else if (state is CreateSessionSuccess) {
                            print("success");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Session Created Successfully!")),
                            );
                          } else if (state is CreateSessionError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: ${state.message}")),
                            );
                          }
                        },
                        builder: (context, state) {
                          bool isLoading = state is CreateSessionLoading;

                          return GestureDetector(
                            onTap: () {
                              try {
                                if (!isLoading) {
                                  List<String> selectedProblems = _getSelectedStrings(_problems);
                                  List<String> selectedGoals = _getSelectedStrings(_goals);

                                  createSessionCubit.createSession(
                                    null,
                                    null,
                                    null,
                                    GruopTherapSession(problems: selectedProblems), // تأكد من إنشاء GruopTherapSession() بشكل صحيح
                                  );
                                }
                              } catch (e, stackTrace) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("An error occurred: $e")),
                                );
                                debugPrint("Error: $e\nStack Trace: $stackTrace");
                              }
                            },
                            child: Center(
                              child: Container(
                                width: screenWidth * 0.7.w,
                                height: 48.h,
                                decoration: BoxDecoration(
                                  color: isLoading
                                      ? Colors.grey
                                      : Color(0xff19649E),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: isLoading
                                      ? CircularProgressIndicator() // Show loading spinner
                                      : Text(
                                    'approve'.tr(),
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      // ElevatedButton(
                      //   onPressed: _submitForm,
                      //   // () {
                      //   // showDialog(
                      //   //   context: context,
                      //   //   builder: (context) {
                      //   //     return AlertDialog(
                      //   //       title: Text("registered".tr()),
                      //   //       content: Text("groupNote".tr()),
                      //   //       actions: [
                      //   //         TextButton(
                      //   //           onPressed: () {
                      //   //             Navigator.of(context)
                      //   //                 .pop(); // Close the dialog
                      //   //           },
                      //   //           child: Text('ok'.tr()),
                      //   //         ),
                      //   //       ],
                      //   //     );
                      //   //   },
                      //   // ).then((_) {
                      //   //   // This code will run after the dialog is closed
                      //
                      //   //   Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
                      //   // }
                      //   // );
                      //   // },
                      //   style: ElevatedButton.styleFrom(
                      //       minimumSize: const Size(350, 50),
                      //       backgroundColor: const Color(0xFF19649E),
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10))),
                      //   child: Text(
                      //     "approve".tr(),
                      //     style: TextStyle(
                      //         fontSize: 20.sp,
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.white),
                      //   ),
                      // ),

                      SizedBox(height: screenHeight * 0.05.h),
                    ]),
                  ),
                ),
              );
            }
            return Container(); // Default return in case no state matches
          },
        ));
  }
}
