import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/extension/context_extension.dart';
import '../../../../../helpers/hive/hive_methods.dart';
import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/page_container/page_container.dart';
import '../controller/on_boarding_controller.dart';
import 'on_boarding_screen.dart';

class ChooseLangScreen extends StatelessWidget {
  const ChooseLangScreen({super.key});

  static const String routeName = 'ChooseLangScreen';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OnBoardingController>(
      create: (context) => OnBoardingController(),
      builder: (context, child) {
        return PageContainer(
          statusBarColor: AppColor.authScaffoldColor(context),
          child: Scaffold(
            backgroundColor: AppColor.authScaffoldColor(context),
            body: Center(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    Image(
                      image: const AssetImage(AppImages.appImage),
                      width: context.width(),
                      fit: BoxFit.contain,
                    ),
                    const Gap(60),
                    CustomButton(
                      text: 'العربية',
                      onPressed: () {
                        context.setLocale(const Locale("ar"));
                        HiveMethods.updateLang(const Locale("ar"));
                        context.read<OnBoardingController>().getOnBoarding(
                            onSuccess: (v) {
                          NavigatorMethods.pushNamedAndRemoveUntil(
                            context,
                            OnBoardingScreen.routeName,
                            arguments: OnBoardingArgs(onBoardingModel: v),
                          );
                        });
                      },
                    ),
                    const Gap(15),
                    CustomButton(
                      color: AppColor.offWhiteColor(context),
                      style: AppTextStyle.buttonStyle(context).copyWith(
                        color: AppColor.mainAppColor(context),
                      ),
                      text: 'English',
                      onPressed: () {
                        context.setLocale(const Locale("en"));
                        HiveMethods.updateLang(const Locale("en"));
                        context.read<OnBoardingController>().getOnBoarding(
                            onSuccess: (v) {
                          NavigatorMethods.pushNamedAndRemoveUntil(
                            context,
                            OnBoardingScreen.routeName,
                            arguments: OnBoardingArgs(onBoardingModel: v),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
