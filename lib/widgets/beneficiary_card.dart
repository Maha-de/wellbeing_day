import 'package:doctor/screens/specialist/specialist_free_consultation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeneficiaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width * 0.9,
        height: 150,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color(0xff19649E),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          clipBehavior: Clip.none, // يسمح بخروج الصورة خارج الحدود
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'ميرفت مندور',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 38),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoBox('تفاصيل الجلسه',(){Get.to(()=>SpecialistFreeConsultationScreen());}),
                    _buildInfoBox('تفاصيل المستفيد',(){}),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: -55,
              child:Container(
                width: 118,
                height: 118,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // يجعل الكونتينر دائريًا
                  border: Border.all(color: Colors.transparent, width: 2),
                  // إطار أبيض حول الدائرة
                  image: DecorationImage(
                    image: AssetImage("assets/images/family.png"), // تأكد من المسار الصحيح
                    fit: BoxFit.fill, // يجعل الصورة تملأ الدائرة بشكل مناسب
                  ),
                ),
              ),

            ),

          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox(String text,Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 131,
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.blue[800],fontSize: 16,fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}