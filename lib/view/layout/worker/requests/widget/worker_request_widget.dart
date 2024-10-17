import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/view/layout/worker/requests/model/car_request_model.dart';

import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/theme/style.dart';

class WorkerRequestWidget extends StatelessWidget {
  final CarRequestModel carRequestModel;
  const WorkerRequestWidget({
    super.key,
    required this.carRequestModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.whiteColor(context),
        boxShadow: appShadow,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
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
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  carRequestModel.carModel ?? "",
                  style: AppTextStyle.textD18B(context),
                ),
                const Gap(10),
                Row(
                  children: [
                    Text(
                      tr(AppLocaleKey.gate),
                      style: AppTextStyle.textD18B(context),
                    ),
                    const Gap(5),
                    Text(
                      "${carRequestModel.gateId ?? ""}   ",
                      style: AppTextStyle.textD18B(context),
                    ),
                    Text(
                      tr(AppLocaleKey.slot),
                      style: AppTextStyle.textD18B(context),
                    ),
                    const Gap(5),
                    Text(
                      "${carRequestModel.slotTitle ?? ""}   ",
                      style: AppTextStyle.textD18B(context),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
