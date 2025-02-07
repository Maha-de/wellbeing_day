import 'package:doctor/screens/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCreditCardScreen extends StatefulWidget {
  const AddCreditCardScreen({super.key});

  @override
  State<AddCreditCardScreen> createState() => _AddCreditCardScreenState();
}

class _AddCreditCardScreenState extends State<AddCreditCardScreen> {
  List<Widget> cards = [];

  @override
  void initState() {
    super.initState();
    // Adding one card initially
    cards.add(buildCard());
  }

  Widget buildCard() {
    return Container(
      width: 244,
      height: 163,
      margin: const EdgeInsets.only(left: 10), // Space between cards
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage("assets/images/creditcard.png"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  void addCard() {
    setState(() {
      cards.insert(0, buildCard()); // Insert new card at the beginning (right side)
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // الخلفية العلوية الزرقاء - **زاد ارتفاعها**
                Container(
                  height: 250, // ✅ زودنا الارتفاع عشان يبان أكتر
                  decoration: const BoxDecoration(
                    color: Color(0xff1B659F),
                  ),
                ),
                // الجزء الأبيض في المنتصف مع الجوانب الزرقاء - **نزّلناه شوية**
                Positioned(
                  top: 150, // ✅ نزّلناه 50 بيكسل عشان يظهر الأزرق أكتر
                  left: 0,
                  right: 0,
                  child: Container(
                    width: screenWidth,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40),
                      ),
                    ),
                  ),
                ),
                // منطقة عرض البطاقات + زر الإضافة - **نزّلناها تحت كمان**
                Positioned(
                  top: 80, // ✅ كانت 40 ونزّلناها عشان تكون أوضح
                  left: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // **إضافة تمرير أفقي للبطاقات**
                      Expanded(
                        child: SingleChildScrollView(
                          reverse: true,
                          scrollDirection: Axis.horizontal, // التمرير أفقي
                          child: Row(mainAxisAlignment: MainAxisAlignment.end,children: cards),
                        ),
                      ),
                      const SizedBox(width: 10), // مسافة بين الزر والبطاقات
                      // زر الإضافة بنفس الشكل القديم
                      Container(
                        width: 44,
                        height: 163,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: IconButton(
                            icon: const Icon(Icons.add, color: Colors.black),
                            onPressed: () {  },

                            // onPressed: addCard, // استدعاء دالة الإضافة
                          ),
                        ),
                      ),
        
        
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: screenWidth * 0.9,
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child:  Text(
                      "رقم البطاقة",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 4,),
                Container(
                  width: 343.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: const Color(0xFF1B659F), // اللون الأزرق للحدود
                      width: 1.0, // سمك الحد
                    ),
                  ),
                  child: TextFormField(
                    textDirection: TextDirection.rtl, // الكتابة من اليمين لليسار
                    decoration: const InputDecoration(
                      border: InputBorder.none, // إزالة الحدود الافتراضية للـ TextFormField
                      hintText: 'أدخل النص', // النص المؤقت
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // تعديل المسافة داخل الـ TextFormField
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15,),
            Column(
              children: [
                Container(
                  width: screenWidth * 0.9,
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child:  Text(
                      "اسم حامل البطاقة",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 4,),
                Container(
                  width: 343.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: const Color(0xFF1B659F), // اللون الأزرق للحدود
                      width: 1.0, // سمك الحد
                    ),
                  ),
                  child: TextFormField(
                    textDirection: TextDirection.rtl, // الكتابة من اليمين لليسار
                    decoration: const InputDecoration(
                      border: InputBorder.none, // إزالة الحدود الافتراضية للـ TextFormField
                      hintText: 'أدخل النص', // النص المؤقت
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // تعديل المسافة داخل الـ TextFormField
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
        
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child:  Text(
                          "تاريخ الأنتهاء",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff858585)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4,),
                    Container(
                      width: screenWidth * 0.45,
                      height: 48.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: const Color(0xFF1B659F), // اللون الأزرق للحدود
                          width: 1.0, // سمك الحد
                        ),
                      ),
                      child: TextFormField(
                        textDirection: TextDirection.rtl, // الكتابة من اليمين لليسار
                        decoration: const InputDecoration(
                          border: InputBorder.none, // إزالة الحدود الافتراضية للـ TextFormField
                          hintText: 'أدخل النص', // النص المؤقت
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // تعديل المسافة داخل الـ TextFormField
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
        
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child:  Text(
                          "رمز أمان البطاقة",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff858585)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4,),
                    Container(
                      width: screenWidth * 0.45,
                      height: 48.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: const Color(0xFF1B659F), // اللون الأزرق للحدود
                          width: 1.0, // سمك الحد
                        ),
                      ),
                      child: TextFormField(
                        textDirection: TextDirection.rtl, // الكتابة من اليمين لليسار
                        decoration: const InputDecoration(
                          border: InputBorder.none, // إزالة الحدود الافتراضية للـ TextFormField
                          hintText: 'أدخل النص', // النص المؤقت
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // تعديل المسافة داخل الـ TextFormField
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),




          ],
        ),
      ),
      // تأكد من عدم وجود bottomNavigationBar في الـ Scaffold:
      bottomNavigationBar:     Container(
        width: screenWidth, // Full screen width
        height: 104,
        decoration: const BoxDecoration(
          color: Color(0xFF1B659F), // Background color
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 142,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25), // Optional rounded corners
                ),
                child:
                  ElevatedButton(
                      onPressed: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const SuccessScreen()));

                      },
                      child: const Text(
                            "ادفع الاّن",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500, // Medium weight
                              color: Color(0xFF1B659F),
                            ),
                          ),
                  )
              ),
            ],
          ),
        ),
      ), // **إلغاء أي شريط سفلي هنا**
    );
  }
}
