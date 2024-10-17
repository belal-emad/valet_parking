import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/theme/style.dart';

class WorkerHomeButton extends StatelessWidget {
  final String icon;
  final String text;
  final bool isNotificationCircle;
  final void Function() onTap;
  const WorkerHomeButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.isNotificationCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
          color: AppColor.whiteColor(context),
          borderRadius: BorderRadius.circular(6),
          boxShadow: appShadow,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColor.secondAppColor(context),
                        shape: BoxShape.circle),
                    child: SvgPicture.asset(
                      icon,
                      colorFilter: ColorFilter.mode(
                        AppColor.whiteColor(context),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  isNotificationCircle
                      ? Container(
                          width: 13,
                          height: 13,
                          decoration: BoxDecoration(
                            color: AppColor.redColor(context),
                            shape: BoxShape.circle,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              const Gap(20),
              Text(
                text,
                style: AppTextStyle.textL14R(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
