import 'package:flutter/material.dart';
import 'package:shop/screens/update_product.dart';

import '../model/product_model.dart';

class CustomCard extends StatelessWidget {
  CustomCard({Key? key,required this.productModel }) : super(key: key);
  ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()
      {
        Navigator.pushNamed(context, UpdateProductScreen.id,arguments: productModel);
      },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 40,
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0,
                  offset: const Offset(5,5)
              )
            ]
        ),
        child: Card(
          elevation: 10,
          color: Colors.white,
          child: Stack(
            clipBehavior: Clip.none,
            //alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                     Text(productModel.title.substring(0,12) ,style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                    ),),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("\$${productModel.price}"),
                        const Icon(Icons.favorite,color: Colors.red,),
                      ],)
                  ],
                ),
              ),
              Container(
                child: Positioned(
                  right: 20,
                  top: -60,
                  child: Image.network(productModel.image,height: 100,width: 70,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
