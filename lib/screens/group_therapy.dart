import 'package:doctor/cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import 'package:doctor/cubit/update_user_cubit/update_user_cubit.dart';
import 'package:doctor/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:doctor/models/sessionType.dart';
import 'package:doctor/screens/specialists_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/create_session.dart/create_session_cubit.dart';
import '../cubit/create_session.dart/create_session_state.dart';
import '../widgets/custom_bottom_nav_bar.dart';

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

  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    descController = TextEditingController();
    createSessionCubit = BlocProvider.of<CreateSessionCubit>(context);

    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";
    userProfileCubit.getUserProfile(context, id);
  }

  // final _positivesController = TextEditingController();

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
                  hintText: "GroupTherapyDef".tr(),
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
}
