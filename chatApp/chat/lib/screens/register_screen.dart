import 'dart:ffi';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../component/const.dart';
import '../component/function.dart';

class RegisterScreen extends StatefulWidget {
   RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
   GlobalKey<FormState> formKey = GlobalKey();

  String? myMail;
  String? myPassword;

  String? myConfirmPassword;
   bool isPassword = true;
  bool isLoading = false;

  TextEditingController mailController = TextEditingController(text: "");

  TextEditingController passController = TextEditingController(text: "");

  TextEditingController conPassController = TextEditingController(text: "");

  createMail()async
  {
     Future<UserCredential> userCredential = auth.createUserWithEmailAndPassword(
      email: mailController.text.trim(),
      password: passController.text.trim(),
    );
    return userCredential;
  }

  registerMethod({required BuildContext context})async
  {

    try {
     return await createMail();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showAweSomeDialogYes(
          context: context,
          dialogType: DialogType.error,
          colorBorder: Colors.red,
          body: "The password provided is too weak.",
          funOk: () {
            setState(() {
              //isLoading = false;
            });
          },);
      } else if (e.code == 'email-already-in-use') {
        showAweSomeDialogYes(
          context: context,
          dialogType: DialogType.error,
          colorBorder: Colors.red,
          body: "The account already exists for that email.",
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
                    Text('REGISTER',style: myTextStyle(
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
                    myTextFormFieldForPass(
                        obscureText: isPassword,
                        onChangedPass: (){
                          setState(() {
                            isPassword = ! isPassword;
                          });
                        },
                        controller: conPassController,
                        keyboardType: TextInputType.text,
                        validator: (data)
                        {
                          if(data.isEmpty) return 'Field is required';
                          if(data.length<5) return 'password very week';
                        },
                        labelText: "Confirm Password",
                        onChanged: (val)
                        {
                          myConfirmPassword = val;
                        }
                    ),
                    const SizedBox(height: 10,),
                    myButton(
                        onTap: () async{
                          if(formKey.currentState!.validate())
                            {
                              formKey.currentState!.save();
                              if(passController.text==conPassController.text)
                              {
                                setState(() {
                                  isLoading = true;
                                });

                               // var user =  await registerMethod(context: context);
                                if(await registerMethod(context: context)!=null)
                                {
                                  fireStore.collection('users').add({
                                    "mail" : mailController.text.trim(),
                                    "pass" : passController.text.trim(),
                                  });
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
                                    body: "Register Succeeded",
                                    funOk: () {
                                      setState(() {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        nextScreenToEnd(context: context, screen: LoginScreen());
                                      });
                                    },);

                                }
                              }
                              else
                              {
                                showAweSomeDialogYes(
                                  context: context,
                                  dialogType: DialogType.error,
                                  colorBorder: Colors.red,
                                  body: "The password not equal",
                                  funOk: () {
                                    setState(() {
                                      //isLoading = false;
                                    });
                                  },);
                              }

                            }
                        },
                        textChild: "Register"
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('already have an account ? ',
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
                                screen: LoginScreen()
                              //RegisterScreen()
                            );
                          },
                          child: Text(' Login',
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
