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
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../../custom_widgets/page_container/page_container.dart';
import '../../../../custom_widgets/validation/validation_mixin.dart';
import '../controller/auth_controller.dart';
import '../dialog/congratulations_dialog.dart';
import 'login_screen.dart';

class RegisterArgs {
  final String countryCode;
  final String mobile;

  RegisterArgs({required this.countryCode, required this.mobile});
}

class RegisterScreen extends StatefulWidget {
  final RegisterArgs args;
  const RegisterScreen({super.key, required this.args});
  static const String routeName = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();
  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
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
                const Gap(20),
                EasyRichText(
                  tr(AppLocaleKey.createANewAccount),
                  defaultStyle: AppTextStyle.textD24B(context),
                  patternList: [
                    EasyRichTextPattern(
                      targetString: ' حساب جديد',
                      style: AppTextStyle.textS24B(context),
                    ),
                  ],
                ),
                const Gap(20),
                CustomFormField(
                  controller: _nameEC,
                  hintText: tr(AppLocaleKey.name),
                  prefixSvg: AppImages.nameIcon,
                  keyboardType: TextInputType.name,
                  validator: validateName,
                ),
                const Gap(20),
                CustomFormField(
                  controller: _emailEC,
                  hintText: tr(AppLocaleKey.email),
                  prefixSvg: AppImages.emailIcon,
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                ),
                const Gap(20),
                CustomFormField(
                  controller: _passwordEC,
                  hintText: tr(AppLocaleKey.password),
                  isPassword: true,
                  prefixSvg: AppImages.lockFIcon,
                  keyboardType: TextInputType.visiblePassword,
                  validator: validateNewPassword,
                ),
                const Gap(20),
                CustomFormField(
                  controller: _confirmPasswordEC,
                  hintText: tr(AppLocaleKey.confirmPassword),
                  prefixSvg: AppImages.lockFIcon,
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: true,
                  validator: validateConfirmPassword,
                ),
                const Gap(50),
                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthController>().register(
                            name: _nameEC.text,
                            countryCode: widget.args.countryCode,
                            mobile: widget.args.mobile.removeZero(),
                            email: _emailEC.text,
                            password: _passwordEC.text,
                            confirmPassword: _confirmPasswordEC.text,
                            onSuccess: () {
                              NavigatorMethods.showAppDialog(
                                context,
                                const CongratulationsDialog(),
                                willPop: false,
                              );
                            },
                          );
                    }
                  },
                  text: tr(AppLocaleKey.login),
                ),
                const Gap(30),
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
                    const Expanded(child: Divider()),
                  ],
                ),
                const Gap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      radius: 15,
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
                      radius: 15,
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
                          text: tr(AppLocaleKey.doYouHaveAnAccount),
                          style: TextStyle(
                            color: AppColor.darkTextColor(context),
                          ),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: tr(AppLocaleKey.signIn),
                          style: TextStyle(
                            color: AppColor.secondAppColor(context),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              NavigatorMethods.pushNamedAndRemoveUntil(
                                context,
                                LoginScreen.routeName,
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
