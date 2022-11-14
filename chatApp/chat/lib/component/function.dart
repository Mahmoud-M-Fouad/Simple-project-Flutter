import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'const.dart';

myTextStyle(
{
 required Color color,
 required double fontSize,
 required FontWeight fontWeight,
})
{
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    overflow: TextOverflow.fade
  );
}

myTextFormField({
  required String labelText,
  required var onChanged,
  required var validator,
  required TextInputType keyboardType,
  required TextEditingController controller,
})
{
  return TextFormField(
    controller: controller,
    validator: validator,
    cursorColor: Colors.orange,
    decoration: InputDecoration(
      prefixIcon: const Icon(Icons.mail,color: Colors.white,),
      enabledBorder:  const OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.white
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.green
        ),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.white
        ),
      ),
      label: Text(labelText,),
      labelStyle: myTextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
      //hintText: labelText,
      hintStyle: myTextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
    ),
    onChanged:onChanged,
    keyboardType: keyboardType,
    style: myTextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.normal),
  );
}

myTextFormFieldForPass({
  required String labelText,
  required var onChanged,
  required var onChangedPass,
  required var validator,
  required bool obscureText,
  required TextInputType keyboardType,
  required TextEditingController controller,
})
{
  return TextFormField(
    obscureText: obscureText,
    controller: controller,
    validator: validator,
    cursorColor: Colors.orange,
    decoration: InputDecoration(
      prefixIcon: const Icon(Icons.key,color: Colors.white,),
      suffixIcon: IconButton(icon: obscureText?
      const Icon(Icons.remove_red_eye,color: Colors.white,):
      const Icon(Icons.hide_source_outlined,color: Colors.white,),
        onPressed: onChangedPass,),
      enabledBorder:  const OutlineInputBorder(

        borderSide: BorderSide(
            color: Colors.white,

        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.green
        ),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.white
        ),
      ),
      label: Text(labelText,),
      labelStyle: myTextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
      //hintText: labelText,
      hintStyle: myTextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
    ),
    onChanged:onChanged,
    keyboardType: keyboardType,
    style: myTextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.normal),
  );
}

myButton({
  required String textChild,
  required var onTap,
})
{
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(textChild,style: myTextStyle(
              fontSize: 23,
              color: colorApp,
              fontWeight: FontWeight.normal
          ),),
        ),
      ),
    ),
  );
}

nextScreen({
  required BuildContext context,
  required var screen,
})
{
  return Navigator.push(
    context ,
    MaterialPageRoute(builder: (context) =>screen),
  );
}

nextScreenToEnd(
    {
      required BuildContext context,
      required var screen,
    })
{
  return Navigator.pushAndRemoveUntil<dynamic>(
    context,
    MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => screen,
    ),
        (route) => false,//if you want to disable back feature set to false
  );
}

showSnackBar(
{
  required BuildContext context,
  required String message,
  required Color color,
})
{
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,

        content:Text(message,
    style: myTextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
    ) )
  );
}

showAweSomeDialogYes({
  required BuildContext context,
  required DialogType dialogType,
  required String body,
  required Color colorBorder,
  required var funOk,
})

{
  return AwesomeDialog(
    context: context,
    dialogType: dialogType,
    borderSide:  BorderSide(
      color: colorBorder,
      width: 2,
    ),
    width: 500,
    buttonsBorderRadius: const BorderRadius.all(
      Radius.circular(2),
    ),
    dismissOnTouchOutside: true,
    dismissOnBackKeyPress: false,
    headerAnimationLoop: true,
    animType: AnimType.bottomSlide,
    body:Text(body,style: myTextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.normal),),
    btnOkOnPress: funOk,
    btnOkText: "OK",
  ).show();
}