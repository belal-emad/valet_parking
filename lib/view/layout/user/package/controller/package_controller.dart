import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:valet_parking/helpers/networking/api_helper.dart';
import 'package:valet_parking/helpers/networking/urls.dart';
import 'package:valet_parking/helpers/utils/common_methods.dart';
import 'package:valet_parking/helpers/utils/navigator_methods.dart';
import 'package:valet_parking/view/layout/user/package/model/my_packages_model.dart';
import 'package:valet_parking/view/layout/user/package/model/package_model.dart';

class PackageController extends ChangeNotifier {
  void initialPackage() {
    _packageResponse = ApiResponse(
      state: ResponseState.sleep,
      data: null,
    );
    _packages = [];
    notifyListeners();
  }

  ApiResponse _packageResponse = ApiResponse(
    state: ResponseState.sleep,
    data: null,
  );
  ApiResponse get packageResponse => _packageResponse;

  List<PackageModel> _packages = [];
  List<PackageModel> get packages => _packages;

  Future<void> getPackages() async {
    _packageResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    _packages = [];
    notifyListeners();
    _packageResponse = await ApiHelper.instance.get(Urls.packages);
    notifyListeners();

    if (_packageResponse.state == ResponseState.complete) {
      Iterable iterable = _packageResponse.data['data'];
      _packages = iterable.map((e) => PackageModel.fromJson(e)).toList();
      notifyListeners();
    }
  }
 


  void initialDetailsPackage() {
    _detailsPackageResponse = ApiResponse(
      state: ResponseState.sleep,
      data: null,
    );
    _detailsPackage = null;
    notifyListeners();
  }

  ApiResponse _detailsPackageResponse = ApiResponse(
    state: ResponseState.sleep,
    data: null,
  );
  ApiResponse get detailsPackageResponse => _detailsPackageResponse;

  PackageModel? _detailsPackage;
  PackageModel? get detailsPackage => _detailsPackage;

  Future<void> getDetailsPackage({required int id}) async {
    _detailsPackageResponse = ApiResponse(
      state: ResponseState.loading,
      data: null,
    );
    _detailsPackage = null;
    notifyListeners();
    _detailsPackageResponse =
        await ApiHelper.instance.get("${Urls.packages}/$id");
    notifyListeners();
    if (_detailsPackageResponse.state == ResponseState.complete) {
      _detailsPackage =
          PackageModel.fromJson(_detailsPackageResponse.data['data']);
      notifyListeners();
    }
  }

  Future<void> subscribeToPackage({
    required int packageId,
    required int packageType,
    required VoidCallback onSuccess,
  })async{
 NavigatorMethods.loading();
 FormData body=FormData.fromMap({
'package_id':packageId,
'package_type':packageType,
 });
 final response=await ApiHelper.instance.post(Urls.subscribeToPackage,body: body);
 NavigatorMethods.loadingOff();
 if(response.state==ResponseState.complete){
  CommonMethods.showToast(message:response.data['message']);
  onSuccess.call();
 }else{
  CommonMethods.showError(message: response.data['message'],apiResponse: response);
 }
  }

  void initialMyPackage(){
    _mypackagesResponse=ApiResponse(state: ResponseState.sleep, data: null);
    _myPackages=[];
    notifyListeners();
  }
 ApiResponse _mypackagesResponse=ApiResponse(
  state: ResponseState.sleep,
   data: null);
   ApiResponse get mypackagesResponse=> _mypackagesResponse;
List<MyPackagesModel>_myPackages=[];
List<MyPackagesModel> get myPackages =>_myPackages;
Future<void>getMyPackages()async{
  _mypackagesResponse=ApiResponse(state: ResponseState.loading, data: null);
  _myPackages=[];
  notifyListeners();
  _mypackagesResponse=await ApiHelper.instance.get(Urls.myPackages);
   notifyListeners();

    if (_mypackagesResponse.state == ResponseState.complete) {
      Iterable iterable = _mypackagesResponse.data['data'];
      _myPackages = iterable.map((e) => MyPackagesModel.fromJson(e)).toList();
      notifyListeners();
    }
}

  Future<void> stopPackage({
    required String daysStopped,
    required int id,
     int? reNew,
    required VoidCallback onSuccess,
  })async{
 NavigatorMethods.loading();
 FormData body=FormData.fromMap({
'days_stopped':int.parse(daysStopped),
 });
 final response=await ApiHelper.instance.post("${Urls.dayStopped}$id/update",body: body,
 queryParameters:{
  if(reNew !=null)...{
    "renew":reNew
  }

 } );
 NavigatorMethods.loadingOff();
 if(response.state==ResponseState.complete){
  CommonMethods.showToast(message:response.data['message']);
  onSuccess.call();
 }else{
  CommonMethods.showError(message: response.data['message'],apiResponse: response);
 }
  }

}
