import 'package:flutter/material.dart';

import '../../../../../helpers/networking/api_helper.dart';
import '../../../../../helpers/networking/urls.dart';
import '../../../../../helpers/utils/common_methods.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../../../model/on_boarding_model.dart';

class OnBoardingController extends ChangeNotifier {
  Future<void> getOnBoarding(
      {required void Function(OnBoardingModel) onSuccess}) async {
    NavigatorMethods.loading();
    final response = await ApiHelper.instance.get(Urls.onBoarding);
    NavigatorMethods.loadingOff();

    if (response.state == ResponseState.complete) {
      OnBoardingModel onBoardingModel =
          OnBoardingModel.fromJson(response.data['data']);
      onSuccess.call(onBoardingModel);
    } else {
      CommonMethods.showError(
        message: response.data['message'],
        apiResponse: response,
      );
    }
  }
}
