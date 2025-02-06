
import 'package:doctor/screens/doctor_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/specialist_model.dart';


class DoctorCard extends StatelessWidget {
  final SpecialistModel specialistModel;

  const DoctorCard({super.key, required this.specialistModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DoctorDetails()),
        );
      },
      child: Container(
        width: Get.width * 0.9,
        height: 297,
        child: Card(
          child: Column(
            children: [
              Container(
                height: 220,
                color: Color(0xFF19649E),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${specialistModel.specialist.firstName} ${specialistModel.specialist.lastName}', // Doctor's name
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            specialistModel.specialist.work, // Work type
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 10),
                          buildInfoRow("assets/images/heart.png",
                              'النوع: ${specialistModel.specialist.specialties.mentalHealth.join(", ")}'), // Example for specialties
                          const SizedBox(height: 4),
                          buildInfoRow("assets/images/PhoneCall.png",
                              'متاح جلسات صوتية، فيديو'),
                          const SizedBox(height: 4),
                          buildInfoRow(
                              "assets/images/experience.png",
                              'خبرة ${specialistModel.specialist.yearsExperience} سنوات'), // Years of experience
                          const SizedBox(height: 4),
                          buildInfoRow("assets/images/translation.png",
                              'اللغة: العربية، الإنجليزية'), // Example for languages
                        ],
                      ),
                    ),
                    Flexible(
                      child: Container(
                        height: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Transform.translate(
                          offset: Offset(0, -14),
                          child: Transform.scale(
                            scale: 1.25,
                            child: Image.asset('assets/images/doctor.png',
                                fit: BoxFit.contain),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buildDetailColumn("assets/images/time.png", 'أقرب إتاحة',
                      '04 يونيو - 7:00 مساءً'), // Example for availability
                  buildDetailColumn("assets/images/price.png", 'السعر',
                      '${specialistModel.specialist.sessionPrice} ليرة / ${specialistModel.specialist.sessionDuration} دقيقة'), // Price and session duration
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 21.19,
          height: 19,
          child: Image.asset(
            icon,
            fit: BoxFit.fill,
            width: 21.19,
            height: 19,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.white),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }

  Widget buildDetailColumn(String icon, String title, String value) {
    return Container(
      width: Get.width * 0.8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                color: Colors.white,
                width: 19,
                height: 19,
                child: Image.asset(icon, fit: BoxFit.fill),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(color: Color(0xff19649E), fontSize: 14),
              ),
            ],
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xff19649E)),
          ),
        ],
      ),
    );
  }
}
