import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../model/package_model.dart';
import '../screen/user_packages_details_screen.dart';

class UserPackageWidget extends StatelessWidget {
  final PackageModel packageModel;
  const UserPackageWidget({
    super.key,
    required this.packageModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorMethods.pushNamed(
          context,
          UserPackagesDetailsScreen.routeName,
          arguments: PackageDetailsArgs(
            packageModel: packageModel,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.whiteColor(context),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColor.greenColor(context).withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Icon(
                  Icons.check_circle_rounded,
                  color: AppColor.greenColor(context),
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              child: Text(
                packageModel.title ?? "",
                style: AppTextStyle.textD18B(context),
              ),
            ),
            const Gap(10),
            CustomButton(
              width: 100,
              height: 35,
              color: AppColor.secondAppColor(context).withOpacity(0.12),
              prefixIcon: Icon(
                Icons.info_rounded,
                color: AppColor.secondAppColor(context),
              ),
              style: AppTextStyle.buttonStyle(context).copyWith(
                color: AppColor.secondAppColor(context),
              ),
              text: tr(AppLocaleKey.details),
            ),
          ],
        ),
      ),
    );
  }
}
