import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/view/custom_widgets/api_response_widget/api_response_widget.dart';
import 'package:valet_parking/view/layout/worker/requests/controller/car_requests_controller.dart';
import 'package:valet_parking/view/layout/worker/requests/model/car_request_model.dart';
import 'package:valet_parking/view/layout/worker/requests/widget/request_widget.dart';

class FinishedRequestTab extends StatelessWidget {
  final List<CarRequestModel> carRequestModel;

  const FinishedRequestTab({super.key, required this.carRequestModel});

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
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ApiResponseWidget(
            apiResponse: carRequestController.exitCarResponse,
            onReload: () => carRequestController.getExitCar(),
            isEmpty: carRequestController.exitCar.isEmpty,
            child: Column(
              children: [
                ...List.generate(
                  carRequestController.exitCar.length,
                  (index) => Column(
                    children: [
                      RequestWidget(
                        carRequestModel: carRequestController.exitCar[index],
                      ),
                      const Gap(10),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
