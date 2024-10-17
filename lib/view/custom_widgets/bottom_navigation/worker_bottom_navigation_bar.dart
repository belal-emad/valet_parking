import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../helpers/images/app_images.dart';
import '../../../helpers/locale/app_locale_key.dart';
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/app_text_style.dart';
import '../buttons/custom_button.dart';
import 'bottom_navigation_clip.dart';

class WorkerBottomNavigationBar extends StatelessWidget {
  final void Function(int) onChanged;
  final void Function() onMedTap;
  const WorkerBottomNavigationBar(
      {super.key, required this.onChanged, required this.onMedTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          SizedBox(
            height: 100,
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: CustomPaint(
                painter: BottomNavigationClip(),
                size: const Size(double.infinity, 90),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topCenter,
            child: CustomButton(
              width: 70,
              height: 70,
              radius: 35,
              color: AppColor.whiteColor(context),
              onPressed: onMedTap,
              child: SvgPicture.asset(
                AppImages.qrIcon,
                width: 30,
                height: 30,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 40,
                right: 10,
                left: 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        onChanged.call(0);
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppImages.mainIcon,
                            width: 23,
                            height: 23,
                          ),
                          const Gap(3),
                          Text(
                            tr(AppLocaleKey.main),
                            style: AppTextStyle.bottomNavigationStyle(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        onChanged.call(1);
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppImages.orderIcon,
                            width: 23,
                            height: 23,
                          ),
                          const Gap(3),
                          Text(
                            tr(AppLocaleKey.requests),
                            style: AppTextStyle.bottomNavigationStyle(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(90),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        onChanged.call(2);
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppImages.serviceIcon,
                            width: 23,
                            height: 23,
                          ),
                          const Gap(3),
                          Text(
                            tr(AppLocaleKey.services),
                            style: AppTextStyle.bottomNavigationStyle(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        onChanged.call(3);
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppImages.settingIcon,
                            width: 23,
                            height: 23,
                          ),
                          const Gap(3),
                          Text(
                            tr(AppLocaleKey.settings),
                            style: AppTextStyle.bottomNavigationStyle(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
