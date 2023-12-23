import 'package:after_marjana/child/child_login_screen.dart';
import 'package:after_marjana/utils/constants.dart';
import 'package:flutter/material.dart';

import '../components/PrimaryButton.dart';
import '../components/SecondaryButton.dart';
import '../components/custom_textfield.dart';

class RegisterParentScreen extends StatefulWidget {
  @override
  State<RegisterParentScreen> createState() => _RegisterParentScreenState();
}

class _RegisterParentScreenState extends State<RegisterParentScreen> {
  bool isPasswordShown=true;

  final _formKey= GlobalKey<FormState>();

  final _formData = Map<String,Object>();

  _onSubmit(){
    _formKey.currentState!.save();
    print(_formData['email']);
    print(_formData['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Transform.scale(
                        scale:2,
                        child: Image.asset(
                          'assets/evesafe.png',
                          height: 100,
                          width: 100,
                        ),
                      ),
                      Text(
                        "Register as Guardian",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,

                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.9,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomTextField(
                          hintText: "Enter name",
                          textInputAction: TextInputAction.next,
                          keyboardtype: TextInputType.name,
                          prefix: Icon(Icons.person_2_rounded),
                          onsave: (name) {
                            _formData['name'] = name ?? "";
                          },
                          validate: (email) {
                            if(email!.isEmpty || email.length<3 ){
                              return "enter correct name";
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          hintText: "Enter phone",
                          textInputAction: TextInputAction.next,
                          keyboardtype: TextInputType.phone,
                          prefix: Icon(Icons.phone),
                          onsave: (phone) {
                            _formData['phone'] = phone ?? "";
                          },
                          validate: (email) {
                            if(email!.isEmpty || email.length<10 ){
                              return "enter correct phone";
                            }
                            return null;
                          },
                        ),
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
                          hintText: "Enter User E-mail",
                          textInputAction: TextInputAction.next,
                          keyboardtype: TextInputType.emailAddress,
                          prefix: Icon(Icons.person_2_rounded),
                          onsave: (uemail) {
                            _formData['uemail'] = uemail ?? "";
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
                        CustomTextField(
                          hintText: "Re-type Password",
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
                            title: "Confirm Registration",
                            onPressed: (){
                              if(_formKey.currentState!.validate()){
                                _onSubmit();
                              }

                            }),
                      ],
                    ),
                  ),
                ),


                //SecondaryButton(title: "Forgot Password? Click Here", onPressed: (){}),
                SecondaryButton(
                    title: "Login with your account",
                    onPressed: (){
                      goTo(context, LoginScreen());

                    }),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
