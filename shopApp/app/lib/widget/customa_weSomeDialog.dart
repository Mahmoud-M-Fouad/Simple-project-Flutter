import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class CustomAweSomeDialog{
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
      body:Text(body,style: const TextStyle(color: Colors.black, fontSize: 18),),
      btnOkOnPress: funOk,
      btnOkText: "Ok",
    ).show();
  }
}
