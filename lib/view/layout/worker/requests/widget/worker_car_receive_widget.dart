import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:valet_parking/helpers/images/app_images.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/helpers/theme/style.dart';
import 'package:valet_parking/helpers/utils/navigator_methods.dart';
import 'package:valet_parking/view/custom_widgets/buttons/custom_button.dart';
import 'package:valet_parking/view/layout/worker/qr_code_scan/screen/worker_car_pictures_screen.dart';
import 'package:valet_parking/view/layout/worker/qr_code_scan/screen/worker_qr_code_scanner_screen.dart';
import 'package:valet_parking/view/layout/worker/requests/model/car_request_model.dart';

class WorkerCarReceiveWidget extends StatelessWidget {
  final CarRequestModel carRequestModel;
  const WorkerCarReceiveWidget({
    super.key,
    required this.carRequestModel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              color: AppColor.whiteFcColor(context),
              borderRadius: BorderRadius.circular(6),
              boxShadow: appShadow),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'اسم المستخدم',
                      style: AppTextStyle.textD18B(context),
                    ),
                  ),
                  Expanded(
                    child: Text(carRequestModel.userName ?? "",
                        style: AppTextStyle.textM16R(context)),
                  ),
                ],
              ),
              Divider(
                color: AppColor.greyColor(context),
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr(AppLocaleKey.gate),
                    style: AppTextStyle.textL16R(context),
                  ),
                  Flexible(
                    child: Text(
                      carRequestModel.gateTitle ?? "",
                      style: AppTextStyle.textD16S(context),
                    ),
                  ),
                ],
              ),
              const Gap(11),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr(AppLocaleKey.slot),
                    style: AppTextStyle.textL16R(context),
                  ),
                  Flexible(
                    child: Text(
                      carRequestModel.slotTitle ?? "",
                      style: AppTextStyle.textD16S(context),
                    ),
                  ),
                ],
              ),
              const Gap(11),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr(AppLocaleKey.checkInTime),
                    style: AppTextStyle.textL16R(context),
                  ),
                  Flexible(
                    child: Text(
                      carRequestModel.entryDate ?? "",
                      style: AppTextStyle.textD16S(context),
                    ),
                  ),
                ],
              ),
              const Gap(20),
              Center(
                  child: TextButton(
                onPressed: () {
                  NavigatorMethods.pushNamed(
                      context, WorkerCarPicturesScreen.routeName,
                      arguments: WorkerDetailsImagesRequestsArgs(
                        requestsDetails: carRequestModel,
                      ));
                },
                child: Text(tr(AppLocaleKey.viewImages),
                    style: AppTextStyle.textM16R(context).copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: AppColor.mainAppColor(context),
                      decorationThickness: 1.0,
                    )),
              )),
              const Gap(15),
            ],
          ),
        ),
        Positioned(
          bottom: -20,
          child: CustomButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const WorkerQrCodeScannerScreen(
                          comeEntryCarRequests: false,
                        )),
              );
            },
            width: 50,
            hasShadow: true,
            radius: 23.5,
            color: AppColor.mainAppColor(context),
            child: SvgPicture.asset(
              AppImages.qrIcon,
              colorFilter: ColorFilter.mode(
                AppColor.whiteColor(context),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
