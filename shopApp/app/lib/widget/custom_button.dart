import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({Key? key,required this.onTap,required this.text}) : super(key: key);
  VoidCallback? onTap;
  String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(text,style: const TextStyle(
                fontSize: 23,
                color: Colors.black,
                fontWeight: FontWeight.normal
            ),),
          ),
        ),
      ),
    );
  }
}
