import 'package:flutter/material.dart';
import 'package:my_course/shared/component/db.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_course/shared/component/shared_preferences.dart';
import 'package:my_course/shared/cubit/app_cubit.dart';
import 'package:my_course/shared/cubit/app_states.dart';
import 'layout/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  CreateDatabase();
  await SharedClass.inti();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomeScreen(),
    );
  }
}

