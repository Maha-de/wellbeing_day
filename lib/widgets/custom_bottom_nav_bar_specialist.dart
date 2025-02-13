import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import '../cubit/update_user_cubit/update_user_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../screens/applicationInfo.dart';
import '../screens/client_profile_screen.dart';
import '../screens/first_home_page.dart';
import '../screens/home_second_screen.dart';
import '../screens/homescreen.dart';
import '../screens/specialist/sessions_screen.dart';
import '../screens/specialist/specialist_home_screen.dart';
import '../screens/specialist/specialist_profile_screen.dart';

class SpecialistCustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  const SpecialistCustomBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      backgroundColor: const Color(0xff19649E), // Ensures the background is consistent
      selectedItemColor: Colors.white, // Sets the color of the selected icons
      unselectedItemColor: Colors.black, // Sets the color of unselected icons
      showSelectedLabels: false, // Hides selected labels
      showUnselectedLabels: false, // Hides unselected labels
      currentIndex: currentIndex, // Default selected index
      type: BottomNavigationBarType.fixed, // Prevents animation on shifting types
      items: [
        BottomNavigationBarItem(
          icon: SizedBox(
            height: 27, // Adjust icon size
            child:
            Image.asset(
              "assets/images/meteor-icons_home.png",
              fit: BoxFit.fill,
            ),
          ),
          activeIcon: SizedBox(
            height: 27, // Active icon size adjustment
            child: Image.asset(
              "assets/images/meteor-icons_home.png",
              color: currentIndex == 0 ? Colors.white : Colors.black,

              fit: BoxFit.fill,
            ),
          ),
          label: "home",
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            height: 27,
            child: Image.asset(
              "assets/images/teenyicons_appointments-outline.png",
              fit: BoxFit.fill,
            ),
          ),
          activeIcon: SizedBox(
            height: 27,
            child: Image.asset(
              "assets/images/teenyicons_appointments-outline-active.png",
              fit: BoxFit.fill,
            ),
          ),
          label: "menu",
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            height: 25, // Adjust icon size
            child: Image.asset(
              "assets/images/material-symbols_help-clinic-outline-rounded.png",
              fit: BoxFit.fill,
            ),
          ),
          activeIcon: SizedBox(
            height: 25,
            width: 50,
            child: Image.asset(
              "assets/images/material-symbols_help-clinic-outline-rounded_Active.png",
              fit: BoxFit.fill,
            ),
          ),
          label: "info",
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            height: 27,
            child: Image.asset(
              "assets/images/gg_profile.png",
              fit: BoxFit.fill,
            ),
          ),
          activeIcon: SizedBox(
            height: 27,
            child: Image.asset(
              "assets/images/gg_profile1.png",
              fit: BoxFit.fill,
            ),
          ),
          label: "profile",
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 3:

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                    BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                    BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                  ],
                  child: const SpecialistProfileScreen(),
                ),

              ),
                  (route) => false,
            );
            break;
          case 0:

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) => UserProfileCubit(),
                  child: const SpecialistHomeScreen(),
                ),
              ),
            );
            break;
          case 2:

            Navigator.push(context, MaterialPageRoute(builder: (context) => ApplicationInfo()));

            break;

          case 1:

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) => UserProfileCubit(),
                  child: const SessionsScreen(),
                ),
              ),
            );
            break;
        }
      },
    );
  }
}
