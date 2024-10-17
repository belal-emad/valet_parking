import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/utils/date_methods.dart';
import 'package:valet_parking/view/custom_widgets/api_response_widget/api_response_widget.dart';
import 'package:valet_parking/view/layout/worker/qr_code_scan/screen/worker_car_pictures_screen.dart';
import 'package:valet_parking/view/layout/worker/requests/controller/car_requests_controller.dart';
import 'package:valet_parking/view/layout/worker/requests/model/car_request_model.dart';

import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../../custom_widgets/custom_app_bar/worker_app_bar.dart';

class WorkerDetailsRequestsArgs {
  final CarRequestModel requestsDetails;
  WorkerDetailsRequestsArgs({required this.requestsDetails});
}

class WorkerCarDetailsRequestsScreen extends StatelessWidget {
  final WorkerDetailsRequestsArgs args;
  const WorkerCarDetailsRequestsScreen({super.key, required this.args});
  static const String routeName = 'WorkerCarDetailsRequestsScreen';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return CarRequestController()
          ..initialCarRequestDetails()
          ..getCarRequestDetails(id: args.requestsDetails.id!);
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
                id: args.requestsDetails.id!),
            isEmpty: carRequestController.carRequestDetails == null,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr(AppLocaleKey.carDetails),
                    style: AppTextStyle.textD24B(context),
                  ),
                  const Gap(18),
                  Row(
                    children: [
                      Container(
                        width: 63,
                        height: 63,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: AlignmentDirectional.topStart,
                            end: AlignmentDirectional.bottomEnd,
                            colors: [
                              AppColor.grid1Color(context),
                              AppColor.grid2Color(context),
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            AppImages.carRequestImage,
                          ),
                        ),
                      ),
                      const Gap(16),
                      Expanded(
                        child: Text(
                          carRequestController.carRequestDetails?.carModel ??
                              "",
                          style: AppTextStyle.textD18B(context),
                        ),
                      ),
                    ],
                  ),
                  const Gap(26),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr(AppLocaleKey.userName),
                              style: AppTextStyle.textL14R(context),
                            ),
                            const Gap(10),
                            Text(
                              carRequestController
                                      .carRequestDetails?.userName ??
                                  "",
                              style: AppTextStyle.textD14B(context),
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr(AppLocaleKey.phone),
                              style: AppTextStyle.textL14R(context),
                            ),
                            const Gap(10),
                            Text(
                              carRequestController
                                      .carRequestDetails?.userMobile ??
                                  "",
                              style: AppTextStyle.textD14B(context),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Gap(15),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr(AppLocaleKey.parkingPlace),
                              style: AppTextStyle.textL14R(context),
                            ),
                            const Gap(10),
                            Text(
                              carRequestController
                                      .carRequestDetails?.slotTitle ??
                                  "",
                              style: AppTextStyle.textD14B(context),
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr(AppLocaleKey.facility),
                              style: AppTextStyle.textL14R(context),
                            ),
                            const Gap(10),
                            Text(
                              carRequestController
                                      .carRequestDetails?.categoryTypeTitle ??
                                  "",
                              style: AppTextStyle.textD14B(context),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Gap(15),
                  Row(
                    children: [
                      const Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr(AppLocaleKey.theHour),
                              style: AppTextStyle.textL14R(context),
                            ),
                            const Gap(10),
                            Text(
                              "${carRequestController.carRequestDetails?.entryDate ?? ""}${carRequestController.carRequestDetails?.exitDate ?? ""} ",
                              style: AppTextStyle.textD14B(context),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Gap(5),
                  Center(
                      child: TextButton(
                    onPressed: () {
                      NavigatorMethods.pushNamed(
                        context,
                        WorkerCarPicturesScreen.routeName,
                        arguments: WorkerDetailsImagesRequestsArgs(
                          requestsDetails: args.requestsDetails,
                        ),
                      );
                    },
                    child: Text(tr(AppLocaleKey.viewImages),
                        style: AppTextStyle.textM16R(context).copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColor.mainAppColor(context),
                          decorationThickness: 1.0,
                        )),
                  )),
                  const Gap(10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 25),
                    width: double.infinity,
                    color: AppColor.whiteColor(context),
                    child: Text(
                      carRequestController.carRequestDetails?.categoryTitle ??
                          "",
                      style: AppTextStyle.textD18B(context),
                    ),
                  ),
                  const Gap(18),
                  ...List.generate(
                    carRequestController.carRequestDetails?.services!.length ??
                        1,
                    (index) => Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 25),
                      width: double.infinity,
                      color: AppColor.whiteColor(context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            carRequestController.carRequestDetails
                                    ?.services![index].serviceTitle ??
                                "",
                            style: AppTextStyle.textD18B(context),
                          ),
                          const Gap(25),
                          Text(
                            tr(AppLocaleKey.dateOfServiceRequest),
                            style: AppTextStyle.textL14R(context),
                          ),
                          const Gap(10),
                          Text(
                            DateMethods.formatToDate(
                              carRequestController.carRequestDetails
                                      ?.services![index].createdAt ??
                                  "",
                            ),
                            style: AppTextStyle.textD14B(context),
                          ),
                          const Gap(25),
                          Text(
                            tr(
                              AppLocaleKey.notes,
                            ),
                            style: AppTextStyle.textL14R(context),
                          ),
                          const Gap(5),
                          Text(
                              carRequestController.carRequestDetails
                                      ?.services![index].notes ??
                                  "",
                              style: AppTextStyle.textD14B(context)),
                          const Gap(10),
                          Text(
                            tr(
                              AppLocaleKey.phone,
                            ),
                            style: AppTextStyle.textL14R(context),
                          ),
                          const Gap(5),
                          Text(
                              carRequestController.carRequestDetails
                                      ?.services![index].userMobile ??
                                  "",
                              style: AppTextStyle.textD14B(context)),
                        ],
                      ),
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
