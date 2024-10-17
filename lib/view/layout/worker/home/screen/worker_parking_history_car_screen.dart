import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/view/custom_widgets/api_response_widget/api_response_widget.dart';
import 'package:valet_parking/view/custom_widgets/custom_app_bar/worker_app_bar.dart';
import 'package:valet_parking/view/layout/worker/home/widget/worker_parking_history_car_widget.dart';
import 'package:valet_parking/view/layout/worker/requests/controller/car_requests_controller.dart';

class WorkerParkingHistoryCarScreen extends StatelessWidget {
  const WorkerParkingHistoryCarScreen({super.key});
  static const String routeName = 'WorkerParkingHistoryCarScreen';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return CarRequestController()
          ..initialExitCar()
          ..getExitCar();
      },
      child: Consumer<CarRequestController>(
          builder: (context, carRequestController, _) {
        return Scaffold(
          appBar: WorkerAppBar(context),
          body: ApiResponseWidget(
            apiResponse: carRequestController.exitCarResponse,
            onReload: () => carRequestController.getExitCar(),
            isEmpty: carRequestController.exitCar.isEmpty,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(10),
                  Center(
                    child: Text(
                      tr(AppLocaleKey.parkingHistory),
                      style: AppTextStyle.textD20B(context),
                    ),
                  ),
                  const Gap(20),
                  ...List.generate(
                    carRequestController.exitCar.length,
                    (index) => Column(
                      children: [
                        WorkerParkingHistoryCarWidget(
                          parkingHistoryCar:
                              carRequestController.exitCar[index],
                        ),
                        const Gap(40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
