import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../theme/app_text_style.dart';

import '../theme/app_colors.dart';

class CountryCodeMethods {
  static Country getByCode(String code) {
    return CountryParser.parsePhoneCode(code);
  }

  static void pickCountry({
    required void Function(Country) onSelect,
    required BuildContext context,
  }) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: AppTextStyle.textFormStyle(context, listen: false),
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.7,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        inputDecoration: InputDecoration(
          hintText: tr('search'),
          hintStyle: AppTextStyle.hintStyle(context, listen: false),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: AppColor.borderColor(context, listen: false)),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: AppColor.borderColor(context, listen: false)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: AppColor.mainAppColor(context, listen: false)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: AppColor.borderColor(context, listen: false)),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        ),
      ),
      onSelect: onSelect,
    );
  }
}
