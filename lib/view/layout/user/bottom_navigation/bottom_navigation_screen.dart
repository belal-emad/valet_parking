import 'package:flutter/material.dart';

import '../../../custom_widgets/bottom_navigation/user_bottom_navigation_bar.dart';
import '../../../custom_widgets/page_container/page_container.dart';
import '../home/screen/user_home_screen.dart';
import '../package/screen/user_packages_screen.dart';
import '../service/screen/user_services_screen.dart';
import '../setting/screen/user_setting_screen.dart';

class UserBottomNavigationScreen extends StatefulWidget {
  static const String routeName = 'UserBottomNavigationScreen';
  const UserBottomNavigationScreen({super.key});

  @override
  State<UserBottomNavigationScreen> createState() =>
      _UserBottomNavigationScreenState();
}

class _UserBottomNavigationScreenState
    extends State<UserBottomNavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      top: false,
      child: Scaffold(
        extendBody: true,
        body: [
          const UserHomeScreen(),
          const UserPackagesScreen(),
          const UserServicesScreen(),
          UserSettingScreen(
            onLangChanged: () {
              setState(() {});
            },
          ),
        ][_currentIndex],
        bottomNavigationBar: UserBottomNavigationBar(
          onChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          onMedTap: () {},
        ),
      ),
    );
  }
}
