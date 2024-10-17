import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../global/auth/controller/auth_controller.dart';

class UserFHomeTab extends StatelessWidget {
  final void Function() onPressed;
  const UserFHomeTab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColor.whiteColor(context),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tr(AppLocaleKey.hello, args: [
                  context.watch<AuthController>().profileModel?.name ?? ""
                ]),
                style: AppTextStyle.textS24B(context),
              ),
              const Gap(15),
              Text(
                tr(AppLocaleKey
                    .simplyEnterYourDestinationAndGetAListOfAvailableParkingSpaces),
                style: AppTextStyle.textD18R(
                  context,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const Gap(20),
              CustomButton(
                text: tr(AppLocaleKey.startNow),
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
