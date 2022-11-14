

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:chat/screens/home.dart';
import 'package:chat/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../component/const.dart';
import '../component/function.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   GlobalKey<FormState> formKey = GlobalKey();

   bool isLoading = false;
   bool isPassword = true;

   TextEditingController mailController = TextEditingController(text: "");

   TextEditingController passController = TextEditingController(text: "");

   String? myMail;

   String? myPassword;
   checkMail()async
   {
     Future<UserCredential> userCredential = auth.signInWithEmailAndPassword(
       email: mailController.text.trim(),
       password: passController.text.trim(),
     );
     return userCredential;
   }

   loginMethod({required BuildContext context})async
   {

     try {
       return await checkMail();
     } on FirebaseAuthException catch (e) {
       if (e.code == 'user-not-found') {
         showAweSomeDialogYes(
           context: context,
           dialogType: DialogType.error,
           colorBorder: Colors.red,
           body: "No user found for that email.",
           funOk: () {
             setState(() {
               //isLoading = false;
             });
           },);
       } else if (e.code == 'wrong-password') {
         showAweSomeDialogYes(
           context: context,
           dialogType: DialogType.error,
           colorBorder: Colors.red,
           body: "Wrong password provided for that user.",
           funOk: () {
             setState(() {
               //isLoading = false;
             });
           },);
       }

     } catch (e) {
       print(e);
     }
     setState(() {
       isLoading = false;
     });

   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLogin,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 25,bottom: 15,right: 15,left: 15),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Center(child: Column(
                      children: [
                        Image.asset('assets/images/chat.png',height: 100,width: 100,),
                        const SizedBox(height: 5,),
                        Text('Scholar Chat',
                          style: myTextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.normal
                          ),),
                      ],
                    )),
                    const SizedBox(height: 35,),
                    Text('LOGIN',style: myTextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.normal
                    ),),
                    const SizedBox(height: 15,),
                    myTextFormField(
                        controller: mailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (data)
                        {
                          if(data.isEmpty) return 'Field is required';
                          if(!data.contains('@gmail.com')) return 'exampl@gmail.com';
                          if(data.startsWith('@gmail.com')) return 'exampl@gmail.com';
                        },
                        labelText: "Email",
                        onChanged: ( val)
                        {
                          myMail = val;
                        }
                    ),
                    const SizedBox(height: 10,),
                    myTextFormFieldForPass(
                      obscureText: isPassword,
                        onChangedPass: (){
                        setState(() {
                          isPassword = ! isPassword;
                        });
                        },
                        controller: passController,
                        keyboardType: TextInputType.text,
                        labelText: "Password",
                        validator: (data)
                        {
                          if(data.isEmpty) return 'Field is required';
                          if(data.length<5) return 'password very week';
                        },
                        onChanged: (val)
                        {
                          myPassword = val;
                        }
                    ),
                    const SizedBox(height: 10,),
                    myButton(
                        onTap: () async{
                          if(formKey.currentState!.validate())
                          {
                            formKey.currentState!.save();
                            setState(() {
                              isLoading = true;
                            });
                            if(await loginMethod(context: context)!=null)
                            {
                              /*
                                  addOwner(
                                      context: context,
                                      mail: FirebaseAuth.instance.currentUser!.email.toString(),
                                      name: myUsername,
                                      pass: myPassword
                                  );
                                  */
                              setState(() {
                                isLoading = false;
                              });
                              showAweSomeDialogYes(
                                  context: context,
                                  dialogType: DialogType.success,
                                  colorBorder: Colors.green,
                                  body: "Login Succeeded",
                                  funOk: () {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    nextScreenToEnd(context: context, screen:  ChatScreen());
                                  },);
                            }
                         }
                        },
                        textChild: "Login"
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account ? ',
                          style: myTextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.normal
                          ),),
                        InkWell(
                          onTap: ()
                          {
                            nextScreenToEnd(
                                context: context,
                                screen: RegisterScreen()
                            );
                          },
                          child: Text(' Register',
                            style: myTextStyle(
                                fontSize: 22,
                                color: const Color(0xffC7EDE6),
                                fontWeight: FontWeight.normal
                            ),),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


