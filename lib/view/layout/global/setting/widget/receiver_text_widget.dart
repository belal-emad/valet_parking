import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';

class ReceiverTextWidget extends StatelessWidget {
  const ReceiverTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Gap(25),
          Container(
              width: 283,
              height: 60,
              decoration: ShapeDecoration(
                color: AppColor.mainAppColor(context),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
              child: Center(
                  child: Text(
                'كيف يمكنني مساعدتك اليوم ؟',
                style: AppTextStyle.textW16R(context),
              ))),
          Positioned(
            right: -12,
            bottom: -4,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..translate(0.0, 0.0)
                ..rotateZ(1.57),
              child: Container(
                width: 50,
                height: 50,
                decoration: ShapeDecoration(
                  color: AppColor.mainAppColor(context),
                  shape: const StarBorder.polygon(sides: 3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
