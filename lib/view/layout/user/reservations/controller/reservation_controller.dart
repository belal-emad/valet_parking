import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:valet_parking/helpers/networking/api_helper.dart';
import 'package:valet_parking/helpers/networking/urls.dart';
import 'package:valet_parking/helpers/utils/common_methods.dart';
import 'package:valet_parking/helpers/utils/navigator_methods.dart';
import 'package:valet_parking/view/layout/user/reservations/model/reservations_history_model.dart';
import 'package:valet_parking/view/layout/user/reservations/model/reservations_model.dart';

class ReservationController extends ChangeNotifier {
  void initialReservation() {
    _reservationsResponse = ApiResponse(
      state: ResponseState.sleep,
      data: null,
    );
    _reservations = [];
    notifyListeners();
  }

  ApiResponse _reservationsResponse = ApiResponse(
    state: ResponseState.sleep,
    data: null,
  );
  ApiResponse get reservationsResponse => _reservationsResponse;

  List<ReservationModel> _reservations = [];
  List<ReservationModel> get reservations => _reservations;

  Future<void> getReservation() async {
    _reservationsResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    _reservations = [];
    notifyListeners();

    _reservationsResponse = await ApiHelper.instance.get(Urls.userTickets);
    notifyListeners();

    if (_reservationsResponse.state == ResponseState.complete) {
      Iterable iterable = _reservationsResponse.data['data'];
      _reservations =
          iterable.map((e) => ReservationModel.fromJson(e)).toList();
      notifyListeners();
    }
  }

  void initialReceivingCar() {
    _receivingCarResponse = ApiResponse(
      state: ResponseState.sleep,
      data: null,
    );
    _receivingCar = [];
    notifyListeners();
  }

  ApiResponse _receivingCarResponse = ApiResponse(
    state: ResponseState.sleep,
    data: null,
  );
  ApiResponse get receivingCarResponse => _receivingCarResponse;

  List<ReservationModel> _receivingCar = [];
  List<ReservationModel> get receivingCar => _receivingCar;

  Future<void> getReceivingCar() async {
    _receivingCarResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    _receivingCar = [];
    notifyListeners();

    _receivingCarResponse =
        await ApiHelper.instance.get(Urls.userTicketsFinished);
    notifyListeners();

    if (receivingCarResponse.state == ResponseState.complete) {
      Iterable iterable = _receivingCarResponse.data['data'];
      _receivingCar =
          iterable.map((e) => ReservationModel.fromJson(e)).toList();
      notifyListeners();
    }
  }

  void initialReservationDetails() {
    _reservationDetailsResponse = ApiResponse(
      state: ResponseState.sleep,
      data: null,
    );
    _reservationsDetails = null;
    notifyListeners();
  }

  ApiResponse _reservationDetailsResponse = ApiResponse(
    state: ResponseState.sleep,
    data: null,
  );
  ApiResponse get reservationDetailsResponse => _reservationDetailsResponse;
  ReservationModel? _reservationsDetails;
  ReservationModel? get reservationsDetails => _reservationsDetails;

  Future<void> getReservationDetails({required int id}) async {
    _reservationDetailsResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    _reservationsDetails = null;
    notifyListeners();
    _reservationDetailsResponse =
        await ApiHelper.instance.get("${Urls.userTicketId}$id");
    notifyListeners();
    if (_reservationDetailsResponse.state == ResponseState.complete) {
      _reservationsDetails =
          ReservationModel.fromJson(_reservationDetailsResponse.data['data']);
      notifyListeners();
    }
  }

  Future<void> exitTicket({
    required String exitTime,
    required int id,
    required VoidCallback onSuccess,
  }) async {
    NavigatorMethods.loading();
    FormData body = FormData.fromMap({
      'exit_time': exitTime,
    });
    final response = await ApiHelper.instance.post(
      "${Urls.exitTicket}$id/update",
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

  void initialReservationHistory() {
    _reservationsHistoryResponse = ApiResponse(
      state: ResponseState.sleep,
      data: null,
    );
    _reservationsHistory = [];
    notifyListeners();
  }

  ApiResponse _reservationsHistoryResponse = ApiResponse(
    state: ResponseState.sleep,
    data: null,
  );
  ApiResponse get reservationsHistoryResponse => _reservationsHistoryResponse;

  List<ReservationsHistoryModel> _reservationsHistory = [];
  List<ReservationsHistoryModel> get reservationsHistory =>
      _reservationsHistory;

  Future<void> getReservationHistory() async {
    _reservationsHistoryResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    _reservationsHistory = [];
    notifyListeners();

    _reservationsHistoryResponse =
        await ApiHelper.instance.get(Urls.userTicketsFinished);
    notifyListeners();

    if (_reservationsHistoryResponse.state == ResponseState.complete) {
      Iterable iterable = _reservationsHistoryResponse.data['data'];
      _reservationsHistory =
          iterable.map((e) => ReservationsHistoryModel.fromJson(e)).toList();
      notifyListeners();
    }
  }

  Future<void> requestReceiveCar({
    required int id,
    required String exitTime,
    required VoidCallback onSuccess,
  }) async {
    NavigatorMethods.loading();
    FormData body = FormData.fromMap(
      {
        'exit_time': exitTime,
      },
    );
    final response = await ApiHelper.instance.post(
      "${Urls.exitTicketRequest}$id/update",
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
}
