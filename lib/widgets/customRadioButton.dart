import 'package:flutter/material.dart';

class CustomRadioButtonWidget extends StatefulWidget {
  final String title;
  final String fRad;
  final String sRad;
  final ValueChanged<String> onRoleSelected;

  const CustomRadioButtonWidget({
    super.key,
    required this.title,
    required this.fRad,
    required this.sRad,
    required this.onRoleSelected,
  });

  @override
  _CustomRadioButtonWidgetState createState() =>
      _CustomRadioButtonWidgetState();
}

class _CustomRadioButtonWidgetState extends State<CustomRadioButtonWidget> {
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Radio<String>(
                    activeColor: Color(0xff19649E),
                    value: widget.fRad,
                    groupValue: _selectedRole,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedRole = value;
                      });
                      widget.onRoleSelected(value!);
                    },
                  ),
                  Text(widget.fRad),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    activeColor: Color(0xff19649E),
                    value: widget.sRad,
                    groupValue: _selectedRole,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedRole = value;
                      });
                      widget.onRoleSelected(value!);
                    },
                  ),
                  Text(widget.sRad),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
