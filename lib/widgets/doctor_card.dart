import 'package:doctor/screens/doctor_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/specialist_model.dart';

class DoctorCard extends StatelessWidget {
  final Specialist specialistModel;

  const DoctorCard({super.key, required this.specialistModel});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    print("specialistModel: ${specialistModel.toString()}");
    if (specialistModel != null) {
      print("Doctor Name: ${specialistModel?.firstName} ${specialistModel?.lastName}");
    } else {
      print("No specialist data found!");
    }

    return GestureDetector(
      onTap: () {
        if (specialistModel != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorDetails(
                specialistModel: specialistModel,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("doctorInfoNotAvailable".tr()),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Container(
        width: screenWidth * 0.9,
        height: screenHeight * 0.38,
        child: Card(
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.3,
                color: Color(0xFF19649E),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10, top: 10, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${specialistModel?.firstName ?? "notFound".tr()} ${specialistModel?.lastName ?? ''}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            specialistModel?.work ?? "notAvailable".tr(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 10),
                          buildInfoRow("assets/images/heart.png",
                              "speciality".tr() + "${(specialistModel?.specialties?.mentalHealth?.isNotEmpty ?? false)
                                  ? specialistModel.specialties?.mentalHealth?.join(", ") : "notAvailable".tr()}"),
                          const SizedBox(height: 4),
                          buildInfoRow("assets/images/PhoneCall.png",
                              'availableVideo'.tr()),
                          const SizedBox(height: 4),
                          buildInfoRow("assets/images/experience.png",
                              "experienceYears".tr() + ' ${specialistModel?.yearsExperience ?? 0} ' + "years".tr()),
                          const SizedBox(height: 4),
                          buildInfoRow("assets/images/translation.png",
                              "language".tr() + "arabic".tr() + "، " + "english".tr()),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Container(
                        height: screenHeight * 0.28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset('assets/images/doctor.png',
                            fit: BoxFit.cover),
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
                  buildDetailColumn("assets/images/time.png", 'availability'.tr(),
                      "dateExample".tr()),
                  buildDetailColumn("assets/images/price.png", 'price'.tr(),
                      '${specialistModel?.sessionPrice ?? 'notAvailable'.tr()} ' + "currency".tr()
                          + ' / ' +
                          '${specialistModel?.sessionDuration ?? 'notAvailable'.tr()} ' + "timeSession".tr()
                  ),
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
        Image.asset(
          icon,
          fit: BoxFit.fill,
          width: 21,
          height: 19,
          color: Colors.white,
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(icon, width: 19, height: 19),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(color: Color(0xff19649E), fontSize: 14),
              ),
            ],
          ),
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
