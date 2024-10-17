import 'package:flutter/material.dart';

import '../../../../../helpers/networking/api_helper.dart';
import '../../../../../helpers/networking/urls.dart';
import '../model/category_type_model.dart';

class HomeController extends ChangeNotifier {
  void initialCategoryType() {
    _categoryTypeResponse = ApiResponse(
      state: ResponseState.sleep,
      data: null,
    );
    _categoryTypes = [];
    notifyListeners();
  }

  ApiResponse _categoryTypeResponse = ApiResponse(
    state: ResponseState.sleep,
    data: null,
  );
  ApiResponse get categoryTypeResponse => _categoryTypeResponse;

  List<CategoryTypeModel> _categoryTypes = [];
  List<CategoryTypeModel> get categoryTypes => _categoryTypes;

  Future<void> getCategoryType() async {
    _categoryTypeResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    _categoryTypes = [];
    notifyListeners();
    _categoryTypeResponse = await ApiHelper.instance.get(Urls.categoryTypes);
    notifyListeners();

    if (_categoryTypeResponse.state == ResponseState.complete) {
      Iterable iterable = _categoryTypeResponse.data['data'];
      _categoryTypes =
          iterable.map((e) => CategoryTypeModel.fromJson(e)).toList();
      notifyListeners();
    }
  }
}
