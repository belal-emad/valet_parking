import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';

class PackageTypeList extends StatelessWidget {
  const PackageTypeList({
    super.key,
    required this.isSelected,
    required this.title,
    required this.price,
    required this.onTap,
  });

  final bool isSelected;
  final String title;
  final String price;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IntrinsicWidth(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColor.greenColor(context).withOpacity(0.08),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(6),
                    ),
                  ),
                  child: Text(
                    title,
                    style: AppTextStyle.textD18B(context),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColor.secondAppColor(context),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(6),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      price,
                      style: AppTextStyle.textW18B(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
          isSelected
              ? Positioned(
                  top: -7,
                  right: -7,
                  child: SvgPicture.asset(AppImages.packageCheckIcon))
              : const SizedBox(),
        ],
      ),
    );
  }
}
