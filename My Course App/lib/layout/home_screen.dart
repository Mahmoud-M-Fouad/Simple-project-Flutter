import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_course/modules/add_course.dart';
import 'package:my_course/shared/cubit/app_cubit.dart';
import 'package:my_course/shared/cubit/app_states.dart';

import '../modules/all_courses.dart';
import '../modules/all_hour.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {


    List<Widget> Screens = [
       AddCourseScreen(),
      const AllCoursesScreen(),

    ];
    List<String> Titels = [
      'عرض كل الدروس الأسبوعية',
      'إضافة درس جديد',

    ];

    return BlocProvider(
      create: (BuildContext context) => AppBloc(),
      child: BlocConsumer<AppBloc, AppStates>(
        listener: (BuildContext context, states) {},
        builder: (BuildContext context, states) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: Text(Titels[currentIndex]),
                centerTitle: true,
                backgroundColor: Colors.teal.shade400,
                leading: IconButton(
                    onPressed: ()
                    {
                      setState(() {

                      });
                    },
                    icon: const Icon(Icons.refresh_outlined,size: 26,)),
              ),
              body: Screens[currentIndex],

              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.teal.shade400,
                showUnselectedLabels: false,
                selectedIconTheme: const IconThemeData(
                  color: Colors.white,
                  size: 25,
                ),
                selectedItemColor: Colors.white,
                currentIndex: currentIndex,
                onTap: (i) {
                  setState(() {
                    currentIndex = i;
                  });
                  //AppBloc.get(context).setIndex(index: i);
                  print(currentIndex);
                },
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add), label: 'إضافة درس'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'كل الدروس'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
