import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/view/custom_widgets/buttons/notification_button.dart';
import 'package:valet_parking/view/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:valet_parking/view/custom_widgets/page_container/page_container.dart';

class NotificationsScreen extends StatefulWidget {
  static const String routeName = 'NotificationsScreen';
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool getNotifications = false, sound = false, vibrate = false;
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          context,
          automaticallyImplyLeading: true,
          title: Text(
            tr(AppLocaleKey.notificationSettings),
          ),
          actions: const [
            Center(child: NotificationButton()),
            Gap(20),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(50),
              Row(
                children: [
                  Text(
                    tr(
                      AppLocaleKey.getNotifications,
                    ),
                    style: AppTextStyle.textD18B(context),
                  ),
                  const Spacer(),
                  CupertinoSwitch(
                    activeColor: AppColor.mainAppColor(context),
                    value: getNotifications,
                    onChanged: (v) {
                      setState(
                        () {
                          getNotifications = v;
                        },
                      );
                    },
                  ),
                ],
              ),
              const Gap(15),
              Row(
                children: [
                  Text(
                    tr(AppLocaleKey.sound),
                    style: AppTextStyle.textD18B(context),
                  ),
                  const Spacer(),
                  CupertinoSwitch(
                    activeColor: AppColor.mainAppColor(context),
                    value: sound,
                    onChanged: (v) {
                      setState(
                        () {
                          sound = v;
                        },
                      );
                    },
                  ),
                ],
              ),
              const Gap(15),
              Row(
                children: [
                  Text(
                    tr(AppLocaleKey.vibration),
                    style: AppTextStyle.textD18B(context),
                  ),
                  const Spacer(),
                  CupertinoSwitch(
                    activeColor: AppColor.mainAppColor(context),
                    value: vibrate,
                    onChanged: (v) {
                      setState(
                        () {
                          vibrate = v;
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
