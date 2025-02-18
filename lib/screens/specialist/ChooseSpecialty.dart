import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
import '../../cubit/doctor_sign_up_cubit/doctor_sign_up_cubit.dart';
import '../../make_email/login.dart';
import '../../models/Specialist.dart';
import '../../widgets/custom_snake_bar.dart';

class ChooseSpecialty extends StatefulWidget {
  final Specialist doctor;

  const ChooseSpecialty({super.key, required this.doctor});

  @override
  State<ChooseSpecialty> createState() => _ChooseSpecialtyState();
}

class _ChooseSpecialtyState extends State<ChooseSpecialty> {
  final Map<String, Map<String, bool>> _categories = {
    'mentalHealth'.tr(): {
      'psychologicalDisorders'.tr(): false,
      'therapeuticPrograms'.tr(): false,
      'groupTherapy'.tr(): false,
      'childrenDisorder'.tr(): false,
      'solveProblems'.tr(): false,
      'guidanceAndInstructions'.tr(): false,
      'PsychologicalPreventionAndFollowUp'.tr(): false,
      'rehabilitation'.tr(): false,
    },
    'skillDevelopment'.tr(): {
      'relax'.tr(): false,
      'stressManagement'.tr(): false,
      'emotionalControl'.tr(): false,
      'dialecticalStrategies'.tr(): false,
      'achievingBalance'.tr(): false,
      'improvingTrust'.tr(): false,
      'achievingGoals'.tr(): false,
      'achievingSuccess'.tr(): false,
      'traumaDisorder'.tr(): false,
    },
    'mentalDisorder'.tr(): {
      'anxiety'.tr(): false,
      'depression'.tr(): false,
      'phobia'.tr(): false,
      'obsessiveDisorder'.tr(): false,
      'sexualDisorder'.tr(): false,
      'eatingDisorder'.tr(): false,
      'personalityDisorder'.tr(): false,
      'addiction'.tr(): false,
      'traumaDisorder'.tr(): false,
    },
    'physicalHealth'.tr(): {
      'diet'.tr(): false,
      'SportsSystem'.tr(): false,
      'HealthCare'.tr(): false,
      'examinations'.tr(): false,
    },
  };

  final List<String> rightColumnCategories = [
    'mentalDisorder'.tr(),
    'physicalHealth'.tr(),
  ];

  final List<String> leftColumnCategories = [
    'mentalHealth'.tr(),
    'skillDevelopment'.tr(),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width.w;
    double screenHeight = MediaQuery.of(context).size.height.h;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Center(
            child: Text(
              "pickYour".tr(),
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18.sp,
                color: Color(0xff19649E),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: ListView(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Right Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: rightColumnCategories
                            .map(
                              (category) => buildCategory(
                                category,
                                _categories[category]!,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    // Left Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: leftColumnCategories
                            .map(
                              (category) => buildCategory(
                                category,
                                _categories[category]!,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          InkWell(
            onTap: () {
              String selectedSpecialities = getSelectedSpecialities('');
              if (selectedSpecialities.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar(
                    context: context,
                    message: "chooseOneChoice".tr(),
                    backgroundColor: Colors.red,
                    icon: Icons.error,
                  ),
                );
              } else {
                widget.doctor.specialties = selectedSpecialities;
                context.read<SignUpSpecialistCubit>().signUp(widget.doctor);
              }
            },
            child: Container(
              width: screenWidth * 0.9.w,
              height: screenHeight * 0.05.h,
              decoration: BoxDecoration(
                color: const Color(0xff19649E),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Center(
                child: Text(
                  'createAccount'.tr(),
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'alreadyHaveAnAccount'.tr(),
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  'signIn'.tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(0xff19649E),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getSelectedSpecialities(String categoryName) {
    List<String> selectedCategories = [];

    // Iterate through the categories and their subcategories
    _categories.forEach((category, subcategories) {
      if (category == categoryName) {
        subcategories.forEach((subcategory, isSelected) {
          // If the subcategory is selected, add it to the list
          if (isSelected) {
            selectedCategories.add(subcategory);
          }
        });
      }
    });

    // Format the selected categories into the desired string format
    return '$categoryName: [${selectedCategories.map((subcategory) => '"$subcategory"').join(', ')}]';
  }

  // String getSelectedSpecialities() {
  //   List<String> selectedCategories = [];
  //
  //   _categories.forEach((category, subcategories) {
  //     subcategories.forEach((subcategory, isSelected) {
  //       if (isSelected) {
  //         selectedCategories.add(subcategory);
  //       }
  //     });
  //   });
  //
  //   return 'mentalHealth: ["${selectedCategories.join(',')}"]';
  // }

  Widget buildCategory(String category, Map<String, bool> subcategories) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            category,
            style: TextStyle(
              color: Color(0xff19649E),
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        Column(
          children: subcategories.entries.map((entry) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  activeColor: Color(0xff19649E),
                  value: entry.value,
                  onChanged: (newValue) {
                    setState(() {
                      subcategories[entry.key] = newValue!;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    entry.key,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
