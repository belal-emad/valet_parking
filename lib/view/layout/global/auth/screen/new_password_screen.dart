import 'package:easy_localization/easy_localization.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../../custom_widgets/page_container/page_container.dart';
import '../../../../custom_widgets/validation/validation_mixin.dart';

class NewPasswordArgs {
  final String countryCode;
  final String mobile;

  NewPasswordArgs({
    required this.countryCode,
    required this.mobile,
  });
}

class NewPasswordScreen extends StatefulWidget {
  final NewPasswordArgs args;
  const NewPasswordScreen({super.key, required this.args});
  static const String routeName = 'NewPasswordScreen';

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final _passwordEc = TextEditingController();
  final _confirmPasswordEc = TextEditingController();
  @override
  dispose() {
    _passwordEc.dispose();
    _confirmPasswordEc.dispose();
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
                  tr(AppLocaleKey.createNewPassword),
                  defaultStyle: AppTextStyle.textD24B(context),
                  patternList: [
                    EasyRichTextPattern(
                      targetString: 'كلمة مرور جديدة',
                      style: AppTextStyle.textS24B(context),
                    ),
                  ],
                ),
                const Gap(20),
                const Image(
                  image: AssetImage(AppImages.newPasswordImage),
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                const Gap(20),
                CustomFormField(
                  controller: _passwordEc,
                  validator: validatePassword,
                  hintText: tr(AppLocaleKey.newPassword),
                  prefixSvg: AppImages.lockFIcon,
                  isPassword: true,
                ),
                const Gap(20),
                CustomFormField(
                  controller: _confirmPasswordEc,
                  validator: validateConfirmPassword,
                  hintText: tr(AppLocaleKey.confirmPassword),
                  prefixSvg: AppImages.lockFIcon,
                  isPassword: true,
                ),
                const Gap(30),
                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  },
                  text: tr(AppLocaleKey.confirm),
                  style: AppTextStyle.textW16B(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
