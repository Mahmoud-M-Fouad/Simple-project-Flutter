import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({Key? key,
    required this.onChange,
    required this.validator,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    required this.keyboardType,
    required this.icon,
    required this.readOnly,
  }) : super(key: key);
  Function(String)? onChange;
  var validator;
  String? hintText;
  bool? obscureText;
  bool readOnly;
  TextEditingController controller;
  IconData icon;
  TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      cursorColor: Colors.orange,
      readOnly: readOnly,
      decoration: InputDecoration(
        prefixIcon: Icon(icon,color: Colors.grey,),
        enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: Colors.teal
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Colors.green
          ),
            borderRadius: BorderRadius.circular(16),
        ),
        border:OutlineInputBorder(
          borderSide: const BorderSide(
              color: Colors.teal
          ),
          borderRadius: BorderRadius.circular(8)
        ),
        label: Text(hintText!),
        labelStyle: const TextStyle(color: Colors.black, fontSize: 20),
        //hintText: labelText,
        hintStyle: const TextStyle(color: Colors.black, fontSize: 20),
      ),
      onChanged:onChange,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.deepPurple, fontSize: 18, fontWeight: FontWeight.normal),
    );
  }

}
