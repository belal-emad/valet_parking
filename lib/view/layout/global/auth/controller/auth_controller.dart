import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../helpers/hive/hive_methods.dart';
import '../../../../../helpers/networking/api_helper.dart';
import '../../../../../helpers/networking/urls.dart';
import '../../../../../helpers/utils/common_methods.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../../../model/profile_model.dart';

class AuthController extends ChangeNotifier {
  void initialProfile({bool listen = false}) {
    _profileResponse = ApiResponse(
      state: ResponseState.sleep,
      data: null,
    );
    _profileModel = null;
    if (listen) notifyListeners();
  }

  ApiResponse _profileResponse = ApiResponse(
    state: ResponseState.sleep,
    data: null,
  );
  ApiResponse get profileResponse => _profileResponse;

  ProfileModel? _profileModel;
  ProfileModel? get profileModel => _profileModel;

  Future<void> getProfile({
    VoidCallback? onSuccess,
    VoidCallback? onUnauthorized,
  }) async {
    _profileResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    notifyListeners();

    _profileResponse = await ApiHelper.instance.get(Urls.profile);
    notifyListeners();

    if (_profileResponse.state == ResponseState.complete) {
      _profileModel = ProfileModel.fromJson(_profileResponse.data['data']);
      notifyListeners();
      onSuccess?.call();
    } else if (_profileResponse.state == ResponseState.unauthorized) {
      _profileModel = null;
      token = null;
      HiveMethods.deleteToken();
      notifyListeners();
      onUnauthorized?.call();
    }
  }

  Future<void> login({
    required String countryCode,
    required String mobile,
    required String password,
    required bool rememberMe,
    required VoidCallback onSuccess,
  }) async {
    NavigatorMethods.loading();
    FormData body = FormData.fromMap(
        {'country_code': countryCode, 'mobile': mobile, 'password': password});

    final response = await ApiHelper.instance.post(
      Urls.login,
      body: body,
    );
    NavigatorMethods.loadingOff();
    if (response.state == ResponseState.complete) {
      _profileModel = ProfileModel.fromJson(response.data['data']);
      token = 'Bearer ${response.data['data']['token']}';
      notifyListeners();
      if (rememberMe) {
        HiveMethods.updateToken(response.data['data']['token']);
      }
      onSuccess.call();
    } else {
      CommonMethods.showError(
        message: response.data['message'],
        apiResponse: response,
      );
    }
  }

  Future<void> logout({required VoidCallback onSuccess}) async {
    NavigatorMethods.loading();
    await ApiHelper.instance.post(Urls.logout);
    _profileModel = null;
    token = null;
    HiveMethods.deleteToken();
    notifyListeners();
    NavigatorMethods.loadingOff();
    onSuccess.call();
  }

  Future<void> sendSMS({
    required String countryCode,
    required String mobile,
    required void Function(String) onSuccess,
  }) async {
    NavigatorMethods.loading();
    FormData body =
        FormData.fromMap({'country_code': countryCode, 'mobile': mobile});

    final response = await ApiHelper.instance.post(
      Urls.registerSMS,
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

  Future<void> register({
    required String name,
    required String countryCode,
    required String mobile,
    required String email,
    required String password,
    required String confirmPassword,
    required VoidCallback onSuccess,
  }) async {
    NavigatorMethods.loading();
    FormData body = FormData.fromMap({
      'name': name,
      'country_code': countryCode,
      'mobile': mobile,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
      'account_type': 'user'
    });

    final response = await ApiHelper.instance.post(
      Urls.register,
      body: body,
    );

    NavigatorMethods.loadingOff();
    if (response.state == ResponseState.complete) {
      _profileModel = ProfileModel.fromJson(response.data['data']);
      token = 'Bearer ${response.data['data']['token']}';
      notifyListeners();
      HiveMethods.updateToken(response.data['data']['token']);
      onSuccess.call();
    } else {
      CommonMethods.showError(
        message: response.data['message'],
        apiResponse: response,
      );
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
    required VoidCallback onSuccess,
  }) async {
    NavigatorMethods.loading();
    FormData body = FormData.fromMap({
      'current_password': currentPassword,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });
    final response = await ApiHelper.instance.post(
      Urls.changePassword,
      body: body,
    );
    NavigatorMethods.loadingOff();
    if (response.state == ResponseState.complete) {
      CommonMethods.showToast(message: response.data['message']);
      onSuccess.call();
    } else {
      CommonMethods.showError(
        message: response.data['message'],
        apiResponse: response,
      );
    }
  }

  Future<void>changeWorkerOnlineOrNot()async{
final response=await ApiHelper.instance.post(Urls.valetOnline);
NavigatorMethods.loadingOff();
 if(response.state==ResponseState.complete){
  CommonMethods.showToast(message:response.data['message']);

 }else{
  CommonMethods.showError(message: response.data['message'],apiResponse: response);
 }
  }
}
