import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/extension/string_extension.dart';
import 'package:valet_parking/view/custom_widgets/validation/validation_mixin.dart';
import 'package:valet_parking/view/layout/global/auth/controller/auth_controller.dart';

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
import 'registration_otp_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = 'RegistrationScreen';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final _mobileEC = TextEditingController();
  late Country _country;
  @override
  void initState() {
    _country = CountryCodeMethods.getByCode('966');
    super.initState();
  }

  @override
  void dispose() {
    _mobileEC.dispose();
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
                      targetString: 'حساب جديد',
                      style: AppTextStyle.textS24B(context),
                    ),
                  ],
                ),
                const Gap(28),
                Text(
                  tr(
                    AppLocaleKey
                        .enterYourMobileNumberAndACodeWillBeSentInATextMessage,
                  ),
                  style: AppTextStyle.textD18R(context),
                ),
                const Gap(20),
                CustomFormField(
                  controller: _mobileEC,
                  keyboardType: TextInputType.phone,
                  hintText: tr(AppLocaleKey.phone),
                  prefixSvg: AppImages.phoneIcon,
                  country: _country,
                  validator: (v) => validatePhone(v, country: _country),
                ),
                const Gap(50),
                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthController>().sendSMS(
                            countryCode: _country.phoneCode,
                            mobile: _mobileEC.text.removeZero(),
                            onSuccess: (v) {
                              NavigatorMethods.pushReplacementNamed(
                                context,
                                RegistrationOtpScreen.routeName,
                                arguments: RegistrationOtpArgs(
                                  countryCode: _country.phoneCode,
                                  mobile: _mobileEC.text.removeZero(),
                                  code: v,
                                ),
                              );
                            },
                          );
                    }
                  },
                  text: tr(AppLocaleKey.next),
                  style: AppTextStyle.textW16B(context),
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
                    const Expanded(child: Divider()),
                  ],
                ),
                const Gap(20),
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
                    const Gap(15),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
