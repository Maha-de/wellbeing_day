import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'homescreen.dart';


class GroupTherapy extends StatefulWidget {
  const GroupTherapy({super.key});

  @override
  State<GroupTherapy> createState() => _GroupTherapyState();
}

class _GroupTherapyState extends State<GroupTherapy> {

  final List<String> problemSlots = [];

  final List<String> goalSlots = [];

  final Map<String, bool> _problems = {

  "ادمان": false,
  "خلاف عائلي": false,
    "قلق": false,
    "اكتئاب": false,
    "رهاب اجتماعي": false,
    "وسواس": false,
    "غير ذلك": false,

  };

  final Map<String, bool> _goals = {

    "علاج": false,
    "تنفيس انفعالي": false,
    "تدرب على مهارة اجتماعية": false,
    "حل مشاكل": false,
    "غير ذلك": false,

  };

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height.h;
    double screenWidth = MediaQuery.of(context).size.width.w;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 1,
      ),
      appBar: PreferredSize(
        preferredSize:  Size.fromHeight(35.0.h), // Set the height here
        child: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Color(0xff19649E),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 50.h,
            width: 250.w,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color(0xFF19649E),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child:  Center(
                child: Text(
                  "العلاج الجماعي",
                  style: TextStyle(fontSize: 20.sp, color: Colors.white),
                )),
          ),
        ),
         SizedBox(
          height: 20.h,
        ),

            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                "ما هو العلاج الجماعي؟",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01.h),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextFormField(
                maxLines: null, // Allows the field to expand for multiline input
                style:  TextStyle(fontSize: 14.sp, height: 1.6.h),
                decoration: const InputDecoration(
                  border: InputBorder.none, // Removes the underline
                  contentPadding: EdgeInsets.zero, // Matches the original padding
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01.h),

            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                "إيجابياته",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01.h),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextFormField(
                maxLines: null, // Allows the field to expand for multiline input
                style:  TextStyle(fontSize: 14.sp, height: 1.6.h),
                decoration: const InputDecoration(
                  border: InputBorder.none, // Removes the underline
                  contentPadding: EdgeInsets.zero, // Matches the original padding
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01.h),

            Padding(
              padding:  EdgeInsets.only(right: 20),
              child: Text(
                "المشكلات التي تعاني منها",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                  Wrap(
                    // spacing: 5, // Horizontal spacing
                    // runSpacing: 5, // Vertical spacing
                    children: _problems.keys.map((problem) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width / 2.w , // Two columns
                        child: CheckboxListTile(
                          checkColor: Colors.white,
                          activeColor: Color(0xff19649E),
                          side: BorderSide(color: Color(0xff19649E), width: 2), // Change checkbox border color
                          title: Text(problem, textAlign: TextAlign.start, ), // RTL support
                          value: _problems[problem],
                          onChanged: (bool? value) {
                            setState(() {
                              _problems[problem] = value ?? false;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading, // Checkbox on the left
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01.h),

            Padding(
              padding:  EdgeInsets.only(right: 20),
              child: Text(
                "الأهداف",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Wrap(
                  // spacing: 5, // Horizontal spacing
                  // runSpacing: 5, // Vertical spacing
                  children: _goals.keys.map((goal) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width / 2 .w, // Two columns
                      child: CheckboxListTile(
                        title: Text(goal, textAlign: TextAlign.start), // RTL support
                        value: _goals[goal],
                        onChanged: (bool? value) {
                          setState(() {
                            _goals[goal] = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading, // Checkbox on the left
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),


            Center(
              child: ElevatedButton(
                onPressed: () {

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("تم التسجيل"),
                          content: Text("سيتم تسجيل اسمك على لائحة الانتظار\nعند اكتمال العدد سيتم التواصل معك لتحديد موعد"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Close the dialog
                              },
                              child: const Text('حسنا'),
                            ),
                          ],
                        );
                      },
                    ).then((_) {
                      // This code will run after the dialog is closed

                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
                    }
                    );
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(350, 50),
                    backgroundColor: const Color(0xFF19649E),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child:  Text(
                  "تسجيل",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.05.h),

          ]
        ),
      )
    );
  }
}

