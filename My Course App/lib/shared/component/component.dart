import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:my_course/shared/component/theme.dart';

DateTime selectedDate = DateTime.now();


Future DatePicker(BuildContext ctx, TextEditingController t) {
  return showDatePicker(
    initialDate: selectedDate,
    firstDate: selectedDate,
    lastDate: DateTime(2050),
    context: ctx,
  );
}

buildTextFormField({
  required TextEditingController controller,
  required String text,
  required String textValidate,
  required IconData iconPre,
  required var textInputType,
}) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          border: const UnderlineInputBorder(),
          labelText: text,
          prefixIcon: Icon(iconPre, color: Colors.teal,),
          suffixIcon: IconButton(
            onPressed: () {
              controller.text = "";
            }, icon: const Icon(Icons.clear), color: Colors.teal,),
        ),
        keyboardType: textInputType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return textValidate;
          }
          return null;
        },
      ),
    ),
  );
}

buildTextFormFieldPhone({
  required TextEditingController controller,
  required String text,
  required IconData iconPre,
  required var textInputType,
}) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          border: const UnderlineInputBorder(),
          labelText: text,
          prefixIcon: Icon(iconPre, color: Colors.teal,),
          suffixIcon: IconButton(
            onPressed: () {
              controller.text = "";
            }, icon: const Icon(Icons.clear), color: Colors.teal,),
        ),
        keyboardType: textInputType,
      ),
    ),
  );
}

buildComboBox({
  required String selectValue,
  required var items,
  required var function,
}) {
  return Container(
    padding: const EdgeInsets.all(10),
    height: 90,
    child: DropdownButton(
      dropdownColor: Colors.lightBlue.shade900,
      style: const TextStyle(fontSize: 20, color: Colors.black,),
      //backgroundColor:Colors.lightBlue.shade900,
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      value: selectValue,
      items: items,
      onChanged: function
    ),
  );

}
void showToast({
  required BuildContext context,
  required String msg,
  required Color color,
}) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(msg, style:  TextStyle(color: color,fontSize: 18),textAlign: TextAlign.right,),
    ),
  );
}

buildMaterialButton({
  required Color color,
  required String text,
  required var function,
})
{
  return MaterialButton(
    color: color,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)),
    onPressed: function,
    child:Text(text ,style: headingStyleWhite ),
  );
}

buildIcon(
    {
      // required Color color,
      // required double size,
      required IconData icon,
    })
{
  return Icon(
    icon,
    color: Colors.white,
    size: 26,

  );
}

cancelButtonMethod(BuildContext context)
{
  Navigator.pop(context);
}

updateButtonMethod(BuildContext context , var secondRoute)
{
  navigatorTo(context , secondRoute);
}

navigatorTo(BuildContext context ,  var secondRoute )
{
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => secondRoute),
  );
}

showDialogMethod({
  required BuildContext context ,
  required Widget title ,
  required Widget content ,
  required Function cancelButton ,
  required String textCancel ,
  required var continueButton  ,
  required String textContinue
})
{
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return  AlertDialog(
        backgroundColor: Colors.deepPurple.shade600,
        titleTextStyle: headingStyleWhite2,
        contentTextStyle: headingStyleWhite,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),

        title: title,
        content: content,
        actions: [
          TextButton(onPressed:()
          {
            Navigator.pop(context);
          }
            , child: Text(textCancel,textAlign: TextAlign.left,
                style:TextStyle(fontSize: 20,color: Colors.red.shade700) ),),

          TextButton(onPressed:continueButton, child: Text(textContinue , textAlign: TextAlign.right,
              style:TextStyle(fontSize: 20,color: Colors.green.shade500)
          ))
        ],
      );
    },
  );
}
buildImage({
  required double radius ,
  required String imagePath ,
  required double h ,
  required double w
} )
{
  return Padding(
    padding: const EdgeInsets.all(10),
    child: CircleAvatar(
      radius: radius,
      child: Image.asset(imagePath,height: h,width: w,),
    ),
  );
}

buildImageProfile({
  required double radius ,
  required String imagePath ,
} )
{
  return Padding(
    padding: const EdgeInsets.all(10),
    child: CircleAvatar(
      backgroundImage: AssetImage(imagePath),
      radius: radius,
    ),
  );
}
buildCopy({
  required String textCopy ,required BuildContext context
})
{
  FlutterClipboard.copy(textCopy).then(( value ) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('تم النسخ' , style: TextStyle(color: Colors.green,fontSize: 18),textAlign: TextAlign.right,),
      ),
    );
  });
}

buildPast({
  required String textCopy ,required String pasteValue
})
{
  FlutterClipboard.paste().then((value) {
    textCopy = value;
    pasteValue = value;
  });

}


/*

 onChanged: (String? value) async {
        setState(() {
          selectedValue = value!;
        });
        }
 */