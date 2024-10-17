import 'package:flutter/material.dart';
import 'package:valet_parking/helpers/networking/api_helper.dart';
import 'package:valet_parking/helpers/networking/urls.dart';
import 'package:valet_parking/view/layout/user/home/model/entry_car_model.dart';

class EntryCarController extends ChangeNotifier {
  void initialEntryCarDetails() {
    _entryCarDetailsResponse = ApiResponse(
      state: ResponseState.sleep,
      data: null,
    );
    _entryCarDetails = null;
    notifyListeners();
  }

  ApiResponse _entryCarDetailsResponse = ApiResponse(
    state: ResponseState.sleep,
    data: null,
  );
  ApiResponse get entryCarDetailsResponse => _entryCarDetailsResponse;
  EntryCarModel? _entryCarDetails;
  EntryCarModel? get reservationsDetails => _entryCarDetails;

  Future<void> getEntryCarDetails({required int id}) async {
    _entryCarDetailsResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    _entryCarDetails = null;
    notifyListeners();
    _entryCarDetailsResponse =
        await ApiHelper.instance.get("${Urls.entryCar}$id");
    notifyListeners();
    if (_entryCarDetailsResponse.state == ResponseState.complete) {
      _entryCarDetails =
          EntryCarModel.fromJson(_entryCarDetailsResponse.data['data']);
      notifyListeners();
    }
  }
}
