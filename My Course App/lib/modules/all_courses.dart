import 'package:flutter/material.dart';
import 'package:my_course/modules/update_course.dart';
import 'package:my_course/shared/component/component.dart';

import '../shared/component/db.dart';
import '../shared/component/shared_preferences.dart';
import '../shared/cubit/app_cubit.dart';

class AllCoursesScreen extends StatefulWidget {
  const AllCoursesScreen({Key? key}) : super(key: key);

  @override
  State<AllCoursesScreen> createState() => _AllCoursesScreenState();
}

class _AllCoursesScreenState extends State<AllCoursesScreen> {
  List<DropdownMenuItem<String>> get items {
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

  String selectedValue = "السبت";
  var cousrelist;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    var cubit = AppBloc.get(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 55,
            child: Row(
              children: [
                IconButton(
                    onPressed: () async{
                      if (await Check_course_day(selectedValue)) {
                        cousrelist = await course(selectedValue);
                      } else {
                        cousrelist = [];
                        showToast(
                            context: context,
                            msg: "لا يوجد دورس هذا اليوم",
                            color: Colors.red);
                      }
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.arrow_downward,
                      size: 26,
                    )),
                Expanded(
                  child: Center(
                    child: DropdownButton(
                      dropdownColor: Colors.teal.shade400,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      //backgroundColor:Colors.lightBlue.shade900,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      value: selectedValue,
                      items: items,
                      onTap: () {
                        setState(() {});
                      },

                      onChanged: (String? value) async {
                        setState(() {
                          selectedValue = value!;
                          // FlutterClipboard.copy(selectedValue).then(( value ) => print('copied'));
                          print(selectedValue);
                        });

                        if (await Check_course_day(selectedValue)) {
                          cousrelist = await course(selectedValue);
                        } else {
                          cousrelist = [];
                          showToast(
                              context: context,
                              msg: "لا يوجد دورس هذا اليوم",
                              color: Colors.red);
                        }

                        print(cousrelist);
                        // print(cousrelist[0].name);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          cousrelist?.isEmpty == null
              ? Container()
              :
              //isLoading?Container():
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return buildContainerCourse(index);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: cousrelist.length,
                  // shrinkWrap: true,
                )
        ],
      ),
    );
  }

  buildContainerCourse(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 15, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(15),
              height: 550,
              decoration: BoxDecoration(
                color: Colors.teal.shade400,
                borderRadius: const BorderRadius.all(Radius.circular(
                        15) //                 <--- border radius here
                    ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Image.asset('image/man.png',height: 100,width: 100,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildRowInListView(
                        image: 'image/open-book.png',
                        course: cousrelist[index].name,
                      ),
                      const SizedBox(height: 10,),
                      buildRowInListView(
                        image: 'image/presentation.png',
                        course: cousrelist[index].teacher,
                      ),
                      const SizedBox(height: 10,),
                      buildRowInListView(
                        image: 'image/calendar.png',
                        course: cousrelist[index].day,
                      ),
                      const SizedBox(height: 10,),
                      buildRowInListView(
                        image: 'image/clock.png',
                        course: cousrelist[index].hour +
                            "\t" +
                            cousrelist[index].type,
                      ),
                      const SizedBox(height: 10,),
                      buildRowInListView(
                        image: 'image/phone-call.png',
                        course: cousrelist[index].phone,
                      ),
                      const SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {
                                showDialogMethod(
                                  context: context,
                                  cancelButton: () {
                                    Navigator.pop(context);
                                  },
                                  continueButton: () {
                                    Navigator.pop(context);

                                    setState(() {
                                      deleteCourse(
                                          cousrelist[index].id, context);
                                    });
                                    setState(() {});
                                  },
                                  content: const Text(
                                    "هل تريد حذف هذا الكشف",
                                    textAlign: TextAlign.right,
                                  ),
                                  title: const Text(
                                    "رسالة تنبية",
                                    textAlign: TextAlign.right,
                                  ),
                                  textCancel: 'لا',
                                  textContinue: 'نعم',
                                );
                                //
                                print("${cousrelist[index].id}");
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red.shade900,
                                size: 29,
                              )),
                          IconButton(
                              onPressed: () {
                                showDialogMethod(
                                  context: context,
                                  cancelButton: () {
                                    Navigator.pop(context);
                                  },
                                  continueButton: () {
                                    setState(() {
                                      Navigator.pop(context);
                                      SharedClass.setId(
                                          key: 'ID', num: cousrelist[index].id);
                                      navigatorTo(
                                          context, UpdateCourseScreen());
                                      print(cousrelist[index].id);
                                    });
                                  },
                                  content: const Text(
                                    "هل تريد تعديل هذا الكشف",
                                    textAlign: TextAlign.right,
                                  ),
                                  title: const Text(
                                    "رسالة تنبية",
                                    textAlign: TextAlign.right,
                                  ),
                                  textCancel: 'لا',
                                  textContinue: 'نعم',
                                );
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.deepPurple.shade700,
                                size: 29,
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildRowInListView({
    required String image,
    required var course,
  }) {
    return Row(
      children: [
        Image.asset(
          image,
          height: 70,
          width: 70,
        ),
        const SizedBox(
          width: 25,
        ),
        //    const Text('Course  :  ' , style: TextStyle(color: Colors.black , fontSize: 25),),
        Text(
          '$course ',
          style: const TextStyle(color: Colors.amber, fontSize: 25),
        ),
      ],
    );
  }
}
