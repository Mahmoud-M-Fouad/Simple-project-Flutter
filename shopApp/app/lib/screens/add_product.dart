
import 'dart:io';


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shop/model/product_model.dart';
import 'package:shop/services/add_product.dart';
import 'package:shop/services/update_product.dart';
import 'package:shop/widget/custom_button.dart';
import 'package:shop/widget/custom_textfield.dart';
import 'package:shop/widget/customa_weSomeDialog.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({Key? key}) : super(key: key);
  static String id = "AddProduct";

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var formKey = GlobalKey <FormState>();
   TextEditingController controllerName = TextEditingController() ;
   TextEditingController controllerDecs = TextEditingController();
   TextEditingController controllerPrice = TextEditingController();
   TextEditingController controllerImage = TextEditingController(text: "image path");
   TextEditingController controllerCategory = TextEditingController();
   bool isLoading = false;
   File? imageFile ;
   imageFromGallery() async {
     PickedFile? pickedFile = await ImagePicker()
         .getImage(source: ImageSource.gallery,maxHeight: 350,maxWidth: 350,);
     if (pickedFile != null) {
       setState(() {
         imageFile = File(pickedFile.path);
         controllerImage.text = pickedFile.path;
       });
       controllerImage.text = pickedFile.path;
       //  images.add(image64!);

     }
   }
   @override
  Widget build(BuildContext context) {
    addProductMethod()
    {
      final FormState? form = formKey.currentState;
      if (form!.validate())
      {
        isLoading = true;
        setState(() {

        });
        form.save();
        AddProduct().addNewProduct(
          title: controllerName.text?? "",
          price: controllerPrice.text ?? "",
          description: controllerDecs.text?? "",
          image: controllerImage.text??"",
          category: controllerCategory.text?? "",
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

    }
    return ModalProgressHUD(
      inAsyncCall: isLoading,

      child: Scaffold(
        appBar: AppBar(title: const Text("Add Product",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
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
                      },
                      hintText: "price",
                      obscureText: false,
                      controller: controllerPrice,
                      keyboardType: TextInputType.number,
                      icon: Icons.monetization_on
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: CustomTextField(
                              readOnly: true,
                              onChange: (String s){},
                              validator: (data)
                              {
                                if(data.isEmpty) return 'Field is required';
                              },
                              hintText: "image",
                              obscureText: false,
                              controller: controllerImage,
                              keyboardType: TextInputType.text,
                              icon: Icons.image
                          ),
                        ),
                        IconButton(onPressed: (){
                          imageFromGallery();
                        }, icon: const Icon(Icons.image_outlined)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  CustomTextField(
                      readOnly: false,
                      onChange: (String s){},
                      validator: (data)
                      {
                        if(data.isEmpty) return 'Field is required';
                      },
                      hintText: "Category",
                      obscureText: false,
                      controller: controllerCategory,
                      keyboardType: TextInputType.text,
                      icon: Icons.category_outlined
                  ),
                  const SizedBox(height: 40,),
                  CustomButton(
                      onTap: ()async {
                        try{
                          await addProductMethod();
                        }
                        catch(e){
                          isLoading  = false;
                          setState(() {

                          });
                        }

                      },
                      text: "Add Product",
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }

}
