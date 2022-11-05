import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import '../shared/component/db.dart';

class AllCourse extends StatefulWidget {
  const AllCourse({Key? key}) : super(key: key);

  @override
  State<AllCourse> createState() => _AllCourseState();
}

class _AllCourseState extends State<AllCourse> {

  String selectedValue = "السبت";
  var cousrelist;
  bool i =false;
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

  void showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(

      const SnackBar(

        content: Text('لا يوجد أى درس هذا اليوم' , style: TextStyle(color: Colors.red),),
      ),
    );
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
   //  scrollDirection: Axis.vertical,
      child: Column(
     // mainAxisAlignment: MainAxisAlignment.start,
       // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 55,
            child: Row(
              children: [
                IconButton(
                    onPressed: ()
                    {
                      setState(() {

                      });
                    },
                    icon: const Icon(Icons.arrow_downward,size: 26,)),
                Expanded(
                  child: Center(
                    child: DropdownButton(
                      dropdownColor: Colors.teal.shade400,
                      style: const TextStyle(fontSize: 20 , color: Colors.black , ),//backgroundColor:Colors.lightBlue.shade900,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      value: selectedValue,
                      items: dropdownItems,
                      onTap: ()
                      {
                        setState(() {

                        });
                      },

                      onChanged: (String? value) async {
                        setState(()   {
                          selectedValue = value!;
                         // FlutterClipboard.copy(selectedValue).then(( value ) => print('copied'));
                          print( selectedValue);
                        });

                        if (await Check_course_day(selectedValue))
                          {
                            cousrelist =  await course(selectedValue);
                          }
                        else {
                          cousrelist = [];
                          showToast(context);
                        }

                        print( cousrelist);
                        // print(cousrelist[0].name);
                      },
                    ),
                  ),
                ),

              ],
            ),
          ),
           cousrelist?.isEmpty ==null?Container():
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context , index)
            {
              return  bulidContainerCourse(index);
            },
            separatorBuilder: (context , index)
            {
              return const SizedBox(height: 10,);
            },
            itemCount: cousrelist.length,
            // shrinkWrap: true,

          )
        ],
      ),
    );
  }

  Widget bulidContainerCourse(int index)
  {
    return Padding(
      padding: const EdgeInsets.only(right: 10 , left: 15 , top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(15),
              height: 550,
              decoration:  BoxDecoration(
                color: Colors.teal.shade400,
                borderRadius: const BorderRadius.all(
                    Radius.circular(15) //                 <--- border radius here
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Image.asset('image/man.png',height: 100,width: 100,),
                  Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(

                        children: [
                          Image.asset('image/open-book.png',height: 70,width: 70,),
                          const SizedBox(width: 25,),
                      //    const Text('Course  :  ' , style: TextStyle(color: Colors.black , fontSize: 25),),
                          Text('${cousrelist[index].name} ' , style: const TextStyle(color: Colors.amber , fontSize: 25),),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      const Divider(height: 3,color: Colors.deepPurple,),
                      const SizedBox(height: 10,),

                      Row(
                        children: [
                          Image.asset('image/presentation.png',height: 70,width: 70,),
                          const SizedBox(width: 25,),
                          //const Text('Teacher  :  ' , style: TextStyle(color: Colors.black , fontSize: 25),),
                          Text('${cousrelist[index].teacher} ' , style: const TextStyle(color: Colors.amber , fontSize: 25),),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      const Divider(height: 3,color: Colors.deepPurple,),
                      const SizedBox(height: 10,),


                      Row(
                        children: [
                          Image.asset('image/calendar.png',height: 70,width: 70,),
                          const SizedBox(width: 25,),
                          //const Text('Day  :  ' , style: TextStyle(color: Colors.black , fontSize: 25),),
                          Text('${cousrelist[index].day} ' , style: const TextStyle(color: Colors.amber , fontSize: 25),),
                        ],
                      ),

                      const SizedBox(height: 10,),
                      const Divider(height: 3,color: Colors.deepPurple,),
                      const SizedBox(height: 10,),

                      Row(
                        children: [
                          Image.asset('image/clock.png',height: 70,width: 70,),
                          const SizedBox(width: 25,),
                          //const Text('Hour  :  ' , style: TextStyle(color: Colors.black , fontSize: 25),),
                          Text('${cousrelist[index].hour} ' , style: const TextStyle(color: Colors.amber , fontSize: 25),),
                        ],
                      ),

                      const SizedBox(height: 10,),
                      const Divider(height: 3,color: Colors.deepPurple,),
                      const SizedBox(height: 10,),

                      Row(
                        children: [
                          Image.asset('image/phone-call.png',height: 70,width: 70,),
                          const SizedBox(width: 25,),
                          //const Text('Phone  :  ' , style: TextStyle(color: Colors.black , fontSize: 25),),
                          Text('${cousrelist[index].phone} ' , style: const TextStyle(color: Colors.amber , fontSize: 25),),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      const Divider(height: 3,color: Colors.deepPurple,),
                      const SizedBox(height: 10,),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${cousrelist[index].id} ' , style: const TextStyle(color: Colors.black , fontSize: 25),),
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
  Widget bulidListview()
  {
    return  ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context , index)
      {
        return  bulidContainerCourse(index);
      },
      separatorBuilder: (context , index)
      {
        return const SizedBox(height: 10,);
      },
      itemCount: cousrelist.length,
      // shrinkWrap: true,

    );
  }

}
