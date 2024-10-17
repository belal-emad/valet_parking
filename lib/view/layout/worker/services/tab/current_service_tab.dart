import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/view/custom_widgets/api_response_widget/api_response_widget.dart';
import 'package:valet_parking/view/layout/worker/services/controller/services_controller.dart';
import 'package:valet_parking/view/layout/worker/services/model/services_model.dart';

import '../widget/worker_service_widget.dart';

class CurrentServiceTab extends StatelessWidget {
  final List<ServicesModel> servicesModel;
  const CurrentServiceTab({super.key, required this.servicesModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ServicesController()
          ..initialServices()
          ..getServices(status: 'pending');
      },
      child: Consumer<ServicesController>(
          builder: (context, servicesController, _) {
        return ApiResponseWidget(
          apiResponse: servicesController.servicesResponse,
          onReload: () => servicesController.getServices(status: 'pending'),
          isEmpty: servicesController.services.isEmpty,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                ...List.generate(
                  servicesModel.length,
                  (index) => Column(
                    children: [
                      WorkerServiceWidget(
                        servicesModel: servicesModel[index],
                      ),
                      const Gap(10),
                    ],
                  ),
                ),
                const Gap(100),
              ],
            ),
          ),
        );
      }),
    );
  }
}
