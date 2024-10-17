import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../helpers/hive/hive_methods.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../../../model/on_boarding_model.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/page_container/page_container.dart';
import '../../auth/screen/register_through_screen.dart';
import '../tab/f_on_boarding_tab.dart';
import '../tab/s_on_boarding_tab.dart';
import '../tab/th_on_boarding_tab.dart';

class OnBoardingArgs {
  final OnBoardingModel onBoardingModel;

  OnBoardingArgs({required this.onBoardingModel});
}

class OnBoardingScreen extends StatefulWidget {
  final OnBoardingArgs args;
  const OnBoardingScreen({super.key, required this.args});

  static const String routeName = 'OnBoardingScreen';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController controller;
  @override
  void initState() {
    controller = PageController();
    HiveMethods.updateFirstTime();
    super.initState();
  }

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      statusBarColor: AppColor.authScaffoldColor(context),
      child: Scaffold(
        backgroundColor: AppColor.authScaffoldColor(context),
        body: PageView(
          controller: controller,
          children: [
            FOnBoardingTab(
              onBoardingModel: widget.args.onBoardingModel,
            ),
            SOnBoardingTab(
              onBoardingModel: widget.args.onBoardingModel,
            ),
            ThOnBoardingTab(
              onBoardingModel: widget.args.onBoardingModel,
            ),
          ],
          onPageChanged: (v) {
            setState(() {
              _index = v;
              log('$_index');
            });
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SmoothPageIndicator(
                controller: controller,
                count: 3,
                axisDirection: Axis.horizontal,
                effect: ExpandingDotsEffect(
                  radius: 5.0,
                  dotWidth: 10.0,
                  dotHeight: 10.0,
                  dotColor: Colors.grey.shade200,
                  activeDotColor: AppColor.mainAppColor(context),
                ),
              ),
              const Gap(10),
              CustomButton(
                text: tr(AppLocaleKey.next),
                onPressed: () {
                  if (_index < 2) {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.linear,
                    );
                  } else {
                    NavigatorMethods.pushNamedAndRemoveUntil(
                      context,
                      RegisterThroughScreen.routeName,
                    );
                  }
                },
              ),
              const Gap(10),
              CustomButton(
                color: AppColor.whiteColor(context),
                borderColor: AppColor.mainAppColor(context),
                style: AppTextStyle.buttonStyle(context).copyWith(
                  color: AppColor.mainAppColor(context),
                ),
                text: tr(AppLocaleKey.skip),
                onPressed: () {
                  NavigatorMethods.pushNamedAndRemoveUntil(
                    context,
                    RegisterThroughScreen.routeName,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
