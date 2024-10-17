import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/extension/context_extension.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/view/custom_widgets/buttons/notification_button.dart';
import 'package:valet_parking/view/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:valet_parking/view/custom_widgets/page_container/page_container.dart';
import 'package:valet_parking/view/layout/worker/requests/controller/car_requests_controller.dart';
import 'package:valet_parking/view/layout/worker/requests/tab/finished_request_tab.dart';
import 'package:valet_parking/view/layout/worker/requests/tab/new_request_tab.dart';

class RequestSettingScreen extends StatefulWidget {
  static const String routeName = 'RequestSettingScreen';
  const RequestSettingScreen({super.key});

  @override
  State<RequestSettingScreen> createState() => _RequestSettingScreenState();
}

class _RequestSettingScreenState extends State<RequestSettingScreen>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return CarRequestController()
          ..initialEntryCarRequest()
          ..getEntryCarRequest();
      },
      child: Consumer<CarRequestController>(
          builder: (context, carRequestController, _) {
        return PageContainer(
          child: Scaffold(
            appBar: CustomAppBar(
              context,
              automaticallyImplyLeading: true,
              title: Text(
                tr(AppLocaleKey.requests),
              ),
              actions: const [
                Center(
                  child: NotificationButton(),
                ),
                Gap(20),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TabBar(
                      labelColor: AppColor.secondAppColor(context),
                      unselectedLabelColor: AppColor.hintColor(context),
                      labelStyle: AppTextStyle.textD18B(context).copyWith(
                        fontFamily: context.fontFamily(),
                      ),
                      unselectedLabelStyle:
                          AppTextStyle.textD18B(context).copyWith(
                        fontFamily: context.fontFamily(),
                      ),
                      indicatorSize: TabBarIndicatorSize.label,
                      controller: _controller,
                      tabs: [
                        Tab(
                          text: tr(AppLocaleKey.newApplications),
                        ),
                        Tab(
                          text: tr(AppLocaleKey.finishedRequests),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: TabBarView(
                    controller: _controller,
                    children: [
                      NewRequestTab(
                        carRequestModel: carRequestController.entryCar,
                      ),
                      FinishedRequestTab(
                        carRequestModel: carRequestController.exitCar,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
