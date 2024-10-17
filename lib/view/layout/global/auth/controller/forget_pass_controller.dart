import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../helpers/networking/api_helper.dart';
import '../../../../../helpers/networking/urls.dart';
import '../../../../../helpers/utils/common_methods.dart';
import '../../../../../helpers/utils/navigator_methods.dart';

class ForgetPassController extends ChangeNotifier {
  Future<void> sendSMS({
    required String countryCode,
    required String mobile,
    required void Function(String) onSuccess,
  }) async {
    NavigatorMethods.loading();
    FormData body =
        FormData.fromMap({'country_code': countryCode, 'mobile': mobile});

    final response = await ApiHelper.instance.post(
      Urls.forgetPass,
      body: body,
    );
    NavigatorMethods.loadingOff();
    if (response.state == ResponseState.complete) {
      String code = response.data['data'].toString();
      onSuccess.call(code);
    } else {
      CommonMethods.showError(
        message: response.data['message'],
        apiResponse: response,
      );
    }
  }
}
