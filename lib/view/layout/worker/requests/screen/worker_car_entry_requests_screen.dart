import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../../custom_widgets/api_response_widget/api_response_widget.dart';
import '../controller/car_requests_controller.dart';

import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../custom_widgets/custom_app_bar/worker_app_bar.dart';
import '../widget/worker_car_entry_widget.dart';

class WorkerCareEntryRequestsScreen extends StatelessWidget {
  const WorkerCareEntryRequestsScreen({super.key});
  static const String routeName = 'WorkerCareEntryRequestsScreen';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CarRequestController()
          ..initialEntryCarRequest()
          ..getEntryCarRequest(),
        child: Scaffold(
          appBar: WorkerAppBar(context),
          body: Consumer<CarRequestController>(
              builder: (context, carRequestController, child) =>
                  ApiResponseWidget(
                    apiResponse: carRequestController.entryCarResponse,
                    onReload: () => carRequestController.getEntryCarRequest(),
                    isEmpty: carRequestController.entryCar.isEmpty,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr(AppLocaleKey.carEntryRequests),
                            style: AppTextStyle.textD24B(context),
                          ),
                          const Gap(20),
                          ...List.generate(
                            carRequestController.entryCar.length,
                            (index) => Column(
                              children: [
                                WorkerCarEntryWidget(
                                  carRequestModel:
                                      carRequestController.entryCar[index],
                                ),
                                const Gap(40),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
        ));
  }
}
