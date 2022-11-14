import 'package:chat/component/const.dart';
import 'package:chat/component/function.dart';
import 'package:chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("Home Screen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async {
          await auth.signOut().then((value){
            nextScreenToEnd(context: context, screen: LoginScreen());
          });
        },
        child: const Icon(Icons.logout_outlined),
      ),
    );
  }
}
