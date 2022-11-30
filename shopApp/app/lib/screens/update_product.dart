import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shop/model/product_model.dart';
import 'package:shop/services/update_product.dart';
import 'package:shop/widget/custom_button.dart';
import 'package:shop/widget/custom_textfield.dart';

import '../widget/customa_weSomeDialog.dart';

class UpdateProductScreen extends StatefulWidget {
  UpdateProductScreen({Key? key}) : super(key: key);
  static String id = "UpdateProduct";

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
   TextEditingController controllerName = TextEditingController() ;
   TextEditingController controllerDecs = TextEditingController();
   TextEditingController controllerPrice = TextEditingController();
   TextEditingController controllerImage = TextEditingController();
   bool isLoading = false;
   @override
  Widget build(BuildContext context) {

    ProductModel productModel = ModalRoute.of(context)!.settings.arguments as ProductModel;
    updateProductMethod(ProductModel product)
    {
      UpdateProduct().updateProduct(
        id: product.id,
        title: controllerName.text?? product.title,
          price: controllerPrice.text ?? product.price,
          description: controllerDecs.text?? product.description,
          image: controllerImage.text?? product.image,
          category: product.category?? product.category,
      ).then((value) {
        isLoading = false;
        String body = "ID = ${value.id}\nTitle = ${value.title}"
            "\nDescription = ${value.description}\nPrice = ${value.price}\n"
            "Image = ${value.image}\nCategory = ${value.category}";
        CustomAweSomeDialog().showAweSomeDialogYes(
            context: context,
            dialogType: DialogType.success,
            body: body,
            colorBorder: Colors.grey
            , funOk: (){}
        );
        setState(() {

        });
      });
    }

     controllerName.text = productModel.title;
     controllerDecs.text = productModel.description;
     controllerPrice.text = productModel.price;
     controllerImage.text = productModel.image;

    return ModalProgressHUD(
      inAsyncCall: isLoading,

      child: Scaffold(
        appBar: AppBar(title: const Text("Update Product",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100,),
                CustomTextField(
                    readOnly: false,
                    onChange: (String s){},
                    validator: (data)
                    {
                      if(data.isEmpty) return 'Field is required';
                      if(!data.contains('@gmail.com')) return 'exampl@gmail.com';
                      if(data.startsWith('@gmail.com')) return 'exampl@gmail.com';
                    },
                    hintText: "Product Name",
                    obscureText: false,
                    controller: controllerName,
                    keyboardType: TextInputType.text,
                    icon: Icons.shopping_basket_outlined
                ),
                const SizedBox(height: 10,),
                CustomTextField(
                    readOnly: false,
                    onChange: (String s){},
                    validator: (data)
                    {
                      if(data.isEmpty) return 'Field is required';
                      if(!data.contains('@gmail.com')) return 'exampl@gmail.com';
                      if(data.startsWith('@gmail.com')) return 'exampl@gmail.com';
                    },
                    hintText: "description",
                    obscureText: false,
                    controller: controllerDecs,
                    keyboardType: TextInputType.text,
                    icon: Icons.description
                ),
                const SizedBox(height: 10,),
                CustomTextField(
                    readOnly: false,
                    onChange: (String s){},
                    validator: (data)
                    {
                      if(data.isEmpty) return 'Field is required';
                      if(!data.contains('@gmail.com')) return 'exampl@gmail.com';
                      if(data.startsWith('@gmail.com')) return 'exampl@gmail.com';
                    },
                    hintText: "price",
                    obscureText: false,
                    controller: controllerPrice,
                    keyboardType: TextInputType.number,
                    icon: Icons.monetization_on
                ),
                const SizedBox(height: 10,),
                CustomTextField(
                    readOnly: false,
                    onChange: (String s){},
                    validator: (data)
                    {
                      if(data.isEmpty) return 'Field is required';
                      if(!data.contains('@gmail.com')) return 'exampl@gmail.com';
                      if(data.startsWith('@gmail.com')) return 'exampl@gmail.com';
                    },
                    hintText: "image",
                    obscureText: false,
                    controller: controllerImage,
                    keyboardType: TextInputType.text,
                    icon: Icons.image
                ),
                const SizedBox(height: 40,),
                CustomButton(

                    onTap: ()async {
                      isLoading = true;
                      setState(() {

                      });
                      try{
                        await updateProductMethod(productModel);
                      }
                      catch(e){
                        isLoading  = false;
                        setState(() {

                        });
                      }

                    },
                    text: "Update Product",
                )
              ],
            ),
          ),
        ),
      ),
    );

  }

}
