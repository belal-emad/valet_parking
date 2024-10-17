import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/utils/navigator_methods.dart';
import 'package:valet_parking/view/custom_widgets/api_response_widget/api_response_widget.dart';
import 'package:valet_parking/view/layout/worker/requests/screen/worker_request_new_service_screen.dart';
import 'package:valet_parking/view/layout/worker/services/controller/services_controller.dart';
import 'package:valet_parking/view/layout/worker/services/model/services_model.dart';
import 'package:valet_parking/view/layout/worker/services/widget/worker_details_services_widget.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/custom_app_bar/worker_app_bar.dart';

class WorkerDetailsServicesArgs {
  final ServicesModel servicesModel;
  WorkerDetailsServicesArgs({required this.servicesModel});
}

class WorkerDetailsServicesScreen extends StatelessWidget {
  final WorkerDetailsServicesArgs args;
  const WorkerDetailsServicesScreen({
    super.key,
    required this.args,
  });
  static const String routeName = 'WorkerDetailsServicesScreen';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ServicesController()
          ..initialServiceDetails()
          ..getServiceDetails(id: args.servicesModel.id!);
      },
      child: Consumer<ServicesController>(
          builder: (context, servicesController, _) {
        return Scaffold(
          appBar: WorkerAppBar(context),
          body: ApiResponseWidget(
            apiResponse: servicesController.serviceDetailsResponse,
            onReload: () => servicesController.getServiceDetails(id: 1),
            isEmpty: servicesController.serviceDetails.isEmpty,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'خدمة غسيل السيارات',
                          style: AppTextStyle.textD24B(context),
                        ),
                      ),
                      CustomButton(
                        onPressed: () {
                          NavigatorMethods.pushNamed(
                              context, WorkerRequestNewServiceScreen.routeName,
                              arguments: WorkerRequestNewServiceArgs(
                                  servicesModel: args.servicesModel));
                        },
                        width: MediaQuery.of(context).size.width * 0.34,
                        text: 'طلب خدمة جديد',
                        color: AppColor.secondAppColor(context),
                      )
                    ],
                  ),
                  const Gap(20),
                  ...List.generate(
                    servicesController.serviceDetails.length,
                    (index) => Column(
                      children: [
                        WorkerDetailsServicesWidget(
                          servicesDetailsModel:
                              servicesController.serviceDetails[index],
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
