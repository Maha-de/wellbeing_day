import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
// Responsive values based on the screen size
    double profileH = MediaQuery.of(context).size.width * 0.5;
    double top = profileH * 0.5;
    double topText = profileH * 0.6;

    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              CoverWidget(profileHeight: profileH),
              Positioned(
                top: topText + profileH / 6,
                left: 0,
                right: 0,
                child: benDetials(),
              ),
              Positioned(
                top: topText,
                left: MediaQuery.of(context).size.width / 2 - (profileH + 150),
                right: 0,
                child: namedTextWidget(),
              ),
              Positioned(
                top: top,
                left: MediaQuery.of(context).size.width / 3 + profileH / 2,
                child: profilePage(profileH),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget benDetials() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "تفاصيل المستفيد",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            infoRow("الاسم", "ميرقت مندور"),
            infoRow("العمر", "23"),
            infoRow("الجنس", "أنثى"),
            infoRow("الجنسية", "مصرية"),
            infoRow("المهنة", "مهندسة برمجة"),
            SizedBox(
              height: 30,
            ),
            sessionSection(
                ["20/3/2025"], ["1/10/2024", "7/7/2023", "1/6/2023"]),
          ],
        ),
      ),
    );
  }

  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$title : ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff19649E),
                fontSize: 20,
              )),
          Text(
            value,
            style: TextStyle(
                fontSize: 20,
                color: Color(
                  0xff19649E,
                )),
          ),
        ],
      ),
    );
  }

  Widget sessionSection(
      List<String> future_dates, List<String> completed_dates) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xff19649E),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'الجلسات القادمة',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),
          Column(
            children: future_dates.map((date) => sessionBox(date)).toList(),
          ),
          SizedBox(height: 12),
          Center(
            child: Text('الجلسات المكتملة',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 8),
          Column(
            children: completed_dates.map((date) => sessionBox(date)).toList(),
          ),
        ],
      ),
    );
  }

  Widget sessionBox(String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(date,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff19649E))),
      ),
    );
  }

  Widget CoverWidget({required double profileHeight}) {
    return Container(
      color: Color(0xff19649E),
      width: double.infinity,
      height: profileHeight,
    );
  }

  Widget namedTextWidget() {
    return Column(children: [
      Text(
        'ميرقت مندور',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        'مهندس برمجة',
        style: TextStyle(
            color: Color(0xff19649E),
            fontWeight: FontWeight.bold,
            fontSize: 20),
      ),
    ]);
  }

  Widget profilePage(double profileHeight) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(profileHeight),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: CircleAvatar(
          radius: profileHeight / 3,
          child: Image(
              image: AssetImage(
            "assets/images/doctor.png",
          )),
        ),
      ),
    );
  }
}
