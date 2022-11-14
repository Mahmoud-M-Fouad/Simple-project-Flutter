import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat/component/chat_function.dart';
import 'package:chat/component/const.dart';
import 'package:chat/component/function.dart';
import 'package:chat/screens/home.dart';
import 'package:chat/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ChatScreen extends StatelessWidget {
   ChatScreen({Key? key}) : super(key: key);
   TextEditingController controller = TextEditingController();
   ScrollController scrollController = ScrollController();
  var messages = fireStore.collection('messages');
  late String myMsg;
  String? myMsgTo = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorApp,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/chat.png',height: 40,),
            const SizedBox(width: 10,),
            Text('Scholar Chat'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              // FirebaseAuth.instance.currentUser!.email.toString()
              stream: fireStore.collection('messages').
              orderBy('createdAt',descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData&&snapshot.data!=null) {
                  return ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context , index)
                    {
                      return snapshot.data!.docs[index]!['id']==FirebaseAuth.instance.currentUser!.email?
                      buildContainerSender(list: snapshot.data!.docs[index]!['message']):
                      buildContainerReceiver(list: snapshot.data!.docs[index]!['message']);
                    },
                  );
                }
                if (snapshot.hasError) {
                  return const Text("يوجد خطأ");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Center(
                    child: Column(
                      children: const  [
                        CircularProgressIndicator(),
                        SizedBox(height: 20,),
                        Text("تحميل ....")
                      ],
                    ),
                  );
                }
                return Container();
              }
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextFormField(
              controller: controller,
              onFieldSubmitted: (String msg)
              {
                myMsg = msg;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: colorApp,
                  ),
                ),
                suffixIcon: IconButton(onPressed: (){
                  if(controller.text.isNotEmpty)
                    {
                      //messages.doc(getUserID).set
                      messages.add({
                        'message':controller.text,
                        'createdAt' : DateTime.now(),
                        'id' : FirebaseAuth.instance.currentUser!.email.toString().trim(),
                      }).then((value) => {
                        controller.clear(),
                        scrollController.animateTo(
                            scrollController.position.minScrollExtent,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn)
                      });
                    }
                }, icon: const Icon(Icons.send)),
                hintText: "Send Message",
              ),
            ),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: colorApp,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Scholar Chat",style : myTextStyle(color: Colors.white, fontSize: 22,fontWeight: FontWeight.normal)),
              accountEmail: Text(FirebaseAuth.instance.currentUser!.email.toString(),style: myTextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.normal),),
              currentAccountPicture: const CircleAvatar(
                radius: 200,
                backgroundImage: AssetImage('assets/images/chat.png'),
              ),
            ),
            ListTile(
              leading: IconButton(icon: const Icon(Icons.exit_to_app,color: Colors.white,),onPressed: (){}),
              title: Text("Log Out",style: myTextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.normal),),
              onTap: () {
                FirebaseAuth.instance.signOut().then((value){
                  nextScreenToEnd(context: context, screen: LoginScreen());
                });

              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: StreamBuilder(
                  stream: fireStore.collection('users').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData&&snapshot.data!=null) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context , index)
                        {
                          return
                            snapshot.data!.docs[index]!['mail']==FirebaseAuth.instance.currentUser!.email?Container():
                            ListTile(
                            leading: IconButton(icon: const Icon(Icons.mail,color: Colors.white,),onPressed: (){}),
                            title: Text(snapshot.data!.docs[index]!['mail'],style: myTextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.normal),),
                            onTap: () {
                              FirebaseAuth.instance.signOut().then((value){
                                auth.signInWithEmailAndPassword(
                                  email: snapshot.data!.docs[index]!['mail'].toString().trim(),
                                  password: snapshot.data!.docs[index]!['pass'].toString().trim(),
                                ).then((value){
                                  showAweSomeDialogYes(
                                    context: context,
                                    dialogType: DialogType.success,
                                    colorBorder: Colors.green,
                                    body: "Switched Login Succeeded",
                                    funOk: () {
                                      nextScreenToEnd(context: context, screen:  ChatScreen());
                                    },);
                                });
                              });
                            },
                          );
                        },
                      );

                    }
                    if (snapshot.hasError) {
                      return const Text("يوجد خطأ");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return  Center(
                        child: Column(
                          children: const  [
                            CircularProgressIndicator(),
                            SizedBox(height: 20,),
                            Text("تحميل ....")
                          ],
                        ),
                      );
                    }
                    return Container();
                  }
              ),
            ),


          ],
        ),
      )

    );
  }
}
