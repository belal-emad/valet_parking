import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/helpers/theme/style.dart';
import 'package:valet_parking/view/layout/user/reservations/model/reservations_history_model.dart';

class PreviousReservationHistoryWidget extends StatelessWidget {
  final ReservationsHistoryModel reservationsHistoryModel;
  const PreviousReservationHistoryWidget({
    super.key,
    required this.reservationsHistoryModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  reservationsHistoryModel.carModel ?? "",
                  style: AppTextStyle.textD18B(context),
                ),
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
                tr(AppLocaleKey.attachment),
                style: AppTextStyle.textL16R(context),
              ),
              Flexible(
                  child: Text(
                reservationsHistoryModel.categoryTypeTitle ?? "",
                style: AppTextStyle.textD16S(context),
              )),
            ],
          ),
          const Gap(11),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr(AppLocaleKey.gate),
                style: AppTextStyle.textL16R(context),
              ),
              Flexible(
                  child: Text(
                reservationsHistoryModel.gateTitle ?? "",
                style: AppTextStyle.textD16S(context),
              )),
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
                reservationsHistoryModel.slotTitle ?? "",

                // DateMethods.formatToDate(
                //   parkingHistoryCar.createdAt ?? "",
                // ),
                style: AppTextStyle.textD16S(context),
              )),
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
                '11:00 am',
                style: AppTextStyle.textD16S(context),
              )),
            ],
          ),
          const Gap(11),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr(AppLocaleKey.checkOutTime),
                style: AppTextStyle.textL16R(context),
              ),
              Flexible(
                  child: Text(
                '11:00 am',
                style: AppTextStyle.textD16S(context),
              )),
            ],
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
