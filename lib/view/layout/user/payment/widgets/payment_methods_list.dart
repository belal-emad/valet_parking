import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:valet_parking/helpers/images/app_images.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';
import 'package:valet_parking/view/custom_widgets/buttons/custom_button.dart';

import '../../../../../helpers/theme/app_text_style.dart';

class PaymentMethodList extends StatefulWidget {
  const PaymentMethodList({
    super.key,
  });

  @override
  State<PaymentMethodList> createState() => _PaymentMethodListState();
}

class _PaymentMethodListState extends State<PaymentMethodList> {
  List<String> titles = [
    AppLocaleKey.paypal,
    AppLocaleKey.googlePay,
    AppLocaleKey.applePay,
  ];
  List<String> images = [
    AppImages.payPalIcon,
    AppImages.googleIcon,
    AppImages.appleIcon,
  ];
  String? selectedValue;
  int selectedIndex = -1;
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        titles.length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: CustomButton(
            onPressed: () {
              setState(() {
                selectedIndex = index;
                selectedValue = titles[index];
              });
            },
            borderColor: selectedIndex == index
                ? AppColor.blueColor(context)
                : AppColor.whiteColor(context),
            borderWidth: 2,
            radius: 16,
            color: AppColor.whiteColor(context),
            width: double.infinity,
            height: 90,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Radio(
                    value: titles[index],
                    fillColor:
                        MaterialStateProperty.all(AppColor.blueColor(context)),
                    groupValue: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                      });
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        tr(titles[index]),
                        style: AppTextStyle.textD24B(context),
                      ),
                      const Gap(10),
                      SvgPicture.asset(
                        images[index],
                        height: 32,
                      ),
                      const Gap(20),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
