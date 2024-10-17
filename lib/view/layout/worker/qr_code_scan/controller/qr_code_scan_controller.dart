import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../../../../../helpers/networking/api_helper.dart';
import '../../../../../helpers/networking/urls.dart';
import '../../../../../helpers/utils/common_methods.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../services/model/services_model.dart';
import '../model/valid_scan_code_model.dart';

class QrCodeScanController extends ChangeNotifier {
  Future<void> entryCodeNewCar({
    required int ticketId,
    String? notes,
    List<File>? images,
    required VoidCallback onSuccess,
  }) async {
    NavigatorMethods.loading();
    FormData body = FormData.fromMap({
      'ticket_id': ticketId,
      'notes': notes,
      if (images != null) ...{
        for (int i = 0; i < images.length; i++) ...{
          'user_images[$i]': await MultipartFile.fromFile(
            images[i].absolute.path,
            filename: basename(images[i].path),
          )
        }
      }
    });
    final response =
        await ApiHelper.instance.post(Urls.entryCodeNewCar, body: body);
    NavigatorMethods.loadingOff();
    if (response.state == ResponseState.complete) {
      CommonMethods.showToast(message: response.data['message']);
      onSuccess.call();
    } else {
      CommonMethods.showError(
          message: response.data['message'], apiResponse: response);
    }
  }

  Future<void> exitCodeDeliveryCar({
    required int ticketId,
    required VoidCallback onSuccess,
  }) async {
    NavigatorMethods.loading();
    FormData body = FormData.fromMap({
      'ticket_id': ticketId,
    });
    final response =
        await ApiHelper.instance.post(Urls.exitCodeDeliveryCar, body: body);
    NavigatorMethods.loadingOff();
    if (response.state == ResponseState.complete) {
      CommonMethods.showToast(message: response.data['message']);
      onSuccess.call();
    } else {
      CommonMethods.showError(
          message: response.data['message'], apiResponse: response);
    }
  }

  int _ticketId = 0;
  int get ticketId => _ticketId;

  int _gateId = 0;
  int get gateId => _gateId;

  int? _slotId = 0;
  int get slotId => _slotId!;

  String _carPlate = "";
  String get carPlate => _carPlate;

  String _carModel = "";
  String get carModel => _carModel;

  String _carColor = "";
  String get carColor => _carColor;

  String _userMobile = "";
  String get userMobile => _userMobile;

  List? _serviceId = [];
  List get serviceId => _serviceId!;

  set setServiceId(List value) {
    _serviceId = value;
    notifyListeners();
  }

  set setTicketId(int value) {
    _ticketId = value;
    notifyListeners();
  }

  set setGateId(int value) {
    _gateId = value;
    notifyListeners();
  }

  set setSlotId(int value) {
    _slotId = value;
    notifyListeners();
  }

  set setCarPlate(String value) {
    _carPlate = value;
    notifyListeners();
  }

  set setCarModel(String value) {
    _carModel = value;
    notifyListeners();
  }

  set setCarColor(String value) {
    _carColor = value;
    notifyListeners();
  }

  set setUserMobile(String value) {
    _userMobile = value;
    notifyListeners();
  }

  Future<void> createScanRequest({
    String? notes,
    required VoidCallback onSuccess,
    List<File>? images,
  }) async {
    NavigatorMethods.loading();
    FormData body = FormData.fromMap({
      'ticket_id': _ticketId,
      'gate_id': _gateId,
      'slot_id': _slotId,
      'notes': notes,
      'car_plate': _carPlate,
      'car_model': _carModel,
      'car_color': _carColor,
      'user_mobile': _userMobile,
      if (_serviceId != null) ...{
        for (int i = 0; i < _serviceId!.length; i++) ...{
          'service_id[$i]': _serviceId![i]
        }
      },
      if (images != null) ...{
        for (int i = 0; i < images.length; i++) ...{
          'car_images[$i]': await MultipartFile.fromFile(
            images[i].absolute.path,
            filename: basename(images[i].path),
          )
        }
      }
    });
    final response =
        await ApiHelper.instance.post(Urls.createScanRequest, body: body);
    NavigatorMethods.loadingOff();
    if (response.state == ResponseState.complete) {
      CommonMethods.showToast(message: response.data['message']);
      onSuccess.call();
    } else {
      CommonMethods.showError(
          message: response.data['message'], apiResponse: response);
    }
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

  Future<void> getServices({required int id}) async {
    _servicesResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    _services = [];
    notifyListeners();
    _servicesResponse =
        await ApiHelper.instance.get("${Urls.servicesCategory}$id");
    notifyListeners();

    if (_servicesResponse.state == ResponseState.complete) {
      Iterable iterable = _servicesResponse.data['data'];
      _services = iterable.map((e) => ServicesModel.fromJson(e)).toList();
      notifyListeners();
    }
  }

  ApiResponse _validScanCodeResponse =
      ApiResponse(state: ResponseState.sleep, data: null);
  ApiResponse get validScanResponse => _validScanCodeResponse;

  void initialValidScanCode() {
    _validScanCodeResponse =
        ApiResponse(state: ResponseState.sleep, data: null);
    _validScanCode = null;
    notifyListeners();
  }

  ValidScanCodeModel? _validScanCode;
  ValidScanCodeModel? get validScanCode => _validScanCode;

  Future<void> getValidScan({required ticketId}) async {
    _validScanCodeResponse =
        ApiResponse(state: ResponseState.loading, data: null);
    _validScanCode = null;
    notifyListeners();
    _validScanCodeResponse =
        await ApiHelper.instance.get("${Urls.tickets}/$ticketId");
    notifyListeners();
    if (_validScanCodeResponse.state == ResponseState.complete) {
      _validScanCode =
          ValidScanCodeModel.fromJson(_validScanCodeResponse.data['data']);
      notifyListeners();
    }
  }
}
