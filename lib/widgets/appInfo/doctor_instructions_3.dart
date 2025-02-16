import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DoctorInstructions3 extends StatelessWidget {
  const DoctorInstructions3({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("instructionDoctor3title1".tr(), style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 0.5.h,),
              Text("instructionDoctor3".tr(), maxLines: null,style: TextStyle(color: Colors.black, fontSize: 16, ),),
              SizedBox(height: 20.h,),
              Text("instructionDoctor3title2".tr(), style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 0.5.h,),
              Text("instructionDoctor33".tr(), maxLines: null,style: TextStyle(color: Colors.black, fontSize: 16, ),),

            ],
          ),
        ),
      ),
    );
  }
}
