
import 'package:after_marjana/components/SecondaryButton.dart';
import 'package:after_marjana/components/custom_textfield.dart';
import 'package:after_marjana/register_child.dart';
import 'package:after_marjana/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/PrimaryButton.dart';



class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
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
                  title: "Register New User",
                  onPressed: (){
                  goTo(context, RegisterChildScreen());

              }),




                ],
      ),
            ),
          )),
    );
  }
}
