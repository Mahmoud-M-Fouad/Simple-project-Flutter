import 'package:flutter/material.dart';

import '../model/model.dart';
import '../shared/component/component.dart';
import '../shared/component/db.dart';

class AddCourseScreen extends StatefulWidget {
  AddCourseScreen({Key? key}) : super(key: key);

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  var formKey = GlobalKey <FormState>();

  TextEditingController idController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController teacherController = TextEditingController();

  TextEditingController hourController = TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "السبت", child: Text("السبت")),
      const DropdownMenuItem(value: "الأحد", child: Text("الأحد")),
      const DropdownMenuItem(value: "الإثنين", child: Text("الإثنين")),
      const DropdownMenuItem(value: "الثلاثاء", child: Text("الثلاثاء")),
      const DropdownMenuItem(value: "الأربعاء", child: Text("الأربعاء")),
      const DropdownMenuItem(value: "الخميس", child: Text("الخميس")),
      const DropdownMenuItem(value: "الجمعة", child: Text("الجمعة")),


    ];
    return menuItems;
  }
  List<DropdownMenuItem<String>> get hourType{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "مساءاً", child: Text("مساءاً")),
      const DropdownMenuItem(value: "صباحاً", child: Text("صباحاً")),



    ];
    return menuItems;
  }
  void validateAndSave()async {
    final FormState? form = formKey.currentState;
    if (form!.validate()) {
      var id = await MaxCourseID() >= 0?await MaxCourseID() : 0;
      print(id);
      setState(() {
        var math = Course( id: ++id, name: nameController.text, teacher: teacherController.text, day: selectedValue, hour:hourController.text, phone: phoneController.text, type: selectedType);
        insertCourse(math , context);
        //id =

      });
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }
  String selectedValue = "السبت";
  String selectedType = "مساءاً";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child:Form(
          key: formKey,
          child: Column(
            children: [

              buildComboBox(
                items: dropdownItems,
                selectValue: selectedValue,
                function: (String? value) async {
                  setState(() {
                    selectedValue = value!;
                  });
                }
              ),

              buildTextFormField(
                controller: nameController,
                text: "أسم الدرس",
                textValidate: "أدخل أسم الدرس",
                iconPre: Icons.menu_book_sharp,
                textInputType: TextInputType.text
              ),

              buildTextFormField(
                  controller: teacherController,
                  text: 'إسم الأستاذ/ة',
                  textValidate: 'أدخل إسم الأستاذ/ة',
                  iconPre: Icons.person,
                  textInputType: TextInputType.text
              ),
              Row(
               // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 Expanded(
                   child:  buildTextFormField(
                     controller: hourController,
                     text: 'ساعة الدرس',
                     textValidate: 'أدخل ساعة الدرس',
                     iconPre: Icons.watch_later,
                     textInputType: TextInputType.number
                 ),
                 ),
                  buildComboBox(
                      items: hourType,
                      selectValue: selectedType,
                      function: (String? value) async {
                        setState(() {
                          selectedType = value!;
                        });
                      }
                  ),
                ],
              ),


              buildTextFormFieldPhone(
                  controller: phoneController,
                  text: 'رقم الأستاذ/ة',
                  iconPre: Icons.phone_android,
                  textInputType: TextInputType.phone
              ),
              buildMaterialButton(
                  color: Colors.indigo,
                  text: "تسجيل الدرس",
                  function: validateAndSave
              ),

            ],
          ),
        ),
      ),
    ),);
  }
}
