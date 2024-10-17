import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/helpers/utils/navigator_methods.dart';
import 'package:valet_parking/view/custom_widgets/buttons/custom_button.dart';
import 'package:valet_parking/view/layout/global/app_bottom_sheet/user_bottom_sheet.dart';
import 'package:valet_parking/view/layout/worker/home/bottom_sheet/qr_code_scanner_bottom_sheet.dart';

class ChooseEnterAnewCarOrDeliverCarBottomSheet extends StatelessWidget {
  const ChooseEnterAnewCarOrDeliverCarBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return UserBottomSheet(children: [
      CustomButton(
        onPressed: () {
          Navigator.pop(context);
          NavigatorMethods.showAppBottomSheet(
              context,
              const QrCodeScannerBottomSheet(
                comeIsEntryANewCar: true,
              ),
              isScrollControlled: true,
              enableDrag: true);
        },
        text: tr(AppLocaleKey.enteringANewCar),
      ),
      const Gap(34),
      CustomButton(
        onPressed: () {
          Navigator.pop(context);
          NavigatorMethods.showAppBottomSheet(
              context,
              const QrCodeScannerBottomSheet(
                comeIsEntryANewCar: false,
              ),
              isScrollControlled: true,
              enableDrag: true);
        },
        text: tr(AppLocaleKey.carDelivery),
        style: AppTextStyle.textM16B(context),
        color: AppColor.greenColor(context).withOpacity(0.1),
        borderColor: AppColor.mainAppColor(context),
      ),
      const Gap(29)
    ]);
  }
}
