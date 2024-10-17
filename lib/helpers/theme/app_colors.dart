import 'package:flutter/material.dart';

import 'app_theme.dart';

class AppColor {
  static Color mainAppColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff0A59A1),
      dark: const Color(0xff0A59A1),
      listen: listen,
    );
  }

  static Color grid1Color(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff021B8C),
      dark: const Color(0xff021B8C),
      listen: listen,
    );
  }

  static Color grid2Color(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff15AFF7),
      dark: const Color(0xff15AFF7),
      listen: listen,
    );
  }

  static Color secondAppColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffFE8B0A),
      dark: const Color(0xffFE8B0A),
      listen: listen,
    );
  }

  static Color borderColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffCCCCCC),
      dark: const Color(0xffCCCCCC),
      listen: listen,
    );
  }

  static Color scaffoldColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffF8F7FD),
      dark: const Color(0xffF8F7FD),
      listen: listen,
    );
  }

  static Color authScaffoldColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffFFFFFF),
      dark: const Color(0xffFFFFFF),
      listen: listen,
    );
  }

  static Color hintColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff9E9E9E),
      dark: const Color(0xff9E9E9E),
      listen: listen,
    );
  }

  static Color darkTextColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff212121),
      dark: const Color(0xff212121),
      listen: listen,
    );
  }

  static Color lightTextColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff757F8C),
      dark: const Color(0xff757F8C),
      listen: listen,
    );
  }

  static Color pinkColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFFCE4C4C),
      dark: const Color(0xFFCE4C4C),
      listen: listen,
    );
  }

  static Color greyColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffBCBCBC),
      dark: const Color(0xffBCBCBC),
      listen: listen,
    );
  }

  static Color darkGreyColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff828282),
      dark: const Color(0xff828282),
      listen: listen,
    );
  }

  static Color lightGreyColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffECECEC),
      dark: const Color(0xffECECEC),
      listen: listen,
    );
  }

  static Color lightGreenColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffF3F6FF),
      dark: const Color(0xffF3F6FF),
      listen: listen,
    );
  }

  static Color redColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffF75555),
      dark: const Color(0xffF75555),
      listen: listen,
    );
  }

  static Color greenColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff00C853),
      dark: const Color(0xff00C853),
      listen: listen,
    );
  }

  static Color blackColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff000000),
      dark: const Color(0xff000000),
      listen: listen,
    );
  }

  static Color whiteColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffffffff),
      dark: const Color(0xffffffff),
      listen: listen,
    );
  }

  static Color whiteFcColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffFCFCFF),
      dark: const Color(0xffFCFCFF),
      listen: listen,
    );
  }

  static Color offWhiteColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffFAFAFA),
      dark: const Color(0xffFAFAFA),
      listen: listen,
    );
  }

  static Color textFormFillColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFFE6ECFB),
      dark: const Color(0xFFE6ECFB),
      listen: listen,
    );
  }

  static Color textFormBorderColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFFFFFFFF),
      dark: const Color(0xFFFFFFFF),
      listen: listen,
    );
  }

  static Color yellowColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffFFCC00),
      dark: const Color(0xffFFCC00),
      listen: listen,
    );
  }

  static Color blueColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff007FB1),
      dark: const Color(0xff007FB1),
      listen: listen,
    );
  }

  static Color textFormColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff7C7C7C),
      dark: const Color(0xff7C7C7C),
      listen: listen,
    );
  }

  static Color popupColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffffffff),
      dark: const Color(0xffffffff),
      listen: listen,
    );
  }

  static Color appBarTextColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff000000),
      dark: const Color(0xff000000),
      listen: listen,
    );
  }

  static Color appBarColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffF8F7FD),
      dark: const Color(0xffF8F7FD),
      listen: listen,
    );
  }

  static Color buttonTextColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffffffff),
      dark: const Color(0xffffffff),
      listen: listen,
    );
  }

  static Color inActiveColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFF858585),
      dark: const Color(0xFF858585),
      listen: listen,
    );
  }

  static Color searchField(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffF3F6F8),
      dark: const Color(0xffF3F6F8),
    );
  }
}
