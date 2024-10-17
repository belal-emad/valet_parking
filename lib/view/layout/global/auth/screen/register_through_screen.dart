import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../../helpers/extension/context_extension.dart';
import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../custom_widgets/page_container/page_container.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class RegisterThroughScreen extends StatelessWidget {
  static const String routeName = 'RegisterThroughScreen';
  const RegisterThroughScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      statusBarColor: AppColor.authScaffoldColor(context),
      child: Scaffold(
        backgroundColor: AppColor.authScaffoldColor(context),
        appBar: CustomAppBar(
          appBarColor: AppColor.authScaffoldColor(context),
          context,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(80),
              Text(
                tr(
                  AppLocaleKey.registerThrough,
                ),
                style: AppTextStyle.textD24B(context),
              ),
              const Gap(101),
              CustomButton(
                height: 60,
                style: AppTextStyle.textD16B(context),
                radius: 10,
                borderColor: AppColor.borderColor(context),
                text: tr(AppLocaleKey.loginWithGoogle),
                color: AppColor.whiteColor(context),
                suffixIcon: SvgPicture.asset(AppImages.googleIcon),
              ),
              const Gap(15),
              CustomButton(
                height: 60,
                style: AppTextStyle.textD16B(context),
                radius: 10,
                borderColor: AppColor.borderColor(context),
                text: tr(AppLocaleKey.loginWithApple),
                color: AppColor.whiteColor(context),
                suffixIcon: SvgPicture.asset(AppImages.appleIcon),
              ),
              const Gap(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(child: Divider()),
                  const Gap(5),
                  Text(
                    tr(AppLocaleKey.or),
                    style: AppTextStyle.textL18B(context),
                  ),
                  const Gap(5),
                  const Expanded(child: Divider()),
                ],
              ),
              const Gap(30),
              CustomButton(
                radius: 10,
                onPressed: () {
                  NavigatorMethods.pushNamed(
                    context,
                    LoginScreen.routeName,
                  );
                },
                text: tr(AppLocaleKey.loginUsingPassword),
                style: AppTextStyle.textW16R(context),
              ),
              const Gap(50),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontFamily: context.fontFamily(),
                    ),
                    children: [
                      TextSpan(
                        text: tr(AppLocaleKey.doNotHaveAnAccount),
                        style: TextStyle(
                          color: AppColor.darkTextColor(context),
                        ),
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: tr(AppLocaleKey.createANewAccount),
                        style: TextStyle(
                          color: AppColor.secondAppColor(context),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            NavigatorMethods.pushNamed(
                              context,
                              RegistrationScreen.routeName,
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
