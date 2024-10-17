import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/view/custom_widgets/api_response_widget/api_response_widget.dart';
import 'package:valet_parking/view/custom_widgets/custom_app_bar/worker_app_bar.dart';
import 'package:valet_parking/view/layout/global/notifications/controller/notifications_controller.dart';
import 'package:valet_parking/view/layout/global/notifications/widget/notification_item_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  static const String routeName = 'NotificationScreen';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return NotificationsController()
          ..initialNotifications()
          ..getNotifications();
      },
      child: Consumer<NotificationsController>(
          builder: (context, notificationsController, _) {
        return Scaffold(
          appBar: WorkerAppBar(
            context,
            showIconSearch: false,
          ),
          body: ApiResponseWidget(
            apiResponse: notificationsController.notificationsResponse,
            onReload: () => notificationsController.getNotifications(),
            isEmpty: notificationsController.notifications.isEmpty,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  Text(
                    tr(AppLocaleKey.notifications),
                    style: AppTextStyle.textD24B(context),
                  ),
                  const Gap(30),
                  Text(
                    tr(AppLocaleKey.today),
                    style: AppTextStyle.textD24B(context),
                  ),
                  const Gap(20),
                  ...List.generate(
                    notificationsController.notifications.length,
                    (index) => Column(
                      children: [
                        NotificationsItemWidget(
                          notificationsModel:
                              notificationsController.notifications[index],
                        ),
                        const Gap(10),
                      ],
                    ),
                  ),
                  const Gap(100),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
