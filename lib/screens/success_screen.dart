import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width.w;
    final double screenHeight = MediaQuery.of(context).size.height.h;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: screenHeight*0.7.h,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image(image: const AssetImage("assets/images/success.png"),
                    height: screenHeight*0.25.h,),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 15),
                    height: screenHeight*0.15.h,
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("تهانينا",style: TextStyle(
                          color: Color(0xff19649E),
                          fontWeight: FontWeight.bold,
                          fontSize: 32.sp
                        ),),
                        Text("تم الحجز بنجاح",style: TextStyle(
                            color: Color(0xff19649E),
                            fontWeight: FontWeight.w800,
                            fontSize: 24.sp
                        ),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){},
            child: Container(
              width: screenWidth * 0.9.w,
              height: screenHeight * 0.06.h,
              decoration: BoxDecoration(
                color: const Color(0xff19649E),
                borderRadius: BorderRadius.circular(10),
              ),
              child:  Center(
                child: Text(
                  "عوده",
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
