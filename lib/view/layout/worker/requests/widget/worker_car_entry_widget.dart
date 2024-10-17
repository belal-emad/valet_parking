import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../model/car_request_model.dart';
import '../../qr_code_scan/screen/worker_qr_code_scanner_screen.dart';

import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/theme/style.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';

class WorkerCarEntryWidget extends StatelessWidget {
  final CarRequestModel carRequestModel;
  const WorkerCarEntryWidget({super.key, required this.carRequestModel});

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
                children: [
                  Expanded(
                    child: Text(
                      tr(AppLocaleKey.gate),
                      style: AppTextStyle.textL16R(context),
                    ),
                  ),
                  Text(
                    carRequestModel.gateTitle ?? "",
                    style: AppTextStyle.textD16S(context),
                  ),
                ],
              ),
              const Gap(11),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      tr(AppLocaleKey.slot),
                      style: AppTextStyle.textL16R(context),
                    ),
                  ),
                  Text(
                    carRequestModel.slotTitle ?? "",
                    style: AppTextStyle.textD16S(context),
                  ),
                ],
              ),
              const Gap(11),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      tr(AppLocaleKey.checkInTime),
                      style: AppTextStyle.textL16R(context),
                    ),
                  ),
                  Text(
                    "",
                    style: AppTextStyle.textD16S(context),
                  ),
                ],
              ),
              const Gap(20),
              Text(
                tr(AppLocaleKey.requiredServices),
                style: AppTextStyle.textL16R(context),
              ),
              const Gap(12),
              CustomButton(
                height: 37,
                color: AppColor.secondAppColor(context).withOpacity(0.2),
                style: AppTextStyle.textS24B(context).copyWith(fontSize: 16),
                borderRadius: BorderRadius.circular(18),
                width: 120,
              ),
              const Gap(20),
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
                          comeEntryCarRequests: true,
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
                AppColor.authScaffoldColor(context),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
