import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/view/custom_widgets/api_response_widget/api_response_widget.dart';
import 'package:valet_parking/view/custom_widgets/custom_app_bar/worker_app_bar.dart';
import 'package:valet_parking/view/layout/worker/requests/controller/car_requests_controller.dart';
import 'package:valet_parking/view/layout/worker/requests/widget/worker_request_new_servics_widget.dart';
import 'package:valet_parking/view/layout/worker/services/model/services_model.dart';

class WorkerRequestNewServiceArgs {
  final ServicesModel servicesModel;
  WorkerRequestNewServiceArgs({required this.servicesModel});
}

class WorkerRequestNewServiceScreen extends StatefulWidget {
  final WorkerRequestNewServiceArgs args;
  static const String routeName = 'WorkerRequestNewServiceScreen';

  const WorkerRequestNewServiceScreen({super.key, required this.args});

  @override
  State<WorkerRequestNewServiceScreen> createState() =>
      _WorkerRequestNewServiceScreenState();
}

class _WorkerRequestNewServiceScreenState
    extends State<WorkerRequestNewServiceScreen> {
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
        return Scaffold(
          appBar: WorkerAppBar(context),
          body: ApiResponseWidget(
            apiResponse: carRequestController.entryCarResponse,
            onReload: () => carRequestController.getEntryCarRequest(),
            isEmpty: carRequestController.entryCar.isEmpty,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr(AppLocaleKey.requests),
                    style: AppTextStyle.textD24B(context),
                  ),
                  const Gap(26),
                  ...List.generate(
                    carRequestController.entryCar.length,
                    (index) => Column(
                      children: [
                        WorkerRequestsNewServicesWidget(
                          carRequestModel: carRequestController.entryCar[index],
                          servicesModel: widget.args.servicesModel,
                        ),
                        const Gap(20),
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
