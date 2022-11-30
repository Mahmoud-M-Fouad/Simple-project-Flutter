import 'dart:convert';

import '../helper/api.dart';
import '../helper/const.dart';
import '../model/product_model.dart';
import 'package:http/http.dart' as http;

class AllCategoriesServices{
  Future<dynamic> getAllCategories() async{
    List<dynamic> data = await Api().get(url: '$baseUrl/categories');
    return data;
  }
}