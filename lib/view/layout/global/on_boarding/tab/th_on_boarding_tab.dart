import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../model/on_boarding_model.dart';

class ThOnBoardingTab extends StatelessWidget {
  final OnBoardingModel onBoardingModel;
  const ThOnBoardingTab({super.key, required this.onBoardingModel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            const Image(
              image: AssetImage(AppImages.thirdOnBoardingImage),
              height: 300,
              fit: BoxFit.contain,
            ),
            const Gap(10),
            EasyRichText(
              onBoardingModel.thirdOnboardingTitle ?? "",
              defaultStyle: AppTextStyle.textD24B(context),
              textAlign: TextAlign.center,
              patternList: [
                EasyRichTextPattern(
                  targetString:
                      onBoardingModel.thirdOnboardingSpecialText ?? "",
                  style: AppTextStyle.textS24B(context),
                ),
              ],
            ),
            const Gap(10),
            Text(
              onBoardingModel.thirdOnboardingDescription ?? "",
              style: AppTextStyle.textL16R(context, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
