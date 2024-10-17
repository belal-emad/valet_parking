import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/view/custom_widgets/api_response_widget/api_response_widget.dart';
import 'package:valet_parking/view/layout/worker/requests/controller/car_requests_controller.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import 'worker_car_details_requests_screen.dart';

import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../custom_widgets/custom_app_bar/worker_app_bar.dart';
import '../widget/worker_request_widget.dart';

class RequestsWorkerScreen extends StatelessWidget {
  const RequestsWorkerScreen({super.key});

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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    const Gap(20),
                    Row(
                      children: [
                        Text(
                          tr(AppLocaleKey.requests),
                          style: AppTextStyle.textD20B(context),
                        ),
                        Flexible(
                          child: Text(
                            tr(AppLocaleKey.carsInsideTheFacility),
                            style: AppTextStyle.textD20B(context),
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    ...List.generate(
                      carRequestController.entryCar.length,
                      (index) => Column(
                        children: [
                          InkWell(
                            onTap: () {
                              NavigatorMethods.pushNamed(context,
                                  WorkerCarDetailsRequestsScreen.routeName,
                                  arguments: WorkerDetailsRequestsArgs(
                                      requestsDetails: carRequestController
                                          .entryCar[index]));
                            },
                            child: WorkerRequestWidget(
                              carRequestModel:
                                  carRequestController.entryCar[index],
                            ),
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
        },
      ),
    );
  }
}
