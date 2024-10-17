import 'package:flutter/material.dart';

import '../../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/extension/context_extension.dart';
import '../../../../custom_widgets/buttons/notification_button.dart';
import '../tab/user_f_home_tab.dart';
import '../tab/user_s_home_tab.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  late PageController controller;
  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: Image(
              image: AssetImage(AppImages.userHomeBgImage),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const Positioned(
            right: 0,
            left: 0,
            top: kToolbarHeight + 50,
            child: Image(
              image: AssetImage(AppImages.appLogoImage),
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: 110,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              constraints: BoxConstraints(
                maxHeight: context.height() * 0.5,
              ),
              child: PageView(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  UserFHomeTab(
                    onPressed: () {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear,
                      );
                    },
                  ),
                  const UserSHomeTab(),
                ],
              ),
            ),
          ),
          const Positioned(
            right: 20,
            left: 20,
            top: kToolbarHeight,
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: NotificationButton(),
            ),
          ),
        ],
      ),
    );
  }
}
