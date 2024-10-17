import 'package:flutter/material.dart';

import '../extension/context_extension.dart';
import 'app_colors.dart';

class AppTextStyle {
  AppTextStyle(TextStyle textD14R);

  static TextStyle appBarStyle(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColor.appBarTextColor(context, listen: listen),
      fontFamily: context.fontFamily(),
    );
  }

  static TextStyle buttonStyle(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: AppColor.buttonTextColor(context, listen: listen),
    );
  }

  static TextStyle hintStyle(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.hintColor(context, listen: listen),
    );
  }

  static TextStyle textFormStyle(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.textFormColor(context, listen: listen),
    );
  }

  static TextStyle formTitleStyle(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColor.whiteColor(context, listen: listen),
    );
  }

  static TextStyle textW20B(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: AppColor.whiteColor(context, listen: listen),
    );
  }

  static TextStyle textW18B(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: AppColor.whiteColor(context, listen: listen),
    );
  }

  static TextStyle textW16B(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColor.whiteColor(context, listen: listen),
    );
  }

  static TextStyle bottomNavigationStyle(BuildContext context,
      {bool listen = true}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.whiteColor(context, listen: listen),
    );
  }

  static TextStyle textD24B(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: AppColor.darkTextColor(context, listen: listen),
    );
  }

  static TextStyle textS24B(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: AppColor.secondAppColor(context, listen: listen),
    );
  }

  static TextStyle textS18B(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColor.secondAppColor(context, listen: listen),
    );
  }

  static TextStyle textL16R(BuildContext context,
      {bool listen = true, double? height}) {
    return TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColor.lightTextColor(context, listen: listen),
        height: height ?? 0.0);
  }

  static TextStyle textL14R(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.lightTextColor(context, listen: listen),
    );
  }

  static TextStyle textL14B(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: AppColor.lightTextColor(context, listen: listen),
    );
  }

  static TextStyle textM16R(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColor.mainAppColor(context, listen: listen),
    );
  }

  static TextStyle textM20R(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColor.mainAppColor(context, listen: listen),
    );
  }

  static TextStyle textD14B(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: AppColor.darkTextColor(context, listen: listen),
    );
  }

  static TextStyle textD16B(BuildContext context,
      {bool listen = true, double? height}) {
    return TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColor.darkTextColor(context, listen: listen),
        height: height ?? 0.0);
  }

  static TextStyle textD18B(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: AppColor.darkTextColor(context, listen: listen),
    );
  }

  static TextStyle textL18B(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: AppColor.lightTextColor(context, listen: listen),
    );
  }

  static TextStyle textD16R(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColor.darkTextColor(context, listen: listen),
    );
  }

  static TextStyle textD16S(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColor.darkTextColor(context, listen: listen),
    );
  }

  static TextStyle textS14B(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: AppColor.secondAppColor(context, listen: listen),
    );
  }

  static TextStyle textD18R(BuildContext context,
      {bool listen = true, double? height}) {
    return TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColor.darkTextColor(context, listen: listen),
        height: height ?? 0.0);
  }

  static TextStyle textM16B(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: AppColor.mainAppColor(context, listen: listen),
    );
  }

  static TextStyle textM32B(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: AppColor.mainAppColor(context, listen: listen),
    );
  }

  static TextStyle textB16B(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: AppColor.blueColor(context, listen: listen),
    );
  }

  static TextStyle textR18R(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColor.redColor(context, listen: listen),
    );
  }

  static TextStyle textW16R(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColor.whiteColor(context, listen: listen),
    );
  }

  static TextStyle textG14B(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: AppColor.greenColor(context, listen: listen),
    );
  }

  static TextStyle textG20B(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColor.greenColor(context, listen: listen),
    );
  }

  static TextStyle textS20B(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColor.secondAppColor(context, listen: listen),
    );
  }

  static TextStyle textD14R(BuildContext context,
      {bool listen = true, double? height}) {
    return TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColor.darkTextColor(context, listen: listen),
        height: height ?? 0.0);
  }

  static TextStyle textD20B(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColor.darkTextColor(context, listen: listen),
    );
  }
}
