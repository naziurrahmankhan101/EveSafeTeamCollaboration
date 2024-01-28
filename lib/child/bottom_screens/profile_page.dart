import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:after_marjana/child/child_login_screen.dart';
import 'package:after_marjana/components/PrimaryButton.dart';
import 'package:after_marjana/components/custom_textfield.dart';
import 'package:after_marjana/utils/constants.dart';

class CheckUserStatusBeforeChatOnProfile extends StatelessWidget {
  const CheckUserStatusBeforeChatOnProfile({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          if (snapshot.hasData) {
            return ProfilePage();
          } else {
            Fluttertoast.showToast(msg: 'Please login first');
            return LoginScreen();
          }
        }
      },
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameC = TextEditingController();
  final key = GlobalKey<FormState>();
  bool isSaving = false;

  getDate() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        nameC.text = value.docs.first['name'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isSaving == true
          ? Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.pink,
        ),
      )
          : SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Form(
              key: key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "UPDATE YOUR PROFILE",
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                    controller: nameC,
                    hintText: nameC.text,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return 'Please enter your updated name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 25),
                  PrimaryButton(
                    title: "UPDATE",
                    onPressed: () async {
                      if (key.currentState!.validate()) {
                        SystemChannels.textInput
                            .invokeMethod('TextInput.hide');
                        update();
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  PrimaryButton(
                    title: "SIGN OUT",
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      } catch (e) {
                        print("Error signing out: $e");
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  update() async {
    setState(() {
      isSaving = true;
    });

    Map<String, dynamic> data = {
      'name': nameC.text,
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(data);

    setState(() {
      isSaving = false;
    });
  }
}
