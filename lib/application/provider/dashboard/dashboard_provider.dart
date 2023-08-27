
import 'package:flutter/material.dart';
import 'package:flutter_provider_test/domain/dashboard/product.dart';
import 'package:flutter_provider_test/domain/network/generic/base_model.dart';
import 'package:flutter_provider_test/infrastrcture/dashboard/dashboard_repo.dart';

class DashBoardProvider extends ChangeNotifier{
  final DashboardRepo _dashboardRepo;
  List<ProductListInfo> productListInfo =[];
   bool isLoading= false;

  DashBoardProvider(this._dashboardRepo);

  Future<List<ProductListInfo>>getProducts()async{
    print('Called getProducts(');
    _setLoading(true);
    _dashboardRepo.getProducts().then((value) {
      _setLoading(false);
      productListInfo = value.data?.mProductList??[];
      notifyListeners();
    });
    return productListInfo;
  }

  _setLoading(bool value){
    isLoading = value;
    notifyListeners();
  }




}