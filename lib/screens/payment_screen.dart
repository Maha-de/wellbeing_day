import 'package:doctor/screens/payment_methods_profile.dart';
import 'package:flutter/material.dart';

import 'add_credit_card_screen.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading:IconButton(onPressed: (){Navigator.pop(context);}, icon: const Image(image: AssetImage("assets/images/back.png"),fit: BoxFit.fill,width: 20,height: 14,))
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight*0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Container(
                      width: 161,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1F78BC),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "الدفع",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: screenWidth * 0.8,
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xffAFDCFF), width: 2),
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
                                  Image.asset("assets/images/session.png", width: 20, height: 20),
                                  const SizedBox(width: 5,),
                                  const Text(
                                    "جلسه واحده",
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xff000000)),
                                  ),


                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset("assets/images/solar_hand-heart-bold.png", width: 20, height: 20),
                                  const SizedBox(width: 5,),
                                  const Text(
                                    "إستشاره",
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xff000000)),
                                  ),


                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/images/clock.png", width: 20, height: 20),
                                  const SizedBox(width: 5,),
                                  const Text(
                                    "30 دقيقه",
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xff000000)),
                                  ),


                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset("assets/images/doctorr.png", width: 20, height: 20),
                                  const SizedBox(width: 5,),
                                  const Text(
                                    "معالج",
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xff000000)),
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
              height: screenHeight*0.15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text(
                      "تفاصيل الفاتوره",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Color(0xff1F78BC)),
                    ),
                  ),
                  Center(
                    child: Container(

                      width: screenWidth * 0.9,
                      height: 44,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xffAFDCFF), width: 2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: SizedBox(
                          width:screenWidth*0.6,
                          height: 44,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "التكلفه",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color(0xff000000)),
                              ),
                              Text(
                                " \$ 99",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color(0xff000000)),
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
              height: screenHeight*0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: screenWidth*0.3,
                    child: const Center(
                      child: Text(
                        "طريقه الدفع",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w100, color: Color(0xff1F78BC)),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 343,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xff1F78BC)
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 10),
                            width: 307,
                            child: Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                const Image(image: AssetImage("assets/images/neo.png"),width: 70.29,height: 30,fit: BoxFit.fill,),
                                IconButton(onPressed: (){}, icon: const Image(image: AssetImage("assets/images/left_arrow.png"),width: 12,height: 22,))
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 295,
                              height: 1,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 10),
                            width: 307,
                            child: Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                const Image(image: AssetImage("assets/images/visa.png"),width: 70.29,height: 20,fit: BoxFit.fill,),
                                IconButton(
                                    onPressed: (){

                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddCreditCardScreen()));

                                    },
                                    icon: const Image(image: AssetImage("assets/images/left_arrow.png"),width: 12,height: 22,))
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 295,
                              height: 1,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 10),
                            width: 307,
                            child: Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                const Image(image: AssetImage("assets/images/logos_mastercard.png"),width: 70.29,height: 30,fit: BoxFit.fill,),
                                IconButton(onPressed: (){}, icon: const Image(image: AssetImage("assets/images/left_arrow.png"),width: 12,height: 22,))
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
            Center(
              child: SizedBox(
                height: screenHeight*0.13,
                child: const Center(
                  child: Text("يمكن الدفع أيضا من خلال الاتي\n والتواصل مباشرة بإدارة التطبيق",textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff1F78BC),
                    fontSize: 20,
                    fontWeight: FontWeight.w600

                  ),),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 324,
                height: 62,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xff1F78BC),width: 1.5)
                ),
                child:const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image(image: AssetImage("assets/images/omt.png"),fit: BoxFit.fill,height: 53,width: 82,),
                    Image(image: AssetImage("assets/images/whishMoney.png"),fit: BoxFit.fill,height: 53,width: 82,),
                    Image(image: AssetImage("assets/images/w.png"),fit: BoxFit.fill,height: 53,width: 82,),
                    Image(image: AssetImage("assets/images/logos_paypal.png"),fit: BoxFit.fill,height: 39,width: 40,)
                  ],
                ) ,
              ),
            )
          ],
        ),
      ),
    );
  }
}
