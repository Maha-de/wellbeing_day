import 'package:doctor/cubit/send_notification_cubit/send_notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../cubit/send_notification_cubit/send_notification_state.dart';
import 'package:easy_localization/easy_localization.dart';


class MeetingScreen extends StatefulWidget {
  final String? uId;
  final List<String?>?ids;
  final bool groupThreapy;
  const MeetingScreen({super.key,  this.uId, this.ids, required this.groupThreapy});

  @override
  _MeetingScreenState createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // لون خلفية ناعم
      appBar: AppBar(
        title: Text("meetingDetails".tr()),
        centerTitle: true,
        backgroundColor: Color(0xff19649E),
        elevation: 0,
      ),
      body: BlocListener<SendNotificationCubit, SendNotificationState>(
        listener: (context, state) {
          if (state is SendNotificationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("notificationSent".tr())),
            );
          } else if (state is SendNotificationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("error".tr() + "${state.error}")),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildLabel("meetingLink".tr()),
              _buildTextField(_linkController, "enterMeetingLink".tr()),
              SizedBox(height: 20.h),
              _buildLabel("message".tr()),
              _buildTextField(_messageController, "enterYourMessage".tr(), maxLines: 4),
              SizedBox(height: 23.h),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.blueGrey),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blueAccent.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xff19649E), width: 2),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<SendNotificationCubit, SendNotificationState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: state is SendNotificationLoading
                ? null
                : () async {
              String link = _linkController.text;
              String message = _messageController.text;
              if (link.isNotEmpty && message.isNotEmpty) {
                final prefs = await SharedPreferences.getInstance();
                String dId = prefs.getString('doctorId') ?? "";

                if (widget.groupThreapy && widget.ids != null) {
                  // لو كان جروب ثيرابي، يبعث لكل الـ ids
                  for (String? id in widget.ids!) {
                    if (id != null) {
                      BlocProvider.of<SendNotificationCubit>(context)
                          .sendNotification(context, dId, id, link, message);
                    }
                  }
                } else {
                  // لو مش جروب ثيرابي، يبعث بس لشخص واحد
                  BlocProvider.of<SendNotificationCubit>(context)
                      .sendNotification(context, dId, widget.uId ?? "", link, message);
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("pleaseFillFields".tr())),
                );
              }
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff19649E),
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: state is SendNotificationLoading
                ? CircularProgressIndicator(color: Colors.white)
                : Text("submit".tr(), style: TextStyle(fontSize: 18.sp, color: Colors.white)),
          ),
        );
      },
    );
  }
}
