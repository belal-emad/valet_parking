import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../model/on_boarding_model.dart';

class SOnBoardingTab extends StatelessWidget {
  final OnBoardingModel onBoardingModel;
  const SOnBoardingTab({super.key, required this.onBoardingModel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            const Image(
              image: AssetImage(AppImages.secondOnBoardingImage),
              height: 300,
              fit: BoxFit.contain,
            ),
            const Gap(10),
            EasyRichText(
              onBoardingModel.secondOnboardingTitle ?? "",
              defaultStyle: AppTextStyle.textD24B(context),
              textAlign: TextAlign.center,
              patternList: [
                EasyRichTextPattern(
                  targetString:
                      onBoardingModel.secondOnboardingSpecialText ?? "",
                  style: AppTextStyle.textS24B(context),
                ),
              ],
            ),
            const Gap(10),
            Text(
              onBoardingModel.secondOnboardingDescription ?? "",
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
