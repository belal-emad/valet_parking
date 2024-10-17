import 'package:flutter/material.dart';

import '../../../../../helpers/networking/api_helper.dart';
import '../../../../../helpers/networking/urls.dart';
import '../model/tickets_model.dart';

class TicketsController extends ChangeNotifier {
  void initialTicketsDetails() {
    _ticketsDetailsResponse = ApiResponse(
      state: ResponseState.sleep,
      data: null,
    );
    _ticketsDetails = null;
    notifyListeners();
  }

  ApiResponse _ticketsDetailsResponse = ApiResponse(
    state: ResponseState.sleep,
    data: null,
  );
  ApiResponse get ticketsDetailsResponse => _ticketsDetailsResponse;
  TicketsModel? _ticketsDetails;
  TicketsModel? get ticketsDetails => _ticketsDetails;

  Future<void> getTickets({required int id}) async {
    _ticketsDetailsResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    _ticketsDetails = null;
    notifyListeners();
    _ticketsDetailsResponse =
        await ApiHelper.instance.get("${Urls.tickets}/$id");
    notifyListeners();
    if (_ticketsDetailsResponse.state == ResponseState.complete) {
      _ticketsDetails =
          TicketsModel.fromJson(_ticketsDetailsResponse.data['data']);
      notifyListeners();
    }
  }

  void initialServicesTicketsDetails() {
    _servicesTicketsDetailsResponse = ApiResponse(
      state: ResponseState.sleep,
      data: null,
    );
    _servicesTicketsDetails = [];
    notifyListeners();
  }

  ApiResponse _servicesTicketsDetailsResponse = ApiResponse(
    state: ResponseState.sleep,
    data: null,
  );
  ApiResponse get servicesTicketsDetailsResponse =>
      _servicesTicketsDetailsResponse;
  List<TicketsModel> _servicesTicketsDetails = [];
  List<TicketsModel> get servicesTicketsDetails => _servicesTicketsDetails;

  Future<void> getServicesTickets() async {
    _servicesTicketsDetailsResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    _servicesTicketsDetails = [];
    notifyListeners();
    _servicesTicketsDetailsResponse =
        await ApiHelper.instance.get(Urls.tickets);
    notifyListeners();
    if (_servicesTicketsDetailsResponse.state == ResponseState.complete) {
      Iterable iterable = _servicesTicketsDetailsResponse.data['data'];
      _servicesTicketsDetails =
          iterable.map((e) => TicketsModel.fromJson(e)).toList();
      notifyListeners();
    }
  }
}
