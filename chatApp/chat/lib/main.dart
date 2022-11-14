import 'package:chat/component/const.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:chat/screens/login_screen.dart';
import 'package:chat/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyChatApp());
}

class MyChatApp extends StatelessWidget {
  const MyChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: colorApp,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: colorApp,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home:  LoginScreen(),
     // home:  ChatScreen(),
    );
  }
}
