import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/view/custom_widgets/api_response_widget/api_response_widget.dart';
import 'package:valet_parking/view/custom_widgets/custom_app_bar/worker_app_bar.dart';
import 'package:valet_parking/view/layout/worker/requests/controller/car_requests_controller.dart';
import 'package:valet_parking/view/layout/worker/requests/widget/worker_car_receive_widget.dart';

class WorkerCarReceiveRequestsScreen extends StatelessWidget {
  const WorkerCarReceiveRequestsScreen({super.key});
  static const String routeName = 'WorkerCarReceiveRequestsScreen';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CarRequestController()
        ..initialExitCar()
        ..getExitCar(),
      child: Scaffold(
        appBar: WorkerAppBar(context),
        body: Consumer<CarRequestController>(
          builder: (context, carRequestController, child) => ApiResponseWidget(
            apiResponse: carRequestController.exitCarResponse,
            onReload: () => carRequestController.getExitCar(),
            isEmpty: carRequestController.exitCar.isEmpty,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr(AppLocaleKey.carPickupRequests),
                    style: AppTextStyle.textD24B(context),
                  ),
                  const Gap(20),
                  ...List.generate(
                    carRequestController.exitCar.length,
                    (index) => Column(
                      children: [
                        WorkerCarReceiveWidget(
                          carRequestModel: carRequestController.exitCar[index],
                        ),
                        const Gap(40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
