import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/helper/api.dart';
import 'package:shop/helper/const.dart';
import 'package:shop/screens/add_product.dart';
import 'package:shop/screens/home_page.dart';
import 'package:shop/screens/update_product.dart';

void main() {
  runApp(const MyStoreApp());
}

class MyStoreApp extends StatelessWidget {
  const MyStoreApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomePage.id : (context)=> const HomePage(),
        UpdateProductScreen.id : (context)=> UpdateProductScreen(),
        AddProductScreen.id : (context)=> AddProductScreen(),
      },
      initialRoute: HomePage.id,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     // home: const MyHomePage(),
    );
  }
}

