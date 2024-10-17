import 'package:flutter/material.dart';
import 'package:valet_parking/helpers/networking/api_helper.dart';
import 'package:valet_parking/helpers/networking/urls.dart';
import 'package:valet_parking/view/layout/global/notifications/model/notifications_model.dart';

class NotificationsController extends ChangeNotifier {
  void initialNotifications() {
    _notificationsResponse = ApiResponse(
      state: ResponseState.sleep,
      data: null,
    );
    _notifications = [];
    notifyListeners();
  }

  ApiResponse _notificationsResponse = ApiResponse(
    state: ResponseState.sleep,
    data: null,
  );
  ApiResponse get notificationsResponse => _notificationsResponse;

  List<NotificationsModel> _notifications = [];
  List<NotificationsModel> get notifications => _notifications;

  Future<void> getNotifications() async {
    _notificationsResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    _notifications = [];
    notifyListeners();
    _notificationsResponse = await ApiHelper.instance.get(Urls.notifications);
    notifyListeners();

    if (_notificationsResponse.state == ResponseState.complete) {
      Iterable iterable = _notificationsResponse.data['data'];
      _notifications =
          iterable.map((e) => NotificationsModel.fromJson(e)).toList();
      notifyListeners();
    }
  }
}
