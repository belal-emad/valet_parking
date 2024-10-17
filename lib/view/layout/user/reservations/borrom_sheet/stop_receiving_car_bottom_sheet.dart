import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:valet_parking/helpers/images/app_images.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/view/custom_widgets/custom_select/custom_select_item.dart';
import 'package:valet_parking/view/custom_widgets/custom_select/custom_single_select.dart';

import '../../../../custom_widgets/buttons/custom_button.dart';

class StopReceivingCarBottomSheet extends StatefulWidget {
  const StopReceivingCarBottomSheet({super.key});

  @override
  State<StopReceivingCarBottomSheet> createState() =>
      _StopPackagesBottomSheetState();
}

class _StopPackagesBottomSheetState extends State<StopReceivingCarBottomSheet> {
  int? _days;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColor.popupColor(context),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),
          ),
          const Divider(
            thickness: 4,
            endIndent: 170,
            indent: 170,
          ),
          const Gap(25),
          Text(
            tr(AppLocaleKey.requestToReceiveTheCarDuring),
            style: AppTextStyle.textD18B(context),
          ),
          const Gap(15),
          CustomSingleSelect(
            titleStyle: AppTextStyle.textD14B(context),
            value: _days,
            onChanged: (value) {
              setState(
                () {
                  _days = value;
                },
              );
            },
            hintStyle: AppTextStyle.textD14B(context),
            unFocusColor: AppColor.offWhiteColor(context),
            fillColor: AppColor.offWhiteColor(context),
            hintText: '09.00 AM',
            radius: 10,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                AppImages.timeIcon,
              ),
            ),
            items: [
              CustomSelectItem(
                value: 1,
                name: '2 ايام',
              ),
              CustomSelectItem(
                value: 2,
                name: ' 3ايام',
              ),
            ],
          ),
          const Gap(15),
          CustomButton(
            gradient: LinearGradient(colors: [
              AppColor.grid1Color(context),
              AppColor.grid2Color(context),
            ]),
            radius: 10,
            onPressed: () {
              Navigator.pop(context);
            },
            text: tr(AppLocaleKey.done),
          ),
          const Gap(25),
        ],
      ),
    );
  }
}
