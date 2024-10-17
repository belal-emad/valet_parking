import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valet_parking/helpers/utils/navigator_methods.dart';
import 'package:valet_parking/view/layout/global/notifications/screen/notifications_screen.dart';

import '../../../helpers/images/app_images.dart';
import '../../../helpers/theme/app_colors.dart';
import 'custom_button.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      width: 47,
      hasShadow: true,
      radius: 23.5,
      color: AppColor.whiteColor(context),
      child: SvgPicture.asset(AppImages.notificationIcon),
      onPressed: () {
        NavigatorMethods.pushNamed(context, NotificationScreen.routeName);
      },
    );
  }
}
