import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/buttons/notification_button.dart';
import '../../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../widgets/payment_methods_list.dart';

class UserChoosePaymentMethods extends StatelessWidget {
  static const String routeName = 'UserChoosePaymentMethods';
  const UserChoosePaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        automaticallyImplyLeading: true,
        title: Text(tr(AppLocaleKey.payment)),
        actions: const [
          Center(
            child: NotificationButton(),
          ),
          Gap(10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                const Gap(20),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    tr(AppLocaleKey.choosePaymentMethods),
                    style: AppTextStyle.textD18B(context),
                  ),
                ),
                const Gap(30),
                const PaymentMethodList(),
                const Gap(20),
                CustomButton(
                  color: AppColor.blueColor(context).withOpacity(0.1),
                  text: tr(AppLocaleKey.addNewCard),
                  style: AppTextStyle.textB16B(context),
                  prefixIcon: SvgPicture.asset(AppImages.addBlueIcon),
                  onPressed: () {},
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 100),
                    child: CustomButton(
                      text: tr(AppLocaleKey.next),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
