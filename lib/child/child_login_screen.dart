
import 'package:after_marjana/components/SecondaryButton.dart';
import 'package:after_marjana/components/custom_textfield.dart';
import 'package:after_marjana/child/register_child.dart';
import 'package:after_marjana/db/share_pref.dart';
import 'package:after_marjana/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/PrimaryButton.dart';
import '../home_screen.dart';
import '../parent/parent_home_screen.dart';
import '../parent/parent_register_screen.dart';



class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordShown=true;
  final _formKey= GlobalKey<FormState>();
  final _formData = Map<String,Object>();
  bool isLoading=false;

  _onSubmit() async{
    _formKey.currentState!.save();
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: _formData['email'].toString(),
          password: _formData['password'].toString());
      if (userCredential.user!=null){
        setState(() {
          isLoading = false;
        });
        FirebaseFirestore.instance.
        collection('users')
        .doc(userCredential.user!.uid)
        .get()
        .then((value) {
          if(value['type']=='parent'){
            print(value['type']);
            MySharedPrefference.saveUserType('parent');
            goTo(context, ParentHomeScreen());
          }else{
            MySharedPrefference.saveUserType('child');
            goTo(context, HomeScreen());
          }
        });

      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'user-not-found') {
        dialogueBox(context, 'No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        dialogueBox(context, 'Wrong password provided for that user.' );
        print('Wrong password provided for that user.');
      }
    }
    print(_formData['email']);
    print(_formData['password']);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                isLoading
                    ?progressIndicator(context):
                SingleChildScrollView(
                  child: Column(
                   //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "         ",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,

                              ),
                            ),
                            Transform.scale(
                              scale:3.5,
                              child: Image.asset(
                                'assets/evesafe.png',
                                height: 100,
                                width: 100,
                              ),
                            ),
                          ],
                        ),
                      ),


                  Container(
                    height: MediaQuery.of(context).size.height*0.4,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomTextField(
                            hintText: "Enter E-mail",
                            textInputAction: TextInputAction.next,
                            keyboardtype: TextInputType.emailAddress,
                            prefix: Icon(Icons.person_2_rounded),
                            onsave: (email) {
                              _formData['email'] = email ?? "";
                            },
                            validate: (email) {
                              if(email!.isEmpty || email.length<3 || !email.contains("@")){
                                return "enter correct email";
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            hintText: "Enter Password",
                            isPassword: isPasswordShown,
                            prefix: Icon(Icons.lock_open_outlined),
                            //onsave: () {},
                            onsave: (password) {
                              _formData['password'] = password ?? "";
                            },
                            validate: (password) {
                              if(password!.isEmpty || password.length<7 ){
                                return "enter correct password";
                              }
                              return null;
                            },
                            suffix: IconButton(onPressed: (){
                              setState(() {
                                isPasswordShown = !isPasswordShown;
                              });

                            }, icon: isPasswordShown
                                ?Icon(Icons.visibility_off)
                                :Icon(Icons.visibility)),
                          ),
                          PrimaryButton(
                            title: "Login",
                              onPressed: (){
                              //progressIndicator(context);
                              if(_formKey.currentState!.validate()){
                                _onSubmit();
                              }

                          }),
                        ],
                      ),
                    ),
                  ),


                  SecondaryButton(title: "Forgot Password? Click Here", onPressed: (){}),
                  SecondaryButton(
                      title: "Register as User",
                      onPressed: (){
                      goTo(context, RegisterChildScreen());

                  }),
                   SecondaryButton(
                          title: "Register as Guardian",
                          onPressed: (){
                            goTo(context, RegisterParentScreen());

                          }),




                    ],
      ),
                ),
              ],
            ),
          )),
    );
  }
}
