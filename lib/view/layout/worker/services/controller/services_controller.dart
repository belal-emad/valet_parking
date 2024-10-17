import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:valet_parking/helpers/networking/api_helper.dart';
import 'package:valet_parking/helpers/networking/urls.dart';
import 'package:valet_parking/helpers/utils/common_methods.dart';
import 'package:valet_parking/helpers/utils/navigator_methods.dart';
import 'package:valet_parking/view/layout/worker/services/model/services_model.dart';
import 'package:valet_parking/view/layout/worker/services/model/services_details_model.dart';

class ServicesController extends ChangeNotifier {
  Future<void> addNewRequestServices({
    required int ticketId,
    required int serviceId,
    required String notes,
    required String userMobile,
    required VoidCallback onSuccess,
  }) async {
    NavigatorMethods.loading();
    FormData body = FormData.fromMap({
      'ticket_id': ticketId,
      'service_id': serviceId,
      'notes': notes,
      'user_mobile': userMobile,
    });
    final response = await ApiHelper.instance.post(
      Urls.requestServices,
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

  int _tiketId = 0;
  int get ticketId => _tiketId;
  set setTicketId(int value) {
    _tiketId = value;
    notifyListeners();
  }

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

  List<ServicesModel> _services = [];
  List<ServicesModel> get services => _services;

  Future<void> getServices({String? status}) async {
    _servicesResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    _services = [];
    notifyListeners();

    _servicesResponse = await ApiHelper.instance.get(
      Urls.pendingServices,
      queryParameters: {
        'status': status,
      },
    );
    notifyListeners();

    if (_servicesResponse.state == ResponseState.complete) {
      Iterable iterable = _servicesResponse.data['data'];
      _services = iterable.map((e) => ServicesModel.fromJson(e)).toList();
      notifyListeners();
    }
  }

/////////////////////////////////////////////////////////////

  void initialServiceDetails() {
    _serviceDetailsResponse = ApiResponse(
      state: ResponseState.sleep,
      data: null,
    );
    _serviceDetails = [];
    notifyListeners();
  }

  ApiResponse _serviceDetailsResponse = ApiResponse(
    state: ResponseState.sleep,
    data: null,
  );
  ApiResponse get serviceDetailsResponse => _serviceDetailsResponse;
  List<ServicesDetailsModel> _serviceDetails = [];
  List<ServicesDetailsModel> get serviceDetails => _serviceDetails;

  Future<void> getServiceDetails({required int id}) async {
    _serviceDetailsResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    _serviceDetails = [];
    notifyListeners();

    _serviceDetailsResponse =
        await ApiHelper.instance.get("${Urls.servicesDetails}$id");
    notifyListeners();
    if (_serviceDetailsResponse.state == ResponseState.complete) {
      Iterable iterable = _serviceDetailsResponse.data['data'];
      _serviceDetails =
          iterable.map((e) => ServicesDetailsModel.fromJson(e)).toList();
      notifyListeners();
    }
  }
}
