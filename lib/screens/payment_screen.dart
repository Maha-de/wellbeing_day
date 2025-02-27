import 'package:doctor/core/strings.dart';
import 'package:doctor/screens/payment_methods_profile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'add_credit_card_screen.dart';

class PaymentScreen extends StatelessWidget {
  final DateTime confirmedUserDateTimel;
  const PaymentScreen({super.key, required this.confirmedUserDateTimel});

  void openWhatsApp(String paymentWay) async {
    String message = Uri.encodeComponent("anotherPayWays".tr() + paymentWay);
    String whatsappUrl = "https://wa.me/${contactNumber}?text=$message";

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl),
          mode: LaunchMode.externalApplication);
    } else {
      Fluttertoast.showToast(
        msg: "Could not open WhatsApp.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(confirmedUserDateTimel);
    final double screenWidth = MediaQuery.of(context).size.width.w;
    final double screenHeight = MediaQuery.of(context).size.height.h;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color(0xff19649E),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.2.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Container(
                      width: 161.w,
                      height: 40.h,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1F78BC),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "payment".tr(),
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: screenWidth * 0.8,
                      height: 80.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color(0xffAFDCFF), width: 2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/images/session.png",
                                      width: 20.w, height: 20.h),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "oneSession".tr(),
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff000000)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                      "assets/images/solar_hand-heart-bold.png",
                                      width: 20.w,
                                      height: 20.h),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "consultant".tr(),
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff000000)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/images/clock.png",
                                      width: 20, height: 20),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "minutesInPayment".tr(),
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff000000)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset("assets/images/doctorr.png",
                                      width: 20.w, height: 20.h),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "therapist".tr(),
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff000000)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.15.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15.0, left: 15),
                    child: Text(
                      "invoiceDetails".tr(),
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.normal,
                          color: Color(0xff1F78BC)),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: screenWidth * 0.9,
                      height: 44.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color(0xffAFDCFF), width: 2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: SizedBox(
                          width: screenWidth * 0.6.w,
                          height: 44.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "cost".tr(),
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff000000)),
                              ),
                              Text(
                                " \$ 99",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff000000)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 343.w,
              child: Padding(
                padding: EdgeInsets.only(right: 15.0, left: 15, bottom: 10),
                child: Text(
                  "paymentWay".tr(),
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff1F78BC)),
                ),
              ),
            ),
            Center(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: Container(
                        width: 343.w,
                        height: 152.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xff1F78BC)),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(right: 10),
                              width: 307,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image(
                                    image: AssetImage("assets/images/neo.png"),
                                    width: 70.29.w,
                                    height: 30.h,
                                    fit: BoxFit.fill,
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Container(
                                        width: 7.58,
                                        height: 17,
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Center(
                              child: Container(
                                width: 295.w,
                                height: 1.h,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(right: 15),
                              width: 295.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image(
                                    image: AssetImage("assets/images/visa.png"),
                                    width: 85.w,
                                    height: 35.h,
                                    fit: BoxFit.fill,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AddCreditCardScreen()));
                                      },
                                      icon: Container(
                                        width: 7.58,
                                        height: 17,
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 20.w,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Center(
                              child: Container(
                                width: 295.w,
                                height: 1.h,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(right: 10),
                              width: 307,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        "assets/images/logos_mastercard.png"),
                                    width: 62.w,
                                    height: 36.h,
                                    fit: BoxFit.fill,
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Container(
                                        width: 7.58,
                                        height: 17,
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 20.w,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: screenHeight * 0.13.h,
                child: Center(
                  child: Expanded(
                    child: Text(
                      "payAlso".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff1F78BC),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 324.w,
                height: 62.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color(0xff1F78BC), width: 1.5.h)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () => openWhatsApp("OMT"),
                      child: Image(
                        image: AssetImage("assets/images/omt.png"),
                        fit: BoxFit.fill,
                        height: 53.h,
                        width: 82.w,
                      ),
                    ),
                    InkWell(
                      onTap: () => openWhatsApp("Whish Money"),
                      child: Image(
                        image: AssetImage("assets/images/whishMoney.png"),
                        fit: BoxFit.fill,
                        height: 53.h,
                        width: 82.w,
                      ),
                    ),
                    InkWell(
                      onTap: () => openWhatsApp("Western Union"),
                      child: Image(
                        image: AssetImage("assets/images/w.png"),
                        fit: BoxFit.fill,
                        height: 53.h,
                        width: 82.w,
                      ),
                    ),
                    InkWell(
                      onTap: () => openWhatsApp("PayPal"),
                      child: Image(
                        image: AssetImage("assets/images/logos_paypal.png"),
                        fit: BoxFit.fill,
                        height: 39.h,
                        width: 40.w,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 35.h),
          ],
        ),
      ),
    );
  }
}
