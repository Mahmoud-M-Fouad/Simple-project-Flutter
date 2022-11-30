import 'dart:convert';

import '../helper/api.dart';
import '../helper/const.dart';
import '../model/product_model.dart';
import 'package:http/http.dart' as http;

class CategoriesServices{
  Future<List<ProductModel>> getCategoriesProduct({required categoryName}) async{
    List<ProductModel> productModel = [];
    List<dynamic> data = await Api().get(url: '$baseUrl/categories');
    for (var index in data) {
      productModel.add(ProductModel.fromJson(data[index]));
    }
    return productModel;
  }
}