import 'package:doctor/screens/sign_up_as_client.dart';
import 'package:doctor/screens/specialist/sign_up_specialist_info_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorInstructions extends StatefulWidget {
  const DoctorInstructions({super.key});

  @override
  State<DoctorInstructions> createState() => _DoctorInstructionsState();
}

class _DoctorInstructionsState extends State<DoctorInstructions> {

  bool approval = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color(0xff19649E),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("doctorInstructions".tr(), style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 0.5.h,),
              Text("doctorInstructionsPoints".tr(), maxLines: null,style: TextStyle(color: Colors.black, fontSize: 16, ),),
              CheckboxListTile(
                checkColor: Colors.white,
                activeColor: Color(0xff19649E),
                side: BorderSide(color: Color(0xff19649E), width: 2), // Change checkbox border color
                title: Text("checkboxApproval1".tr(), textAlign: TextAlign.start, ), // RTL support
                value: approval,

                onChanged: (bool? value) {
                  setState(() {
                    approval = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              Container(
                width: 100.w,
                height: 40.h,
                child: ElevatedButton(

                  onPressed: approval ? () {
                    // Perform the action
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpAsDoctorFirstScreen()),
                    );
                  } : null, // Disable the button if not checked

                  style: ElevatedButton.styleFrom(
                    // minimumSize: const Size(100, 40),
                      backgroundColor: const Color(0xFF19649E),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Center(
                    child: Text(
                      "start".tr(),
                      style:  TextStyle(
                        color: Colors.white,
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}