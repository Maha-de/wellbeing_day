import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor/screens/homescreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/get_specialist/get_sepcialist_cubit.dart';
import '../cubit/get_specialist/get_specialist_state.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../models/user_profile_model.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/doctor_card.dart';
import 'client_profile_screen.dart';
import 'info_screen.dart';

class FirstHomePage extends StatefulWidget {
  const FirstHomePage({super.key});

  @override
  State<FirstHomePage> createState() => _FirstHomePageState();
}

class _FirstHomePageState extends State<FirstHomePage> {
  var sliderIndex = 0;
  CarouselSliderController carouselControllerEx = CarouselSliderController();
  late UserProfileCubit userProfileCubit;

  var images = [
    'assets/images/family.png',
    'assets/images/familyy.png',
    'assets/images/familyyy.png',
  ];

  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";
    userProfileCubit.getUserProfile(context, id);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
        create: (context) => userProfileCubit,
        child: BlocBuilder<UserProfileCubit, UserProfileState>(
            builder: (context, state) {
              if (state is UserProfileLoading) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              } else if (state is UserProfileFailure) {
                return Scaffold(
                  appBar: CustomAppBar(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  backgroundColor: Colors.white,
                  bottomNavigationBar: const CustomBottomNavBar(
                    currentIndex: 0,
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                    
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: CarouselSlider(
                            carouselController: carouselControllerEx,
                            options: CarouselOptions(
                                height: 180,
                                autoPlay: true,
                                onPageChanged: (index, _) {
                                  sliderIndex = index;
                                  setState(() {});
                                }),
                            items: images.map((i) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Image.asset(
                                      i,
                                      fit: BoxFit.cover,
                                    )),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 20
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xFFAFDCFF)),
                            height: 50,
                            width: 380,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                labelText: "البحث",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        BlocBuilder<GetSpecialistCubit, GetSpecialistState>(
                          builder: (context, state) {
                            if (state is SpecialistLoading) {
                              return CircularProgressIndicator(); // Show loading indicator
                            } else if (state is SpecialistFailure) {
                              return Text(state.errMessage); // Display error message
                            } else if (state is SpecialistSuccess) {
                              return Container(
                                height: screenHeight*0.58,
                                child: ListView.builder(
                                  itemCount: state.specialists.length,
                                  itemBuilder: (context, index) {
                                    return DoctorCard(specialistModel: state.specialists[index]);
                                  },
                                ),
                              );
                            } else {
                              return Center(child: Text('No specialists found.'));
                            }
                          },
                        )
                      ],
                    ),
                  ),
                );
              } else if (state is UserProfileSuccess) {
                UserProfileModel userProfile = state.userProfile;
                return Scaffold(
                  backgroundColor: Colors.white,
                  bottomNavigationBar: const CustomBottomNavBar(
                    currentIndex: 0,
                  ),
                  body: Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: const BoxDecoration(
                          color: Color(0xFFAFDCFF),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40.0),
                            bottomRight: Radius.circular(40.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 70, 20, 20),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 66,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              50),
                                          child:
                                          userProfile.imageUrl == "" ||
                                              userProfile.imageUrl == null
                                              ? Image.asset(
                                              "assets/images/profile.jpg",
                                              fit: BoxFit.fill)
                                              : Image.network(
                                              userProfile.imageUrl ?? "",
                                              fit: BoxFit.fill),

                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "greeting".tr() + "\n ${userProfile.firstName}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff19649E),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, right: 40),
                                  child: SizedBox(
                                    height: 100,
                                    width: 110,
                                    child: Image.asset('assets/images/img.png',
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .end,
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.phone,
                                                size: 35,
                                                color: Colors.red,
                                              )),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.notifications_outlined,
                                                size: 40,
                                                color: Color(0xff19649E),
                                              )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30),
                                        child: Column(
                                          children: [
                                            const Text(
                                              "تواصل معنا",
                                              style: TextStyle(
                                                color: Color(0xff19649E),
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: SizedBox(
                                                    width: 27.66,
                                                    height: 25.33,
                                                    child: Image.asset(
                                                        "assets/images/fa-brands_twitter-square.png",
                                                        fit: BoxFit.fill),
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: SizedBox(
                                                    width: 27.66,
                                                    height: 25.33,
                                                    child: Image.asset(
                                                        "assets/images/uil_facebook.png",
                                                        fit: BoxFit.fill),
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: SizedBox(
                                                    width: 27.66,
                                                    height: 25.33,
                                                    child: Image.asset(
                                                        "assets/images/ri_instagram-fill.png",
                                                        fit: BoxFit.fill),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: CarouselSlider(
                          carouselController: carouselControllerEx,
                          options: CarouselOptions(
                              height: 180,
                              autoPlay: true,
                              onPageChanged: (index, _) {
                                sliderIndex = index;
                                setState(() {});
                              }),
                          items: images.map((i) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Image.asset(
                                    i,
                                    fit: BoxFit.cover,
                                  )),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFFAFDCFF)),
                          height: 50,
                          width: 380,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              labelText: "البحث",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: ListView.separated(
                            padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 30),
                            itemBuilder: (context, index) {
                              // return DoctorCard();
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 20);
                            },
                            itemCount: 2,
                            shrinkWrap:
                            true,
                            // Makes ListView behave like a normal widget inside a Column
                            physics:
                            const NeverScrollableScrollPhysics(), // Prevents the ListView from having its own scroll
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container(); // Default return in case no state matches
            }
    )
    );
  }
}
