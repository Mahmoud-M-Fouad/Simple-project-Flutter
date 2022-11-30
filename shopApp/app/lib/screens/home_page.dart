import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop/model/product_model.dart';
import 'package:shop/screens/add_product.dart';

import '../services/get_all_product.dart';
import '../widget/custom_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static String id = "HomePage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("New Trend",style: TextStyle(color: Colors.black87),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, AddProductScreen.id);
          }, icon: const Icon(FontAwesomeIcons.cartPlus,
          color: Colors.black87,
          ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 5,left: 5,top: 60),
        child: FutureBuilder<List<ProductModel>>(
          future: AllProductServices().getAllProduct(),
          builder: (context,snapshot){
            if(snapshot.hasData)
              {
                List<ProductModel> products = snapshot.data!;
                return GridView.builder(
                  itemCount: products.length,
                    clipBehavior: Clip.none,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 100,
                    ),
                    itemBuilder: (context,index)
                    {
                      return CustomCard(productModel: products[index]);
                    }
                );
              }
            else if(snapshot.hasError ){
              return  Center(child: Text("Connection Field  ${snapshot.data}" ));
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        )
      ),
    );
  }
}
