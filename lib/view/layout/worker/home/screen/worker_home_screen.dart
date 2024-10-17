import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../global/notifications/screen/notifications_screen.dart';
import 'worker_parking_history_car_screen.dart';
import '../../requests/screen/worker_car_entry_requests_screen.dart';
import '../../requests/screen/worker_car_receive_requests_screen.dart';

import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../custom_widgets/custom_app_bar/worker_app_bar.dart';
import '../widget/worker_home_button.dart';
import '../widget/worker_info_personal.dart';

class WorkerHomeScreen extends StatefulWidget {
  const WorkerHomeScreen({super.key});

  @override
  State<WorkerHomeScreen> createState() => _WorkerHomeScreenState();
}

class _WorkerHomeScreenState extends State<WorkerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WorkerAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            const WorkerInfoPersonal(),
            const Gap(50),
            Row(
              children: [
                Expanded(
                  child: WorkerHomeButton(
                    onTap: () {
                      NavigatorMethods.pushNamed(
                          context, WorkerCareEntryRequestsScreen.routeName);
                    },
                    text: tr(AppLocaleKey.carEntryRequests),
                    icon: AppImages.qrIcon,
                  ),
                ),
                const Gap(15),
                Expanded(
                  child: WorkerHomeButton(
                    onTap: () {
                      NavigatorMethods.pushNamed(
                        context,
                        WorkerCarReceiveRequestsScreen.routeName,
                      );
                    },
                    text: tr(AppLocaleKey.carPickupRequests),
                    icon: AppImages.qrIcon,
                  ),
                ),
              ],
            ),
            const Gap(15),
            Row(
              children: [
                Expanded(
                  child: WorkerHomeButton(
                    onTap: () {
                      NavigatorMethods.pushNamed(
                          context, NotificationScreen.routeName);
                    },
                    text: tr(AppLocaleKey.notifications),
                    icon: AppImages.notificationIcon,
                    isNotificationCircle: true,
                  ),
                ),
                const Gap(15),
                Expanded(
                  child: WorkerHomeButton(
                    onTap: () {
                      NavigatorMethods.pushNamed(
                          context, WorkerParkingHistoryCarScreen.routeName);
                    },
                    text: tr(AppLocaleKey.parkingHistory),
                    icon: AppImages.langIcon,
                  ),
                ),
              ],
            ),
            const Gap(100),
          ],
        ),
      ),
    );
  }
}
