import 'package:shop/helper/const.dart';

import '../helper/api.dart';
import '../model/product_model.dart';

class AddProduct{
  Future<ProductModel> addNewProduct({
  required String title,
  required String price,
  required String description,
  required String image,
  required String category,
}) async{
    Map<String, dynamic> data = await Api().post(
        url: "$baseUrl/products",
        body: {
          "title":title,
          "price": price,
          "description": description,
          "image":image,
          "category":category,
        },
        token: null,
    );
    return ProductModel.fromJson(data);
  }
}