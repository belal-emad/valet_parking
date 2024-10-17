import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/app_text_style.dart';

class SettingButton extends StatelessWidget {
  final Color? color;
  final String icon;
  final String title;
  final void Function()? onTap;
  const SettingButton({
    super.key,
    this.color,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: 35,
              height: 28,
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  width: 35,
                  height: 28,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    color ?? AppColor.darkTextColor(context),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              child: Text(
                title,
                style: AppTextStyle.textD16B(context).copyWith(
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
