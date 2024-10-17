import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/extension/context_extension.dart';
import '../../../../../helpers/extension/string_extension.dart';
import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/utils/country_code_methods.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../../custom_widgets/page_container/page_container.dart';
import '../../../../custom_widgets/validation/validation_mixin.dart';
import '../../../user/bottom_navigation/bottom_navigation_screen.dart';
import '../../../worker/bottom_navigation/worker_bottom_navigation_bar_screen.dart';
import '../controller/auth_controller.dart';
import 'forgot_password_screen.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixin {
  bool _rememberMe = false;
  final _formKey = GlobalKey<FormState>();
  final _mobileEC = TextEditingController();
  final _passwordEC = TextEditingController();
  late Country _country;

  @override
  void initState() {
    _country = CountryCodeMethods.getByCode('966');
    super.initState();
  }

  @override
  void dispose() {
    _mobileEC.dispose();
    _passwordEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      statusBarColor: AppColor.authScaffoldColor(context),
      child: Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: AppColor.authScaffoldColor(context),
          appBar: CustomAppBar(
            context,
            appBarColor: AppColor.authScaffoldColor(context),
            automaticallyImplyLeading: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EasyRichText(
                  tr(AppLocaleKey.loginToYourAccount),
                  defaultStyle: AppTextStyle.textD24B(context),
                  patternList: [
                    EasyRichTextPattern(
                      targetString: 'لحسابك',
                      style: AppTextStyle.textS24B(context),
                    ),
                  ],
                ),
                const Gap(85),
                CustomFormField(
                  keyboardType: TextInputType.phone,
                  controller: _mobileEC,
                  //validator: (v) => validatePhone(v, country: _country),
                  hintText: tr(AppLocaleKey.phone),
                  prefixSvg: AppImages.phoneIcon,
                  country: _country,
                ),
                const Gap(25),
                CustomFormField(
                  controller: _passwordEC,
                  validator: validatePassword,
                  hintText: tr(AppLocaleKey.password),
                  prefixSvg: AppImages.lockFIcon,
                  isPassword: true,
                ),
                const Gap(20),
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      activeColor: AppColor.secondAppColor(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      onChanged: (v) {
                        setState(() {
                          _rememberMe = !_rememberMe;
                        });
                      },
                    ),
                    Text(
                      tr(AppLocaleKey.rememberMe),
                      style: AppTextStyle.textD14B(context),
                    ),
                  ],
                ),
                const Gap(25),
                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthController>().login(
                            countryCode: _country.phoneCode,
                            mobile: _mobileEC.text.removeZero(),
                            password: _passwordEC.text,
                            rememberMe: _rememberMe,
                            onSuccess: () {
                              if (context
                                      .read<AuthController>()
                                      .profileModel
                                      ?.accountType ==
                                  'user') {
                                NavigatorMethods.pushNamedAndRemoveUntil(
                                  context,
                                  UserBottomNavigationScreen.routeName,
                                );
                              } else {
                                NavigatorMethods.pushNamedAndRemoveUntil(
                                  context,
                                  WorkerBottomNavigationBarScreen.routeName,
                                );
                              }
                            },
                          );
                    }
                  },
                  text: tr(AppLocaleKey.login),
                  style: AppTextStyle.textW16B(context),
                ),
                const Gap(20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      NavigatorMethods.pushNamed(
                          context, ForgotPasswordScreen.routeName);
                    },
                    child: Text(
                      tr(AppLocaleKey.didYouForgetYourPassword),
                      style: AppTextStyle.textM16R(context),
                    ),
                  ),
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: Divider()),
                    const Gap(5),
                    Text(
                      tr(AppLocaleKey.orLoginVia),
                      style: AppTextStyle.textL18B(context),
                    ),
                    const Gap(5),
                    const Expanded(
                      child: Divider(),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      radius: 16,
                      height: 60,
                      width: 88,
                      borderColor: AppColor.borderColor(context),
                      color: AppColor.whiteColor(context),
                      child: SvgPicture.asset(
                        AppImages.appleIcon,
                        width: 24,
                      ),
                    ),
                    const Gap(15),
                    CustomButton(
                      radius: 16,
                      height: 60,
                      width: 88,
                      borderColor: AppColor.borderColor(context),
                      color: AppColor.whiteColor(context),
                      child: SvgPicture.asset(
                        AppImages.googleIcon,
                        width: 24,
                      ),
                    ),
                  ],
                ),
                const Gap(30),
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
      ),
    );
  }
}
