import 'package:flutter/material.dart';

import '../extension/context_extension.dart';
import 'app_colors.dart';
import 'app_text_style.dart';
import 'app_theme.dart';

ThemeData appThemeData(BuildContext context) {
  return ThemeData(
    primaryColor: AppColor.mainAppColor(context),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: false,
    hintColor: AppColor.hintColor(context),
    brightness: AppTheme.getByTheme(
      context,
      light: Brightness.light,
      dark: Brightness.dark,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColor.mainAppColor(context),
      alignedDropdown: true,
    ),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColor.mainAppColor(context),
      secondary: AppColor.secondAppColor(context),
      background: AppColor.whiteColor(context),
      brightness: AppTheme.getByTheme(
        context,
        light: Brightness.light,
        dark: Brightness.dark,
      ),
    ),
    appBarTheme: AppBarTheme(
      color: AppColor.secondAppColor(context),
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTextStyle.appBarStyle(context),
      foregroundColor: AppColor.appBarTextColor(context),
    ),
    scaffoldBackgroundColor: AppColor.scaffoldColor(context),
    fontFamily: context.fontFamily(),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColor.mainAppColor(context),
    ),
    platform: TargetPlatform.iOS,
  );
}

List<BoxShadow> appShadow = [
  BoxShadow(
    offset: const Offset(0, 0),
    blurRadius: 13,
    color: Colors.black.withOpacity(0.1),
  ),
];
