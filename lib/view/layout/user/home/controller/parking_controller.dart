import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:valet_parking/helpers/networking/api_helper.dart';
import 'package:valet_parking/helpers/networking/urls.dart';
import 'package:valet_parking/helpers/utils/common_methods.dart';
import 'package:valet_parking/helpers/utils/navigator_methods.dart';
import 'package:valet_parking/view/layout/user/home/model/parking_model.dart';

class ParkingController extends ChangeNotifier {
  void initialParkingDetails() {
    _parkingResponse = ApiResponse(
      state: ResponseState.sleep,
      data: null,
    );
    _parkingDetails = [];
    notifyListeners();
  }

  ApiResponse _parkingResponse = ApiResponse(
    state: ResponseState.sleep,
    data: null,
  );
  ApiResponse get parkingResponse => _parkingResponse;
  List<ParkingModel> _parkingDetails = [];
  List<ParkingModel> get parkingDetails => _parkingDetails;

  Future<void> getParkingDetails({required int id}) async {
    _parkingResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    _parkingDetails = [];
    notifyListeners();
    _parkingResponse =
        await ApiHelper.instance.get("${Urls.parkingDetails}$id");
    notifyListeners();
    if (_parkingResponse.state == ResponseState.complete) {
      Iterable iterable = _parkingResponse.data['data'];
      _parkingDetails = iterable.map((e) => ParkingModel.fromJson(e)).toList();
      notifyListeners();
    }
  }

  int _categoryTypeId = 0;
  int get categoryTypeId => _categoryTypeId;
  int _categoryId = 0;
  int get categoryId => _categoryId;
  int _gateId = 0;
  int get gateId => _gateId;
  int _slotId = 0;
  int get slotId => _slotId;
  int _userCarId = 0;
  int get userCarId => _userCarId;
  List _serviceId = [];
  List get serviceId => _serviceId;

  set parkingDetails(List<ParkingModel> details) {
    _parkingDetails = details;
    notifyListeners();
  }

  set setCategoryTypeId(int value) {
    _categoryTypeId = value;
    notifyListeners();
  }

  set setCategoryId(int value) {
    _categoryId = value;
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

  set setUserCarId(int value) {
    _userCarId = value;
    notifyListeners();
  }

  set setServiceId(List value) {
    _serviceId = value;
    notifyListeners();
  }

  Future<void> createTickets({
    required int categoryTypeId,
    required int categoryId,
    required int gateId,
    required int slotId,
    required int userCarId,
    required List serviceId,
  }) async {
    FormData body = FormData.fromMap({
      'category_type_id': categoryTypeId,
      'category_id': categoryId,
      'gate_id': gateId,
      'slot_id': slotId,
      'user_car_id': userCarId,
      if (_serviceId.isNotEmpty) ...{
        for (int i = 0; i < _serviceId.length; i++) ...{
          'service_id[$i]': _serviceId[i]
        }
      },
    });
    NavigatorMethods.loading();
    final response = await ApiHelper.instance.post(
      Urls.createTicket,
      body: body,
    );
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
