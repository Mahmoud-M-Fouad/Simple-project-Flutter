
import 'package:flutter/material.dart';

import '../model/model.dart';
import '../shared/component/component.dart';
import '../shared/component/db.dart';
import '../shared/component/shared_preferences.dart';

class UpdateCourseScreen extends StatefulWidget {
  UpdateCourseScreen({Key? key}) : super(key: key);

  @override
  State<UpdateCourseScreen> createState() => _UpdateCourseScreenState();
}

class _UpdateCourseScreenState extends State<UpdateCourseScreen> {
  var formKey = GlobalKey <FormState>();
  TextEditingController idController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController teacherController = TextEditingController();

  TextEditingController hourController = TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItems {
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

  List<DropdownMenuItem<String>> get hourType {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "مساءاً", child: Text("مساءاً")),
      const DropdownMenuItem(value: "صباحاً", child: Text("صباحاً")),


    ];
    return menuItems;
  }
  String selectedValue = "السبت";
  String selectedType = "مساءاً";
  var list;
  void validateShow(int id) async {
    list = await courseId(id).then((value){
      nameController.text = value[0].name;
      teacherController.text =  value[0].teacher;
      selectedValue =  value[0].day;
      hourController.text =  value[0].hour;
      selectedType =  value[0].type;
      phoneController.text =  value[0].phone;
      isLoading = false;
    });
    print(list);

    setState(() {

    });
  }
  bool isLoading = true;
  @override
  void initState() {
    isLoading = true;
    validateShow(SharedClass.getInt(key: 'ID'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(),
      body: isLoading?const CircularProgressIndicator():
      SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
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
                      child: buildTextFormField(
                          controller: teacherController,
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
                    controller: teacherController,
                    text: 'رقم الأستاذ/ة',
                    iconPre: Icons.phone_android,
                    textInputType: TextInputType.phone
                ),
                buildMaterialButton(
                    color: Colors.indigo,
                    text: "تعديل بيانات الدرس",
                    function: () {
                      final FormState? form = formKey.currentState;
                      if (form!.validate())
                      {
                        var math = Course(id: SharedClass.getInt(key: 'ID'),
                            name: nameController.text,
                            teacher: teacherController.text,
                            day: selectedValue,
                            hour: hourController.text,
                            phone: phoneController.text,
                            type: selectedType);
                        updateCourse(math, context);
                        print('Form is valid');
                      }
                      else {
                        print('Form is invalid');
                      }
                    }
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
