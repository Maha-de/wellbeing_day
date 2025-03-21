import 'dart:developer';

import 'package:doctor/screens/homescreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor/widgets/custom_text_field_for_sign_up.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:doctor/make_email/login.dart'; // هنا تم إضافة السطر

import '../cubit/doctor_details_cubit/doctor_profile_cubit.dart';
import '../cubit/get_all_ads/get_all_ads_cubit.dart';
import '../cubit/get_sub_categories_cubit/get_sub_categories_cubit.dart';
import '../cubit/update_user_cubit/update_user_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../make_email/login.dart';

// صفحة تسجيل المستخدم
class SignUpAsClient extends StatefulWidget {
  SignUpAsClient({super.key});

  @override
  State<SignUpAsClient> createState() => _SignUpAsClientState();
}

class _SignUpAsClientState extends State<SignUpAsClient> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController nationalityController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController regionController = TextEditingController();

  final TextEditingController professionController = TextEditingController();

  // متغير لتحديد الجنس
  String? selectedGender;

  bool obSecureText = true;

  // حفظ اسم المستخدم في SharedPreferences
  Future<void> _saveUserName(String firstName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', firstName);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: BlocConsumer<SignUpCubit, SignupState>(
                listener: (context, state) {
                  if (state is SignupSuccess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider<UserProfileCubit>(
                                create: (_) => UserProfileCubit()),
                            BlocProvider<SubCategoriesCubit>(
                                create: (_) => SubCategoriesCubit()),
                            BlocProvider<UpdateUserCubit>(
                                create: (_) => UpdateUserCubit()),
                            BlocProvider<DoctorProfileCubit>(
                                create: (_) => DoctorProfileCubit()),
                            BlocProvider<GetAllAdsCubit>(
                                create: (_) => GetAllAdsCubit()),
                          ],
                          child: const HomeScreen(),
                        ),
                      ),
                    );
                  } else if (state is SignupError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                builder: (context, state) {
                  final cubit = context.read<SignUpCubit>();

                  return Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text(
                            "discoverSpecialist".tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        CustomTextField(
                          label: "firstName".tr(),
                          suffixIcon: Icons.person,
                          controller: firstNameController,
                          validator: (value) =>
                              value!.isEmpty ? "firstNameValidator".tr() : null,
                        ),
                        CustomTextField(
                          label: "lastName".tr(),
                          suffixIcon: Icons.family_restroom,
                          controller: lastNameController,
                          validator: (value) =>
                              value!.isEmpty ? "lastNameValidator".tr() : null,
                        ),
                        CustomTextField(
                          label: "email".tr(),
                          suffixIcon: Icons.email,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              value!.isEmpty ? "emailValidator".tr() : null,
                        ),
                        CustomTextField(
                          label: "password".tr(),
                          // suffixIcon: Icons.remove_red_eye_outlined,
                          controller: passwordController,
                          // obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "passwordValidator".tr();
                            } else if (value.length < 8) {
                              return "passwordLength".tr();
                            }
                            return null;
                          },

                          suffixIcon: obSecureText
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                          obscureText: obSecureText,
                          onSuffixIconTap: () {
                            setState(() {
                              obSecureText =
                                  !obSecureText; // Toggle the obscure state
                            });
                          },
                        ),
                        CustomTextField(
                          label: "phoneNumber".tr(),
                          suffixIcon: Icons.phone_android,
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) => value!.isEmpty
                              ? "phoneNumberValidator".tr()
                              : null,
                        ),
                        CustomTextField(
                          label: "age".tr(),
                          suffixIcon: Icons.cake,
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            final age = int.tryParse(value!);
                            return (age == null || age <= 18)
                                ? "ageValidator".tr()
                                : null;
                          },
                        ),
                        Text("gender".tr(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Color(0xff19649E),
                              fontWeight: FontWeight.w500,
                            )),
                        SizedBox(height: 5.h),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: "gender".tr(),
                            border: const OutlineInputBorder(),
                          ),
                          value: selectedGender,
                          items: ['male', 'female']
                              .map((gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            selectedGender = value!;
                          },
                          // validator: (value) =>
                          //     value == null ? "genderValidator".tr() : null,
                        ),
                        SizedBox(height: 10.h),
                        CustomTextField(
                          label: "nationality".tr(),
                          suffixIcon: Icons.flag,
                          controller: nationalityController,
                          // validator: (value) =>
                          // value!.isEmpty ? "nationalityValidator".tr() : null,
                        ),
                        CustomTextField(
                          label: "homeAddress".tr(),
                          suffixIcon: Icons.home,
                          controller: addressController,
                          // validator: (value) =>
                          //     value!.isEmpty ? "homeAddressValidator".tr() : null,
                        ),
                        CustomTextField(
                          label: "region".tr(),
                          suffixIcon: Icons.location_on,
                          controller: regionController,
                          validator: (value) =>
                              value!.isEmpty ? "regionValidator".tr() : null,
                        ),
                        CustomTextField(
                          label: "profession".tr(),
                          suffixIcon: Icons.work,
                          controller: professionController,
                          validator: (value) => value!.isEmpty
                              ? "professionValidator".tr()
                              : null,
                        ),
                        SizedBox(height: 24.h),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.registerUser(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                                profession: professionController.text,
                                homeAddress: addressController.text.isEmpty
                                    ? " "
                                    : addressController.text,
                                age: int.tryParse(ageController.text) ?? 0,
                                region: regionController.text,
                                nationality: nationalityController.text.isEmpty
                                    ? " "
                                    : nationalityController.text,
                                gender: selectedGender ?? "male",
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff19649E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(31),
                            ),
                          ),
                          child: state is SignupLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : Text(
                                  "createAccount".tr(),
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "alreadyHaveAnAccount".tr(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              },
                              child: Text(
                                "signIn".tr(),
                                style: const TextStyle(
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
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// الكلاس الخاص بـ Cubit لتسجيل المستخدم
class SignUpCubit extends Cubit<SignupState> {
  final BuildContext context;

  SignUpCubit(this.context) : super(SignupInitial());

  Future<void> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String profession,
    required String homeAddress,
    required int age,
    required String region,
    required String nationality,
    required String gender,
  }) async {
    emit(SignupLoading());
    final String url =
        "https://wellbeingproject.onrender.com/api/beneficiaries/register/beneficiary";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password,
          "phone": phone,
          "profession": profession,
          "homeAddress": homeAddress,
          "age": age,
          "region": region,
          "nationality": nationality,
          "gender": gender,
        }),
      );

      if (response.statusCode == 201) {
        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");

        final data = json.decode(response.body);
        var userId = data['newBeneficiary']['_id'];
        var token = data['token'];
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('userId', userId); // Store userId
        prefs.setString('email', email);
        prefs.setString('token', token);
        log('token is $token');
        emit(SignupSuccess(message: 'تم تسجيل الدخول بنجاح'));
      } else {
        print("Response status: ${response.statusCode} + ${response.body}");
        emit(SignupError(
            error: 'البريد الإلكتروني أو كلمة المرور أو الدور غير صحيح.'));
      }
    } catch (e) {
      emit(SignupError(error: 'حدث خطأ أثناء تسجيل الدخول.'));
    }
  }
}

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final String message;

  SignupSuccess({required this.message});
}

class SignupError extends SignupState {
  final String error;

  SignupError({required this.error});
}
