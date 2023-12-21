import 'package:after_marjana/components/PrimaryButton.dart';
import 'package:after_marjana/components/SecondaryButton.dart';
import 'package:after_marjana/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:after_marjana/components/custom_textfield.dart';
import 'custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "USER LOGIN",
                  style: TextStyle(fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),

                //Image.asset(
                 // 'assets/EveSafeLight.png',
                //height: 100,
                //width: 100,
                //),
                Transform.scale(
                  scale: 2.0,
                  child: Image.asset(
                    'assets/evesafe.png',
                    height: 100,
                    width: 100,
                  ),
                ),







                CustomTextField(
                  hintText: 'enter name',
                  prefix: Icon(Icons.person),
                ),
                CustomTextField(
                  hintText: 'enter password',
                  prefix: Icon(Icons.person),
                ),
                PrimaryButton(title: 'REGISTER', onPressed: () {}),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(fontSize: 18),

                    ),
                    SecondaryButton(title: 'click here', onPressed: (){}),
                  ],
                ),
                SecondaryButton(title: 'Register new user', onPressed: (){})

              ],
            ),
          )),
    );
  }
}

