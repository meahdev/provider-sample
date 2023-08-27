
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_test/domain/dashboard/product.dart';
import 'package:flutter_provider_test/domain/network/api/api_client.dart';
import 'package:flutter_provider_test/domain/network/error_handler/error_handler.dart';
import 'package:flutter_provider_test/domain/network/generic/base_model.dart';

class DashboardRepo{

  ApiClient apiClient= ApiClient(Dio());
  Future<BaseModel<ProductInfo>> getProducts()async{
    ProductInfo response;
    try{
      var dynamicData= await  apiClient.getProducts();
      String jsonString = "{\"product_list\": ${jsonEncode(dynamicData)}}";
      response = ProductInfo.fromJson(json.decode(jsonString));

    }catch(e){
      print('Exception is $e');
      return BaseModel()..setException(ErrorHandler.withErrorAndCode(error: e as DioError));
    }
    return BaseModel()..data = response;
  }
}