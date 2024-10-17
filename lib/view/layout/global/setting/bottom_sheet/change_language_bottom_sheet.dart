import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../helpers/hive/hive_methods.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';

class ChangeLanguageBottomSheet extends StatelessWidget {
  final VoidCallback onChanged;
  const ChangeLanguageBottomSheet({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.popupColor(context),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  const Gap(50),
                  Text(
                    tr(AppLocaleKey.language),
                    style: AppTextStyle.textD24B(context),
                  ),
                  Divider(
                    color: AppColor.mainAppColor(context),
                  ),
                  const Gap(20),
                  CustomButton(
                    onPressed: () {
                      context.setLocale(const Locale("ar"));
                      HiveMethods.updateLang(const Locale("ar"));
                      Navigator.pop(context);
                      onChanged.call();
                    },
                    style: context.locale == const Locale('ar')
                        ? null
                        : AppTextStyle.textM16B(context),
                    color: context.locale == const Locale('ar')
                        ? null
                        : AppColor.textFormFillColor(context),
                    borderColor: context.locale == const Locale('ar')
                        ? null
                        : AppColor.mainAppColor(context),
                    text: 'العربية',
                  ),
                  const Gap(20),
                  CustomButton(
                    onPressed: () {
                      context.setLocale(const Locale("en"));
                      HiveMethods.updateLang(const Locale("en"));
                      Navigator.pop(context);
                      onChanged.call();
                    },
                    style: context.locale == const Locale('en')
                        ? null
                        : AppTextStyle.textM16B(context),
                    color: context.locale == const Locale('en')
                        ? null
                        : AppColor.textFormFillColor(context),
                    borderColor: context.locale == const Locale('en')
                        ? null
                        : AppColor.mainAppColor(context),
                    text: 'English',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
