import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/view/layout/worker/services/controller/services_controller.dart';
import '../../../../../helpers/extension/context_extension.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../custom_widgets/custom_app_bar/worker_app_bar.dart';
import '../tab/current_service_tab.dart';
import '../tab/end_service_tab.dart';

class ServicesWorkerScreen extends StatefulWidget {
  const ServicesWorkerScreen({super.key});

  @override
  State<ServicesWorkerScreen> createState() => _ServicesWorkerScreenState();
}

class _ServicesWorkerScreenState extends State<ServicesWorkerScreen>
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
      create: (_) => ServicesController()
        ..initialServices()
        ..getServices(),
      child: Consumer<ServicesController>(
        builder: (context, servicesController, _) {
          return Scaffold(
            appBar: WorkerAppBar(context),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    tr(AppLocaleKey.services),
                    style: AppTextStyle.textD24B(context),
                  ),
                ),
                const Gap(10),
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
                          text: tr(AppLocaleKey.theCurrent),
                        ),
                        Tab(
                          text: tr(AppLocaleKey.theEnding),
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
                      CurrentServiceTab(
                        servicesModel: servicesController.services,
                      ),
                      EndServiceTab(
                        servicesModel: servicesController.services,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
