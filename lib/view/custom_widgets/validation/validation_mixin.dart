import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../helpers/locale/app_locale_key.dart';

mixin ValidationMixin<T extends StatefulWidget> on State<T> {
  String? validateName(String? value) {
    if (value!.trim().isEmpty) {
      return tr(AppLocaleKey.validateName);
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.trim().isEmpty) {
      return tr(AppLocaleKey.validateEmail);
    } else if (!_emailValidationStructure(value.trim())) {
      return tr(AppLocaleKey.validateEmailStructure);
    }
    return null;
  }

  bool _emailValidationStructure(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  String? validatePhone(String? value, {Country? country}) {
    if (value!.trim().isEmpty) {
      return tr(AppLocaleKey.validatePhone);
    } else if (country != null &&
        (value.trim().length != (country.example.trim().length + 1)) &&
        value.startsWith('0')) {
      return tr(
        AppLocaleKey.validatePhoneContainTenNumbers,
        args: [
          "${country.example.trim().length + 1}",
        ],
      );
    } else if (country != null &&
        (value.trim().length != country.example.trim().length) &&
        !value.startsWith('0')) {
      return tr(
        AppLocaleKey.validatePhoneContainTenNumbers,
        args: [
          country.example.trim().length.toString(),
        ],
      );
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value!.trim().length < 6) {
      return tr(AppLocaleKey.validatePassword);
    }
    return null;
  }

  String _password = '';
  String? validateNewPassword(String? value) {
    _password = value!;
    if (value.trim().length < 6) {
      return tr(AppLocaleKey.validatePassword);
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value!.trim().length < 6) {
      return tr(AppLocaleKey.validatePassword);
    } else if (_password != value) {
      return tr(AppLocaleKey.validateConfirmPassword);
    }
    return null;
  }

  String? validateEmptyField(String? value) {
    if (value!.trim().isEmpty) {
      return tr(AppLocaleKey.validateEmpty);
    }
    return null;
  }

  String? validateEmptySingleSelect(dynamic value) {
    if (value == null) {
      return tr(AppLocaleKey.validateEmpty);
    }
    return null;
  }

  String? validateEmptyMultiSelect(List<dynamic>? value) {
    if (value == null || value.isEmpty) {
      return tr(AppLocaleKey.validateEmpty);
    }
    return null;
  }
}
