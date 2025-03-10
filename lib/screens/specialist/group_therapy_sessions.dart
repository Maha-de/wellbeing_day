import 'package:doctor/cubit/send_notification_cubit/send_notification_cubit.dart';
import 'package:doctor/screens/specialist/send_meeting_screen.dart';
import 'package:doctor/screens/specialist/user_profile_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cubit/get_beneficiary_sessions_cubit/beneficiary_session_cubit.dart';
import '../../cubit/get_doctor_sessions_types_cubit/doctor_session_types_cubit.dart';
import '../../cubit/get_group_threapy_cubit/get_group_threapy_cubit.dart';
import '../../cubit/get_group_threapy_cubit/get_group_threapy_state.dart';
import '../../cubit/user_profile_cubit/user_profile_cubit.dart';


class GroupTherapyScreen extends StatefulWidget {
  @override
  State<GroupTherapyScreen> createState() => _GroupTherapyScreenState();
}

class _GroupTherapyScreenState extends State<GroupTherapyScreen> {
  late GetGroupThreapyCubit getGroupThreapyCubit;

  void initState() {
    super.initState();
    getGroupThreapyCubit = BlocProvider.of<GetGroupThreapyCubit>(context);
_loadUserProfile();
  }
  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('doctorId') ?? "";
   getGroupThreapyCubit.getDoctorSessionsTypes(context, id);
  }
  @override
  Widget build(BuildContext context) {
    bool isEnglish = Localizations.localeOf(context).languageCode == 'en';
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Container(
        width: 190.w,
        height: 40.h,
        decoration: const BoxDecoration(
          color: Color(0xFF1F78BC),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          "groupTherapy".tr(),
          style: TextStyle(
            fontSize: isEnglish ? 17 : 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      )),
      body: BlocProvider(
        create: (_) => getGroupThreapyCubit,
        child: BlocBuilder<GetGroupThreapyCubit, GetGroupThreapyState>(
          builder: (context, state) {
            if (state is GetGroupThreapyLoading) {
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            } else if (state is GetGroupThreapyFailure) {
              return Center(child: Text("Error loading profile: ${state.error}"));
            } else if (state is GetGroupThreapySuccess) {
              final sessions = state.session.sessions;

              return ListView.builder(
                itemCount: sessions?.length??0,
                  itemBuilder: (context, index) {
                    final session = sessions?[index];
                    final DateTime dateTime = session?.sessionDate != null
                        ? DateTime.parse(session?.sessionDate??"")
                        : DateTime.now();
                    final String formattedDate = DateFormat('dd MMMM - hh:mm a', 'ar').format(dateTime);

                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider<UserProfileCubit>(
                                    create: (_) => UserProfileCubit()),
                                BlocProvider<DoctorSessionTypesCubit>(
                                    create: (_) => DoctorSessionTypesCubit()),
                                BlocProvider<BeneficiarySessionCubit>(
                                    create: (_) => BeneficiarySessionCubit()),
                                BlocProvider<SendNotificationCubit>(
                                    create: (_) => SendNotificationCubit()),
                              ],
                              child: MeetingScreen( groupThreapy: true,ids: session?.beneficiary?.map((beneficiary) => beneficiary.id).toList() ?? [],),
                            ),
                          ),
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 4,
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Color(0xff19649E),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${session?.category}" +"  ("+"${session?.subcategory}"+")",
                                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                session?.description ?? "لا يوجد وصف",
                                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                              ),

                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Icon(Icons.group, color: Colors.white, size: 16),
                                  SizedBox(width: 8),
                                  Text(" ${session?.beneficiary?.length??0}", style: TextStyle(color: Colors.white))
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(FontAwesomeIcons.calendar, color: Colors.white, size: 16),
                                      SizedBox(width: 8),
                                      Text(" $formattedDate", style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.attach_money, color: Colors.white, size: 16),
                                      SizedBox(width: 8),
                                      Text(" ${session?.paymentStatus}", style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },

              );
            }
            return Center(child: Text('حدث خطأ أثناء تحميل البيانات'));
          },
        ),
      ),
    );
  }
}
