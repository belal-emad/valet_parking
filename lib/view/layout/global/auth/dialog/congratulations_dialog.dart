import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:valet_parking/helpers/utils/navigator_methods.dart';
import 'package:valet_parking/view/layout/user/bottom_navigation/bottom_navigation_screen.dart';

import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';

class CongratulationsDialog extends StatelessWidget {
  const CongratulationsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 0,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.newPasswordImage,
            ),
            const Gap(25),
            Text(
              tr(AppLocaleKey.congratulations),
              style: AppTextStyle.textS24B(context),
            ),
            const Gap(25),
            Text(
              tr(AppLocaleKey.yourAccountIsReadyToUse),
              style: AppTextStyle.textD18R(context),
            ),
            const Gap(25),
            CustomButton(
              text: tr(AppLocaleKey.goToTheHomePage),
              onPressed: () {
                NavigatorMethods.pushNamedAndRemoveUntil(
                  context,
                  UserBottomNavigationScreen.routeName,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
