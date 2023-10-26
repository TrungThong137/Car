import 'package:car_app/src/firebase/firebase_auth.dart';
import 'package:car_app/src/models/infor_drawer.dart';
import 'package:car_app/src/pages/profile_page/slide_menu.dart';
import 'package:car_app/src/pages/login_page/login_page.dart';
import 'package:car_app/src/configs/widget/infor_card.dart';
import 'package:flutter/material.dart';

import '../utils/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedIndex = -1;
  final FireAuth _fireAuth = FireAuth();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          height: double.infinity,
          color: Colors.white,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const InfoCard(
                  name: "Abu Anwar",
                  profession: "YouTuber",
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                  child: Text(
                    "Browse".toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.black),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Divider(
                    height: 1.2,
                    color: Colors.black,
                  ),
                ),
                Wrap(
                  children: List.generate(inforDrawer.length, (index) {
                    if (index + 1 != inforDrawer.length) {
                      return SlideMenuTitle(
                        icon: inforDrawer[index].icon,
                        text: inforDrawer[index].text,
                        index: index,
                        selectedIndex: selectedIndex,
                        ontap: () {
                          setState(() {
                            selectedIndex = index;
                            // Navigator.pushReplacement(context, PageRouteBuilder(
                            //   pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),));
                          });
                        },
                      );
                    } else {
                      return SizedBox(
                        height: 200,
                        child: SlideMenuTitle(
                          icon: inforDrawer[index].icon,
                          text: inforDrawer[index].text,
                          index: index,
                          selectedIndex: selectedIndex,
                          ontap: () {
                            setState(() {
                              selectedIndex = index;
                              AppPref.logout();
                              _fireAuth.signOut();
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<InforDrawer> inforDrawer = [
  InforDrawer(icon: Icons.home_outlined, text: 'Home'),
  InforDrawer(icon: Icons.search, text: 'Search'),
  InforDrawer(icon: Icons.star_outline, text: 'Star'),
  InforDrawer(icon: Icons.favorite_outline, text: 'Heart'),
  InforDrawer(icon: Icons.logout, text: 'Log out'),
];
