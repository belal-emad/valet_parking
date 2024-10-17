import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../helpers/networking/api_helper.dart';
import '../../../../../helpers/networking/urls.dart';
import '../../../../../helpers/utils/common_methods.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../model/car_model.dart';

class CarController extends ChangeNotifier {
  void initialCar() {
    _carsResponse = ApiResponse(
      state: ResponseState.sleep,
      data: null,
    );
    _cars = [];
    notifyListeners();
  }

  ApiResponse _carsResponse = ApiResponse(
    state: ResponseState.sleep,
    data: null,
  );
  ApiResponse get carsResponse => _carsResponse;

  List<CarModel> _cars = [];
  List<CarModel> get cars => _cars;

  Future<void> getCar() async {
    _carsResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    _cars = [];
    notifyListeners();

    _carsResponse = await ApiHelper.instance.get(Urls.myCar);
    notifyListeners();

    if (_carsResponse.state == ResponseState.complete) {
      Iterable iterable = _carsResponse.data['data'];
      _cars = iterable.map((e) => CarModel.fromJson(e)).toList();
      notifyListeners();
    }
  }

  Future<void> createNewCar({
    required String carModel,
    required String carPlate,
    required String carColor,
    required VoidCallback onSuccess,
  }) async {
    NavigatorMethods.loading();
    FormData body = FormData.fromMap(
      {
        'car_model': carModel,
        'car_plate': carPlate,
        'car_color': carColor,
      },
    );
    final response = await ApiHelper.instance.post(
      Urls.addNewCar,
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

  Future<void> deleteCar({
    required int id,
  }) async {
    NavigatorMethods.loading();

    final response = await ApiHelper.instance.delete(
      "${Urls.cars}$id/delete",
    );
    NavigatorMethods.loadingOff();
    if (response.state == ResponseState.complete) {
      CommonMethods.showToast(message: response.data['message']);
      _cars.removeWhere((element) => element.id == id);
      notifyListeners();
    } else {
      CommonMethods.showError(
        message: response.data['message'],
        apiResponse: response,
      );
      notifyListeners();
    }
  }
}
