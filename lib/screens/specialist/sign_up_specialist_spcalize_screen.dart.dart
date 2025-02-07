
import 'package:doctor/screens/homescreen.dart';
import 'package:doctor/screens/specialist/choose_specialty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/doctor_sign_up_cubit/doctor_sign_up_cubit.dart';
import '../../cubit/doctor_sign_up_cubit/doctor_sign_up_state.dart';
import '../../models/Specialist.dart';
import '../../widgets/custom_snake_bar.dart';

class SignUpAsDoctorThirdScreen extends StatefulWidget {
  final Doctor doctor;

  const SignUpAsDoctorThirdScreen({Key? key, required this.doctor})
      : super(key: key);

  @override
  State<SignUpAsDoctorThirdScreen> createState() =>
      _SignUpAsDoctorThirdScreenState();
}

class _SignUpAsDoctorThirdScreenState extends State<SignUpAsDoctorThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<SignUpSpecialistCubit, SignUpSpecialistState>(
          listener: (context, state) {
            if (state is SignUpSpecialistFailure) {
              showErrorSnackBar(context, state.errMessage);
            } else if (state is SignUpSpecialistSuccess) {
              navigateToHomeScreen(context);
            }
          },
          child: BlocBuilder<SignUpSpecialistCubit, SignUpSpecialistState>(
            builder: (context, state) {
              if (state is SignUpSpecialistLoading) {
                return loadingState(state);
              }
              return ChooseSpecialty(
                doctor: widget.doctor,
              );
            },
          ),
        ),
      ),
    );
  }

  void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      customSnackBar(
        context: context,
        message: message,
        backgroundColor: Colors.red,
        icon: Icons.error,
      ),
    );
  }

  void navigateToHomeScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  Widget loadingState(SignUpSpecialistLoading state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/loading.gif'),
          const SizedBox(height: 20),
          Text(state.message),
        ],
      ),
    );
  }
}
