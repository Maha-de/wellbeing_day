import 'dart:convert';
import 'package:doctor/cubit/get_doctor_sessions_types_cubit/doctor_session_types_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:doctor/screens/homescreen.dart'; // Import HomeScreen
import 'package:doctor/make_email/reset_password.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/doctor_details_cubit/doctor_profile_cubit.dart';
import '../cubit/forget_password_cubit/forget_password_cubit.dart';
import '../cubit/update_user_cubit/update_user_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../screens/selectionpage.dart';
import '../screens/specialist/specialist_home_screen.dart';
import '../widgets/custom_radio_button.dart';

class LoginPage extends StatefulWidget {

  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController roleController = TextEditingController();

  bool _isObscure1 = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess && roleController.text=="beneficiary") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) => UserProfileCubit(),
                  child: const HomeScreen(),
                ),
              ),
            );
          } else if(state is LoginSuccess && roleController.text=="specialized")
          {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<DoctorProfileCubit>(create: (_) => DoctorProfileCubit()),
                    BlocProvider<DoctorSessionTypesCubit>(create: (_) => DoctorSessionTypesCubit()),
                    BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                  ],
                  child: const SpecialistHomeScreen(),
                ),
              ),
            );
          }else if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     SizedBox(height: 50.h),
                    Text(
                      "welcomeBack".tr(),
                      style:  TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     SizedBox(height: 20.h),
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/img.png',
                            height: 150.h,
                          ),
                           Text(
                            'Wellbeing Day',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                           Text(
                            'THERAPY. RELAX. MAGAZINE',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                     SizedBox(height: 30.h),
                    buildTextField(
                      isPassword: false,
                      context,
                      label: "email".tr(),
                      icon: Icon(Icons.email_outlined),
                      controller: emailController,
                    ),
                     SizedBox(height: 16.h),
                    buildTextField(
                      context,
                      label: "password".tr(),
                      icon:  IconButton(
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
                      controller: passwordController,
                    ),
                    SizedBox(height: 8.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (_) => ForgetPasswordCubit(),
                                child: ResetPassword(),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "forgetPassword".tr(),
                          style: const TextStyle(color: Color(0xff19649E)),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomRadioButtonWidget(
                      title: "role".tr(),
                      fRad: "beneficiary".tr(),
                      sRad: "specialized".tr(),
                      onRoleSelected: (role) {
                        if (role == "مستفيد") {
                          role = "beneficiary";
                        } else {
                          role = "specialized";
                        }
                        roleController.text = role;
                      },
                    ),

                    // buildTextField(
                    //   context,
                    //   label: "role".tr(),
                    //   icon: Icons.person,
                    //   controller: roleController,
                    // ),
                     SizedBox(height: 30.h),
                    ElevatedButton(
                      onPressed: () {
                        final email = emailController.text;
                        final password = passwordController.text;
                        final role = roleController.text.trim();
                        context.read<LoginCubit>().login(email, password, role);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff19649E),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "signIn".tr(),
                        style:  TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                     SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(
                          "notHaveAccount".tr(),
                          style:  TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const SelectionPage()));
                          },
                          child:
                          Text(
                            "createAccount".tr(),
                            style:  TextStyle(
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
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildTextField(BuildContext context,
      {required String label,
        required Widget icon,
        required bool isPassword ,
        required TextEditingController controller}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      // textAlign: TextAlign.right,
    );
  }
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void login(String email, String password, String role) async {
    try {
      emit(LoginLoading());

      final url = 'https://scopey.onrender.com/api/auth/login';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
          'role': role,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
       if(role=="beneficiary")
       {
         var userId = data['user']['id'];
         final prefs = await SharedPreferences.getInstance();
         prefs.setString('userId', userId);
       }else
       {
         var userId =data['user']['id'];
         final prefs = await SharedPreferences.getInstance();
         prefs.setString('doctorId', userId);
       }

        emit(LoginSuccess(message: 'تم تسجيل الدخول بنجاح'));
      } else {
        emit(LoginError(
            error: 'البريد الإلكتروني أو كلمة المرور أو الدور غير صحيح.'));
      }
    } catch (e) {
      print(e);
      emit(LoginError(error: 'حدث خطأ أثناء تسجيل الدخول.'));
    }
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String message;

  LoginSuccess({required this.message});
}

class LoginError extends LoginState {
  final String error;

  LoginError({required this.error});
}