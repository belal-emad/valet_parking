import 'package:flutter/material.dart';

import '../../../../../helpers/networking/api_helper.dart';
import '../../../../../helpers/networking/urls.dart';
import '../model/category_model.dart';

class CategoryController extends ChangeNotifier {
  void initialCategories() {
    _categoriesResponse = ApiResponse(
      state: ResponseState.sleep,
      data: null,
    );
    _categories = [];
    notifyListeners();
  }

  ApiResponse _categoriesResponse = ApiResponse(
    state: ResponseState.sleep,
    data: null,
  );
  ApiResponse get categoriesResponse => _categoriesResponse;

  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  Future<void> getCategories({
    int? type,
    String? search,
    int? user,
  }) async {
    _categoriesResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    _categories = [];
    notifyListeners();

    _categoriesResponse = await ApiHelper.instance.get(
      Urls.categories,
      queryParameters: {
        if (type != null) ...{"type": type},
        if (user != null) ...{"user": user},
        if (search != null && search.trim().isNotEmpty) ...{"search": search}
      },
    );
    notifyListeners();

    if (_categoriesResponse.state == ResponseState.complete) {
      Iterable iterable = _categoriesResponse.data['data'];
      _categories = iterable.map((e) => CategoryModel.fromJson(e)).toList();
      notifyListeners();
    }
  }
}
