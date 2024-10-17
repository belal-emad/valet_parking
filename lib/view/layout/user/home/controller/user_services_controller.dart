// ignore_for_file: prefer_final_fields

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:valet_parking/helpers/networking/api_helper.dart';
import 'package:valet_parking/helpers/networking/urls.dart';
import 'package:valet_parking/helpers/utils/common_methods.dart';
import 'package:valet_parking/helpers/utils/navigator_methods.dart';
import 'package:valet_parking/view/layout/user/home/model/user_services_model.dart';

class UserServiceController extends ChangeNotifier {
  void initialServices() {
    _servicesResponse = ApiResponse(
      state: ResponseState.sleep,
      data: null,
    );
    _services = [];
    notifyListeners();
  }

  ApiResponse _servicesResponse = ApiResponse(
    state: ResponseState.sleep,
    data: null,
  );
  ApiResponse get servicesResponse => _servicesResponse;

  List<UserServicesModel> _services = [];
  List<UserServicesModel> get services => _services;

  Future<void> getServices() async {
    _servicesResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    _services = [];
    notifyListeners();
    _servicesResponse = await ApiHelper.instance.get(Urls.services);
    notifyListeners();

    if (_servicesResponse.state == ResponseState.complete) {
      Iterable iterable = _servicesResponse.data['data'];
      _services = iterable.map((e) => UserServicesModel.fromJson(e)).toList();
      notifyListeners();
    }
  }

  int _ticketId = 0;
  int get ticketId => _ticketId;
  set setTicketId(int value) {
    _ticketId = value;
    notifyListeners();
  }

  int _serviceId = 0;
  int get serviceId => _serviceId;
  set setServiceId(int value) {
    _serviceId = value;
    notifyListeners();
  }

  // String _note = "";
  // String get note => _note;
  // set setNote(String value) {
  //   _note = value;
  //   notifyListeners();
  // }

  // String _userMobile = "";
  // String get userMobile => _userMobile;
  // set setUserMobile(String value) {
  //   _userMobile = value;
  //   notifyListeners();
  // }

  Future<void> addServices({
    required int ticketId,
    required int serviceId,
    required String note,
    required String userMobile,
    required VoidCallback onSuccess,
  }) async {
    FormData body = FormData.fromMap({
      'ticket_id': ticketId,
      'service_id': serviceId,
      'notes': note,
      'user_mobile': userMobile,
    });
    NavigatorMethods.loading();
    final response = await ApiHelper.instance.post(
      Urls.postService,
      body: body,
    );
    onSuccess.call();
    NavigatorMethods.loadingOff();
    if (response.state == ResponseState.complete) {
      CommonMethods.showToast(message: response.data['message']);
    } else {
      CommonMethods.showError(
        message: response.data['message'],
        apiResponse: response,
      );
    }
  }
}
