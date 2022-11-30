import 'dart:convert';

import '../helper/api.dart';
import '../helper/const.dart';
import '../model/product_model.dart';
import 'package:http/http.dart' as http;

class AllProductServices{
  Future<List<ProductModel>> getAllProduct() async{
    List<ProductModel> productModel = [];
    List<dynamic> data = await Api().get(url: '$baseUrl/products', token: null);
    for (int i=0;i<data.length;i++) {
      productModel.add(ProductModel.fromJson(data[i]));
    }
    return productModel;
  }
}