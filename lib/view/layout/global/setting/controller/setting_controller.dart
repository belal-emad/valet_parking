import 'package:flutter/material.dart';
import 'package:valet_parking/helpers/networking/api_helper.dart';
import 'package:valet_parking/helpers/networking/urls.dart';
import 'package:valet_parking/view/layout/global/setting/model/setting_model.dart';

class SettingController extends ChangeNotifier {
  void initialPrivacy() {
    _privacyResponse = ApiResponse(
      state: ResponseState.sleep,
      data: null,
    );
    _privacy = null;
    notifyListeners();
  }

  ApiResponse _privacyResponse = ApiResponse(
    state: ResponseState.sleep,
    data: null,
  );
  ApiResponse get privacyResponse => _privacyResponse;

  SettingModel? _privacy;
  SettingModel? get privacy => _privacy;

  Future<void> getPrivacy() async {
    _privacyResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    _privacy = null;
    notifyListeners();
    _privacyResponse = await ApiHelper.instance.get(Urls.setting);
    notifyListeners();
    if (_privacyResponse.state == ResponseState.complete) {
      _privacy = SettingModel.fromJson(_privacyResponse.data['data']);
      notifyListeners();
    }
  }
}
