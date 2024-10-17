import 'package:flutter/material.dart';
import '../../../../../helpers/networking/api_helper.dart';
import '../../../../../helpers/networking/urls.dart';
import '../../../user/home/model/tickets_model.dart';
import '../model/car_request_model.dart';

class CarRequestController extends ChangeNotifier {
  void initialEntryCarRequest() {
    _entryCarResponse = ApiResponse(
      state: ResponseState.sleep,
      data: null,
    );
    _entryCar = [];
    notifyListeners();
  }

  ApiResponse _entryCarResponse = ApiResponse(
    state: ResponseState.sleep,
    data: null,
  );
  ApiResponse get entryCarResponse => _entryCarResponse;

  List<CarRequestModel> _entryCar = [];
  List<CarRequestModel> get entryCar => _entryCar;

  Future<void> getEntryCarRequest() async {
    _entryCarResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    _entryCar = [];
    notifyListeners();
    _entryCarResponse = await ApiHelper.instance.get(Urls.entryCarServices);
    notifyListeners();

    if (_entryCarResponse.state == ResponseState.complete) {
      Iterable iterable = _entryCarResponse.data['data'];
      _entryCar = iterable.map((e) => CarRequestModel.fromJson(e)).toList();
      notifyListeners();
    }
  }

  void initialExitCar() {
    _exitCarResponse = ApiResponse(
      state: ResponseState.sleep,
      data: null,
    );
    _exitCar = [];
    notifyListeners();
  }

  ApiResponse _exitCarResponse = ApiResponse(
    state: ResponseState.sleep,
    data: null,
  );
  ApiResponse get exitCarResponse => _exitCarResponse;

  List<CarRequestModel> _exitCar = [];
  List<CarRequestModel> get exitCar => _exitCar;

  Future<void> getExitCar() async {
    _exitCarResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    _exitCar = [];
    notifyListeners();
    _exitCarResponse = await ApiHelper.instance.get(Urls.exitCarServices);
    notifyListeners();

    if (_exitCarResponse.state == ResponseState.complete) {
      Iterable iterable = _exitCarResponse.data['data'];
      _exitCar = iterable.map((e) => CarRequestModel.fromJson(e)).toList();
      notifyListeners();
    }
  }

  void initialCarRequestDetails() {
    _carRequestDetailsResponse = ApiResponse(
      state: ResponseState.sleep,
      data: null,
    );
    _carRequestDetails = null;
    notifyListeners();
  }

  ApiResponse _carRequestDetailsResponse = ApiResponse(
    state: ResponseState.sleep,
    data: null,
  );
  ApiResponse get carRequestDetailsResponse => _carRequestDetailsResponse;
  TicketsModel? _carRequestDetails;
  TicketsModel? get carRequestDetails => _carRequestDetails;

  Future<void> getCarRequestDetails({required int id}) async {
    _carRequestDetailsResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    _carRequestDetails = null;
    notifyListeners();
    _carRequestDetailsResponse =
        await ApiHelper.instance.get("${Urls.tickets}/$id");
    notifyListeners();
    if (_carRequestDetailsResponse.state == ResponseState.complete) {
      _carRequestDetails =
          TicketsModel.fromJson(_carRequestDetailsResponse.data['data']);
      notifyListeners();
    }
  }
}
