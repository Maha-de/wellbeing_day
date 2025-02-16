import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'doctor_instructions_3.dart';

class DoctorInstructions2 extends StatelessWidget {
  const DoctorInstructions2({super.key});

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
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("instructionDoctor2".tr(), maxLines: null,style: TextStyle(color: Colors.black, fontSize: 16,),),

              SizedBox(height: 30.h,),
              SizedBox(
                width: 100.w,
                height: 40.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 40),
                      backgroundColor: const Color(0xFF19649E),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  DoctorInstructions3()),
                    );
                  },
                  child: Center(
                    child: Text(
                      "more".tr(),
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
