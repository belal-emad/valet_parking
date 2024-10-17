import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/view/layout/worker/requests/model/car_request_model.dart';

class RequestWidget extends StatelessWidget {
  final CarRequestModel carRequestModel;

  const RequestWidget({
    super.key,
    required this.carRequestModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
        color: AppColor.whiteFcColor(context),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            carRequestModel.carModel ?? "",
            style: AppTextStyle.textD16B(context),
          ),
          const Gap(10),
          const Divider(thickness: 1),
          const Gap(10),
          Row(
            children: [
              Text(
                tr(AppLocaleKey.gate),
                style: AppTextStyle.textD16R(context),
              ),
              const Spacer(),
              Text(
                carRequestModel.gateTitle ?? "",
                style: AppTextStyle.textD16B(context),
              ),
            ],
          ),
          const Gap(10),
          Row(
            children: [
              Text(
                tr(AppLocaleKey.slot),
                style: AppTextStyle.textD16R(context),
              ),
              const Spacer(),
              Text(
                carRequestModel.slotTitle ?? "",
                style: AppTextStyle.textD16B(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
