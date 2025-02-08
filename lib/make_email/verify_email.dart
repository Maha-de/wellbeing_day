import 'package:doctor/make_email/new_password.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../cubit/verify_code_cubit/verify_code_cubit.dart';


class VerifyScreenEmail extends StatefulWidget {
  final String email;
  const VerifyScreenEmail({super.key,required this.email});

  @override
  State<VerifyScreenEmail> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreenEmail> {
  final TextEditingController codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => VerifyCodeCubit(),
    child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 5),
            child: ListView(children: [
              Image.asset("assets/images/verify.png"),
              Text(
                "verifyCode".tr(),
                style:  TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF19649E)),
                textAlign: TextAlign.center,
              ),
               SizedBox(
                height: 20.h,
              ),
              Text(
                "pleaseEnterCodeSentToYourEmail".tr(),
                style:  TextStyle(fontSize: 20.sp, color: Colors.black),
              ),
               SizedBox(height: 50.h,),

              PinCodeTextField(
                appContext: context,
                length: 6,
                obscureText: false,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  activeFillColor: Colors.white,
                ),
                onChanged: (value) {},
                onCompleted: (value) {
                  codeController.text = value;
                },
              ),



               SizedBox(
                height: 50.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("notReceivedCode".tr(),
                      style:  TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold
                      )),
                  TextButton(
                      onPressed: () {

                      },
                      child: Text("resendCode".tr(),
                          style: TextStyle(color: Color(0xFF19649E), fontWeight: FontWeight.bold, fontSize: 18.sp))),

                ],
              ),
               SizedBox(height: 20.h,),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff19649E),
                      shape: RoundedRectangleBorder(
                          borderRadius:

                          BorderRadius.circular(10))),
                  onPressed: (){
                    final code = int.tryParse(codeController.text);
                    print(codeController.text);
                    BlocProvider.of<VerifyCodeCubit>(context)
                        .verifyCodeByEmail(context,widget.email,code??0);
                  }, 
                  child: Text("verify".tr(), style:  TextStyle(
                  fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.bold),)),

            ]))

    ));
  }
}
