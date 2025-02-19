import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/reset_password_cubit/reset_password_cubit.dart';

class NewPasswordPage extends StatefulWidget {
  final String email;
  const NewPasswordPage({super.key, required this.email});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  @override
  Widget build(BuildContext context) {
    bool _isObscure1 = true;
    bool _isObscure2 = true;
    final formKey = GlobalKey<FormState>();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
    TextEditingController();
    return BlocProvider(
        create: (_) => ResetPasswordCubit(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     SizedBox(height: 50.h),
                    Image.asset(
                      'assets/images/newpassword.png',
                      height: 330.h,
                      width: 550.w,
                      fit: BoxFit
                          .contain, // Ensures the image scales properly within the bounds
                    ),
                     SizedBox(height: 20.h),
                    Text(
                      "newPassword".tr(),
                      style:  TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF19649E),
                      ),
                    ),
                     SizedBox(height: 30.h),
                    buildTextField(
                      validation: (String? value) {
                        value = passwordController.text;
                        if (value == null || value.length < 8) {
                          return "passwordLength".tr();
                        }
                        return null;
                      },
                      controller: passwordController,
                      label: "newPassword".tr(),
                      icon: IconButton(
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
                      isPassword: _isObscure1,
                    ),
                     SizedBox(height: 20.h),
                    buildTextField(
                      validation: (String? value) {
                        value = passwordController.text;
                        if (value != confirmPasswordController.text) {
                          return "matchPassword".tr();
                        }
                        return null;
                      },
                      label: "confirmPassword".tr(),
                      icon: IconButton(
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
                      isPassword: _isObscure2,
                      controller: confirmPasswordController,
                    ),
                    SizedBox(height: 30.h),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<ResetPasswordCubit>(context)
                              .resetPasswordByEmail(context, widget.email,
                              passwordController.text,"home");
                          passwordController.clear();
                          confirmPasswordController.clear();
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF19649E),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "confirm".tr(),
                        style:  TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold, color: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget buildTextField({
    required String label,
    required Widget icon,
    required TextEditingController controller,
    required bool isPassword,
    required FormFieldValidator<String> validation,
  }) {
    return TextFormField(
      validator: validation,
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      textAlign: TextAlign.right,
    );
  }
}
