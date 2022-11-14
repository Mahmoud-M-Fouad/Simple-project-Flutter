import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Color colorApp = const Color(0xff2B475E);
Color colorLogin =  Colors.cyan.shade900;

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore fireStore = FirebaseFirestore.instance;
User? getUser = FirebaseAuth.instance.currentUser;
String getUserID = FirebaseAuth.instance.currentUser!.uid;
Future<void> exitApp = FirebaseAuth.instance.signOut();

