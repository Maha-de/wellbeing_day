import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: screenHeight*0.7,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image(image: const AssetImage("assets/images/success.png"),
                    height: screenHeight*0.25,),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    height: screenHeight*0.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("تهانينا",style: TextStyle(
                          color: Color(0xff19649E),
                          fontWeight: FontWeight.bold,
                          fontSize: 32
                        ),),
                        const Text("تم الحجز بنجاح",style: TextStyle(
                            color: Color(0xff19649E),
                            fontWeight: FontWeight.w800,
                            fontSize: 24
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
              width: screenWidth * 0.9,
              height: screenHeight * 0.06,
              decoration: BoxDecoration(
                color: Color(0xff19649E),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "عوده",
                  style: TextStyle(
                    fontSize: 24,
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
