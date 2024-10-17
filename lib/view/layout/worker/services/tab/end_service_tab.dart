import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../custom_widgets/api_response_widget/api_response_widget.dart';
import '../controller/services_controller.dart';
import '../model/services_model.dart';
import '../widget/worker_service_widget.dart';

class EndServiceTab extends StatelessWidget {
  final List<ServicesModel> servicesModel;

  const EndServiceTab({super.key, required this.servicesModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ServicesController()
          ..initialServices()
          ..getServices(status: "finished");
      },
      child: Consumer<ServicesController>(
          builder: (context, servicesController, _) {
        return ApiResponseWidget(
          apiResponse: servicesController.servicesResponse,
          onReload: () => servicesController.getServices(status: "finished"),
          isEmpty: servicesController.services.isEmpty,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                ...List.generate(
                  servicesController.services.length,
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
