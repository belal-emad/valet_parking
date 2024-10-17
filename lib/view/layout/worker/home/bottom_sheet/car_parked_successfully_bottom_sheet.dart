import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:valet_parking/helpers/images/app_images.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/helpers/utils/navigator_methods.dart';
import 'package:valet_parking/view/custom_widgets/buttons/custom_button.dart';
import 'package:valet_parking/view/layout/global/app_bottom_sheet/user_bottom_sheet.dart';
import 'package:valet_parking/view/layout/worker/bottom_navigation/worker_bottom_navigation_bar_screen.dart';

class CarParkedSuccessfulyyBottomSheet extends StatelessWidget {
  const CarParkedSuccessfulyyBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return UserBottomSheet(children: [
      const Gap(30),
      Center(
        child: Container(
          width: 90,
          height: 90,
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
            child: SvgPicture.asset(AppImages.checkIcon),
          ),
        ),
      ),
      const Gap(50),
      Center(
        child: Text(
          tr(
            AppLocaleKey.theCarWasParkedSuccessfully,
          ),
          style: AppTextStyle.textD18B(context),
        ),
      ),
      const Gap(30),
      CustomButton(
        onPressed: () {
          NavigatorMethods.pushNamedAndRemoveUntil(
              context, WorkerBottomNavigationBarScreen.routeName);
        },
        color: Colors.transparent,
        style: AppTextStyle.textM20R(context),
        text: tr(AppLocaleKey.done),
      )
    ]);
  }
}
