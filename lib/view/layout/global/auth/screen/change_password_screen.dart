import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/buttons/notification_button.dart';
import '../../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../../custom_widgets/page_container/page_container.dart';
import '../../../../custom_widgets/validation/validation_mixin.dart';
import '../controller/auth_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});
  static const String routeName = 'ChangePasswordScreen';
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with ValidationMixin {
  final _globalKey = GlobalKey<FormState>();
  final _currentPassword = TextEditingController();
  final _modifyPassword = TextEditingController();
  final _retypeThePassword = TextEditingController();
  @override
  void dispose() {
    _currentPassword.dispose();
    _modifyPassword.dispose();
    _retypeThePassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Form(
        key: _globalKey,
        child: Scaffold(
          appBar: CustomAppBar(
            context,
            automaticallyImplyLeading: true,
            title: Text(
              tr(AppLocaleKey.modifyPassword),
            ),
            actions: const [
              Center(child: NotificationButton()),
              Gap(20),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                const Gap(60),
                CustomFormField(
                  validator: validatePassword,
                  isPassword: true,
                  controller: _currentPassword,
                  hintStyle: AppTextStyle.textD14B(context),
                  fillColor: Colors.white.withOpacity(0.100),
                  formFieldBorder: FormFieldBorder.none,
                  hintText: tr(AppLocaleKey.currentPassword),
                ),
                const Gap(25),
                CustomFormField(
                  validator: validatePassword,
                  isPassword: true,
                  controller: _modifyPassword,
                  hintStyle: AppTextStyle.textD14B(context),
                  fillColor: Colors.white.withOpacity(0.100),
                  formFieldBorder: FormFieldBorder.none,
                  hintText: tr(AppLocaleKey.modifyPassword),
                ),
                const Gap(25),
                CustomFormField(
                  validator: validateNewPassword,
                  isPassword: true,
                  controller: _retypeThePassword,
                  hintStyle: AppTextStyle.textD14B(context),
                  fillColor: Colors.white.withOpacity(0.100),
                  formFieldBorder: FormFieldBorder.none,
                  hintText: tr(AppLocaleKey.retypeThePassword),
                ),
                const Gap(25),
                CustomButton(
                  onPressed: () {
                    if (_globalKey.currentState!.validate()) {
                      context.read<AuthController>().changePassword(
                            currentPassword: _currentPassword.text,
                            password: _modifyPassword.text,
                            passwordConfirmation: _retypeThePassword.text,
                            onSuccess: () {
                              Navigator.pop(context);
                            },
                          );
                    }
                  },
                  text: tr(AppLocaleKey.save),
                  gradient: LinearGradient(
                    colors: [
                      AppColor.grid1Color(context),
                      AppColor.grid2Color(context),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
