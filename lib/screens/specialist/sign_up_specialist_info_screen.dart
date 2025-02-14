import 'dart:developer';

import 'package:doctor/core/validators.dart';
import 'package:doctor/cubit/doctor_sign_up_cubit/doctor_sign_up_cubit.dart';
import 'package:doctor/models/Specialist.dart';
import 'package:doctor/screens/specialist/sign_up_specialist_spcalize_screen.dart';
import 'package:doctor/widgets/custom_snake_bar.dart';
import 'package:doctor/widgets/custom_text_field_for_sign_up.dart';
import 'package:doctor/widgets/custom_upload_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpAsDoctorFirstScreen extends StatefulWidget {
  const SignUpAsDoctorFirstScreen({super.key});

  @override
  _SignUpAsDoctorFirstScreenState createState() =>
      _SignUpAsDoctorFirstScreenState();
}

class _SignUpAsDoctorFirstScreenState extends State<SignUpAsDoctorFirstScreen> {
  bool isSubmitted = false;

  GlobalKey<FormState> signUpFormKey = GlobalKey();
  late PlatformFile cvFile;
  late PlatformFile idOrPassport;
  late PlatformFile certificates;
  late PlatformFile ministryLicense;
  late PlatformFile associationMembership;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController homeAddressController = TextEditingController();
  TextEditingController workAddressController = TextEditingController();
  TextEditingController workController = TextEditingController();
  TextEditingController about_doctor_Controller = TextEditingController();
  TextEditingController exp_year_Controller = TextEditingController();
  TextEditingController session_time_Controller = TextEditingController();
  TextEditingController session_price_Controller = TextEditingController();

  final TextEditingController resumeController = TextEditingController();
  final TextEditingController idOrPassportController = TextEditingController();
  final TextEditingController certificatesController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController associationMembershipController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpSpecialistCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: signUpFormKey,
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      "انضم إلى فريقنا من الخبراء وابدأ في تقديم استشارات المرضى بكل خصوصية",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    label: "الاسم الاول",
                    controller: firstNameController,
                    validator: (value) =>
                        isSubmitted ? validateName(value, "الاسم الاول") : null,
                  ),
                  CustomTextField(
                    label: "اسم العائله",
                    controller: lastNameController,
                    validator: (value) =>
                        isSubmitted ? validateName(value, "اسم العائله") : null,
                  ),
                  CustomTextField(
                    label: "البريد الإلكتروني",
                    controller: emailController,
                    validator: (value) => isSubmitted
                        ? validateEmail(value, "البريد الإلكتروني")
                        : null,
                    suffixIcon: Icons.mail,
                  ),
                  CustomTextField(
                    label: "كلمة المرور",
                    controller: passwordController,
                    validator: (value) => isSubmitted
                        ? validatePassword(value, "كلمة المرور")
                        : null,
                    suffixIcon: Icons.remove_red_eye,
                  ),
                  CustomTextField(
                    label: "تأكيد كلمة المرور",
                    controller: confirmPasswordController,
                    validator: isSubmitted
                        ? (value) => validateConfirmPassword(
                            value, passwordController.text)
                        : null,
                    suffixIcon: Icons.remove_red_eye,
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    label: "رقم الهاتف",
                    controller: phoneController,
                    validator: (value) =>
                        isSubmitted ? validatePhone(value, "رقم الهاتف") : null,
                    suffixIcon: Icons.phone_android,
                  ),
                  CustomTextField(
                    label: "الجنسية",
                    controller: nationalityController,
                    validator: (value) => isSubmitted
                        ? validateNationality(value, "الجنسية")
                        : null,
                    suffixIcon: Icons.person,
                  ),
                  CustomTextField(
                    label: "عنوان السكن",
                    controller: homeAddressController,
                    validator: (value) => isSubmitted
                        ? validateAddress(value, "عنوان السكن")
                        : null,
                    suffixIcon: Icons.location_city,
                  ),
                  CustomTextField(
                    label: "العمل",
                    controller: workController,
                    validator: (value) =>
                        isSubmitted ? validateName(value, "العمل") : null,
                    suffixIcon: Icons.work,
                  ),
                  CustomTextField(
                    label: "عنوان العمل",
                    controller: workAddressController,
                    validator: (value) => isSubmitted
                        ? validateAddress(value, "عنوان العمل")
                        : null,
                    suffixIcon: Icons.location_city,
                  ),
                  CustomTextField(
                    label: "عن الأخصائي",
                    isMultiline: true,
                    controller: about_doctor_Controller,
                    validator: (value) =>
                        isSubmitted ? validateName(value, "عن الأخصائي") : null,
                    suffixIcon: Icons.work_history,
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    label: "سنين الخبرة",
                    controller: exp_year_Controller,
                    validator: (value) => isSubmitted
                        ? validateYearsOfExperience(value, "سنين الخبرة")
                        : null,
                    suffixIcon: Icons.work_history,
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    label: "مدة الجلسة",
                    controller: session_time_Controller,
                    validator: (value) => isSubmitted
                        ? validateYearsOfExperience(value, "مدة الجلسة")
                        : null,
                    suffixIcon: Icons.timer,
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    label: "سعر الجلسة",
                    controller: session_price_Controller,
                    validator: (value) => isSubmitted
                        ? validateYearsOfExperience(value, "سعر الجلسة")
                        : null,
                    suffixIcon: Icons.price_check_sharp,
                  ),
                  CustomUploadFile(
                    label: "السيرة الذاتية",
                    controller: resumeController,
                    validator: (value) =>
                        validateUpload(value, "السيرة الذاتية"),
                    onFilePicked: (PlatformFile? file) {
                      if (file != null) {
                        cvFile = file;
                        // Handle the picked file (e.g., upload it to the server).
                        print("Picked file: ${file.name}");
                        print("File size: ${file.size} bytes");
                      } else {
                        print("File picking canceled.");
                      }
                    },
                  ),
                  CustomUploadFile(
                    label: "صورة الهوية /الباسورد",
                    controller: idOrPassportController,
                    validator: (value) =>
                        validateUpload(value, "صورة الهوية /الباسورد"),
                    onFilePicked: (PlatformFile? file) {
                      if (file != null) {
                        idOrPassport = file;
                      } else {
                        print("File picking canceled.");
                      }
                    },
                  ),
                  CustomUploadFile(
                    label: "الشهادات",
                    controller: certificatesController,
                    validator: (value) => validateUpload(value, "الشهادات"),
                    onFilePicked: (PlatformFile? file) {
                      if (file != null) {
                        certificates = file;
                      } else {
                        print("File picking canceled.");
                      }
                    },
                  ),
                  CustomUploadFile(
                    label: "ترخيص أو إذن مزاولة المهنة",
                    validator: (value) =>
                        validateUpload(value, "ترخيص أو إذن مزاولة المهنة"),
                    controller: licenseController,
                    onFilePicked: (PlatformFile? file) {
                      if (file != null) {
                        ministryLicense = file;
                      } else {
                        print("File picking canceled.");
                      }
                    },
                  ),
                  CustomUploadFile(
                    label: "عضوية النقابه أو الجمعيه",
                    validator: (value) =>
                        validateUpload(value, "عضوية النقابه أو الجمعيه"),
                    controller: associationMembershipController,
                    onFilePicked: (PlatformFile? file) {
                      if (file != null) {
                        associationMembership = file;
                      } else {
                        print("File picking canceled.");
                      }
                    },
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSubmitted =
                            true; // Set to true when submit button is clicked
                      });

                      if (signUpFormKey.currentState!.validate()) {
                        log("goooooooooooooooo");
                        Specialist doctor = Specialist.withoutSpeciality(
                          phone: phoneController.text,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          nationality: nationalityController.text,
                          work: workController.text,
                          workAddress: workAddressController.text,
                          homeAddress: homeAddressController.text,
                          bio: about_doctor_Controller.text,
                          yearOfExperience:
                              int.tryParse(exp_year_Controller.text)!,
                          sessionPrice: session_price_Controller.text,
                          sessionDuration: session_time_Controller.text,
                          idOrPassport: idOrPassport,
                          resume: cvFile,
                          certificates: certificates,
                          ministryLicense: ministryLicense,
                          associationMembership: associationMembership,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpAsDoctorThirdScreen(
                              doctor: doctor,
                            ),
                          ),
                        );
                      } else {
                        print("");
                        ScaffoldMessenger.of(context).showSnackBar(
                          customSnackBar(
                            context: context,
                            message: "الرجاء تعبئة الحقول المطلوبة",
                            backgroundColor: Colors.red,
                            icon: Icons.error,
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 140,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff19649E),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          'التالي',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
