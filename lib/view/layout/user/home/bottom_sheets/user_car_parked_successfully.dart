import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:valet_parking/helpers/images/app_images.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/view/custom_widgets/buttons/custom_button.dart';
import 'package:valet_parking/view/layout/global/app_bottom_sheet/user_bottom_sheet.dart';

class UserCarParkedSuccessfully extends StatelessWidget {
  const UserCarParkedSuccessfully({super.key});

  @override
  Widget build(BuildContext context) {
    return UserBottomSheet(
      children: [
        const Image(image: AssetImage(AppImages.firstOnBoardingImage)),
        Center(
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(children: [
              TextSpan(
                  text: tr(AppLocaleKey.carParked),
                  style: AppTextStyle.textD24B(context)),
              const TextSpan(text: '\n'),
              TextSpan(
                  text: tr(AppLocaleKey.successfully),
                  style: AppTextStyle.textS24B(context))
            ]),
          ),
        ),
        const Gap(25),
        CustomButton(
          onPressed: () {
            Navigator.pop(context);
          },
          text: tr(AppLocaleKey.done),
        ),
      ],
    );
  }
}
