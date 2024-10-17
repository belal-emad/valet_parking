import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../custom_widgets/api_response_widget/api_response_widget.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/buttons/notification_button.dart';
import '../../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../../custom_widgets/custom_select/custom_select_item.dart';
import '../../../../custom_widgets/custom_select/custom_single_select.dart';
import '../../../../custom_widgets/page_container/page_container.dart';
import '../../../../custom_widgets/validation/validation_mixin.dart';
import '../../../global/auth/controller/auth_controller.dart';

class UserProfileScreen extends StatefulWidget {
  static const String routeName = 'OwnerProfileScreen';
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with ValidationMixin {
  int? _country;
  final _globalKey = GlobalKey<FormState>();
  final _nameEc = TextEditingController();
  final _emailEc = TextEditingController();
  final _phoneEc = TextEditingController();
  @override
  void initState() {
    context.read<AuthController>().initialProfile();
    context.read<AuthController>().getProfile().then(
      (value) {
        _nameEc.text = context.read<AuthController>().profileModel?.name ?? "";
        _phoneEc.text =
            context.read<AuthController>().profileModel?.mobile ?? "";
        _emailEc.text =
            context.read<AuthController>().profileModel?.email ?? "";
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _nameEc.dispose();
    _emailEc.dispose();
    _phoneEc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(builder: (context, authController, _) {
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
            body: ApiResponseWidget(
              apiResponse: authController.profileResponse,
              onReload: () => authController.getProfile(),
              isEmpty: authController.profileModel == null,
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    const Gap(30),
                    CustomFormField(
                      controller: _nameEc,
                      validator: validateName,
                      hintStyle: AppTextStyle.textD14B(context),
                      unFocusColor: AppColor.offWhiteColor(context),
                      fillColor: AppColor.offWhiteColor(context),
                      hintText: tr(AppLocaleKey.name),
                    ),
                    const Gap(15),
                    // CustomFormField(
                    //   hintStyle: AppTextStyle.textD14B(context),
                    //   unFocusColor: AppColor.offWhiteColor(context),
                    //   fillColor: AppColor.offWhiteColor(context),
                    //   hintText: tr(AppLocaleKey.lastName),
                    // ),
                    // const Gap(15),
                    CustomFormField(
                      controller: _emailEc,
                      validator: validateEmail,
                      hintStyle: AppTextStyle.textD14B(context),
                      unFocusColor: AppColor.offWhiteColor(context),
                      fillColor: AppColor.offWhiteColor(context),
                      hintText: tr(AppLocaleKey.email),
                    ),
                    const Gap(15),
                    CustomSingleSelect(
                      value: _country,
                      onChanged: (value) {
                        setState(() {
                          _country = value;
                        });
                      },
                      hintStyle: AppTextStyle.textD14B(context),
                      unFocusColor: AppColor.offWhiteColor(context),
                      fillColor: AppColor.offWhiteColor(context),
                      hintText: tr(AppLocaleKey.country),
                      items: [
                        CustomSelectItem(
                          value: 1,
                          name: 'السعودية',
                        ),
                        CustomSelectItem(
                          value: 2,
                          name: 'الامارات ',
                        ),
                      ],
                    ),
                    const Gap(15),
                    CustomFormField(
                      controller: _phoneEc,
                      validator: validatePhone,
                      hintStyle: AppTextStyle.textD14B(context),
                      fillColor: AppColor.offWhiteColor(context),
                      unFocusColor: AppColor.offWhiteColor(context),
                      hintText: tr(AppLocaleKey.phone),
                    ),
                    const Gap(25),
                    CustomButton(
                      onPressed: () {
                        if (_globalKey.currentState!.validate()) {
                          Navigator.pop(context);
                        }
                      },
                      text: tr(AppLocaleKey.save),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
//  CustomSingleSelect(
