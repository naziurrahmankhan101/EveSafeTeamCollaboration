import 'package:after_marjana/components/SecondaryButton.dart';
import 'package:after_marjana/components/custom_textfield.dart';
import 'package:after_marjana/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/PrimaryButton.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "USER LOGIN",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,

                  ),
                ),
                Transform.scale(
                  scale:2.5,
                  child: Image.asset(
                    'assets/evesafe.png',
                    height: 100,
                    width: 100,
                  ),
                ),

                CustomTextField(
                  hintText: "Enter Name",
                  prefix: Icon(Icons.person_2_rounded),
                ),
                CustomTextField(
                  hintText: "Enter Password",
                  prefix: Icon(Icons.lock_open_outlined),
                ),
                PrimaryButton(title: "Register", onPressed: (){}),

                SecondaryButton(title: "Register New User", onPressed: (){}),

                SecondaryButton(title: "Forgot Password?", onPressed: (){})




              ],
            ),
          )),
    );
  }
}
