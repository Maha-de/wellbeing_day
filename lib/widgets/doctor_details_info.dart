import 'package:flutter/material.dart';

class DoctorInfo extends StatelessWidget {
  final String text;
  const DoctorInfo({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Align the row to the right
      crossAxisAlignment: CrossAxisAlignment.end, // Align the row elements to the bottom
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 16, color: Color(0xff19649E)), // Styling the text
          textAlign: TextAlign.right, // Align text to the right
        ),
      ],
    );
  }
}
