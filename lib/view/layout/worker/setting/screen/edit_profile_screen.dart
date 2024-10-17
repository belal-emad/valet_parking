import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/view/custom_widgets/buttons/custom_button.dart';
import 'package:valet_parking/view/custom_widgets/buttons/notification_button.dart';
import 'package:valet_parking/view/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:valet_parking/view/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:valet_parking/view/custom_widgets/page_container/page_container.dart';
import 'package:valet_parking/view/custom_widgets/validation/validation_mixin.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = 'EditProfileScreen';
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with ValidationMixin {
  final _globalKey = GlobalKey<FormState>();
  final _firstNameEc = TextEditingController();
  final _lastNameEc = TextEditingController();
  final _emailEc = TextEditingController();
  final _phoneEc = TextEditingController();
  @override
  void dispose() {
    _firstNameEc.dispose();
    _lastNameEc.dispose();
    _emailEc.dispose();
    _phoneEc.dispose();
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
              tr(AppLocaleKey.editProfile),
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
                  validator: validateName,
                  controller: _firstNameEc,
                  hintStyle: AppTextStyle.textD14B(context),
                  fillColor: AppColor.whiteFcColor(context),
                  hintText: tr(AppLocaleKey.firstName),
                ),
                const Gap(25),
                CustomFormField(
                  validator: validateName,
                  controller: _lastNameEc,
                  hintStyle: AppTextStyle.textD14B(context),
                  fillColor: AppColor.whiteFcColor(context),
                  hintText: tr(AppLocaleKey.lastName),
                ),
                const Gap(25),
                CustomFormField(
                  validator: validateEmail,
                  controller: _emailEc,
                  hintStyle: AppTextStyle.textD14B(context),
                  fillColor: AppColor.whiteFcColor(context),
                  hintText: 'Email@gmail.com',
                ),
                const Gap(25),
                CustomFormField(
                  keyboardType: TextInputType.phone,
                  validator: validatePhone,
                  controller: _phoneEc,
                  hintStyle: AppTextStyle.textD14B(context),
                  fillColor: AppColor.whiteFcColor(context),
                  hintText: tr(AppLocaleKey.phone),
                ),
                const Gap(25),
                CustomButton(
                  onPressed: () {
                    if (_globalKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  },
                  gradient: LinearGradient(
                    colors: [
                      AppColor.grid1Color(context),
                      AppColor.grid2Color(context),
                    ],
                  ),
                  radius: 10,
                  text: tr(AppLocaleKey.save),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
