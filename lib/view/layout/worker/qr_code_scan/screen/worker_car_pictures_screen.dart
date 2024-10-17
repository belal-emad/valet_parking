import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/view/custom_widgets/api_response_widget/api_response_widget.dart';
import 'package:valet_parking/view/custom_widgets/custom_app_bar/worker_app_bar.dart';
import 'package:valet_parking/view/custom_widgets/custom_image/custom_network_image.dart';
import 'package:valet_parking/view/layout/worker/requests/controller/car_requests_controller.dart';
import 'package:valet_parking/view/layout/worker/requests/model/car_request_model.dart';

class WorkerDetailsImagesRequestsArgs {
  final CarRequestModel requestsDetails;
  WorkerDetailsImagesRequestsArgs({required this.requestsDetails});
}

class WorkerCarPicturesScreen extends StatefulWidget {
  final WorkerDetailsImagesRequestsArgs args;
  static const String routeName = 'WorkerCarPicturesScreen';

  const WorkerCarPicturesScreen({
    super.key,
    required this.args,
  });

  @override
  WorkerCarPicturesScreenState createState() => WorkerCarPicturesScreenState();
}

class WorkerCarPicturesScreenState extends State<WorkerCarPicturesScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return CarRequestController()
          ..initialCarRequestDetails()
          ..getCarRequestDetails(id: widget.args.requestsDetails.id!);
      },
      child: Consumer<CarRequestController>(
          builder: (context, carRequestController, _) {
        return Scaffold(
          appBar: WorkerAppBar(
            context,
            showIconSearch: false,
          ),
          body: ApiResponseWidget(
            apiResponse: carRequestController.carRequestDetailsResponse,
            onReload: () => carRequestController.getCarRequestDetails(
                id: widget.args.requestsDetails.id!),
            isEmpty: carRequestController.carRequestDetails == null,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        tr(AppLocaleKey.carParkingAt),
                        style: AppTextStyle.textD24B(context),
                      ),
                      const Gap(5),
                      Flexible(
                        child: Text(
                          'مرفق المقهى',
                          style: AppTextStyle.textS24B(context),
                        ),
                      ),
                    ],
                  ),
                  const Gap(18),
                  Text(
                    tr(AppLocaleKey.addedCarPictures),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Gap(36),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemCount: carRequestController
                        .carRequestDetails?.carImages?.length,
                    itemBuilder: (context, index) {
                      return CustomNetworkImage(
                        imageUrl: carRequestController
                            .carRequestDetails!.carImages![index].url
                            .toString(),
                        fit: BoxFit.fill,
                        radius: 10,
                      );
                    },
                  ),
                  const Gap(18),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
