//import 'dart:io';

import 'package:flutter/material.dart';

Color primaryColor = Color(0xbe346cc9);

void goTo(BuildContext context, Widget nextScreen) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ));
}

dialogueBox(BuildContext context, String text){
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(text),
    ),
  );
}

/*progressIndicator(BuildContext context){
  showDialog(
     barrierDismissible: false,
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator(
        backgroundColor: primaryColor,
        color: Colors.black38,
        strokeWidth: 7,
      ))
  );
}*/

/*dialogueBox(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(text),
    ),
  );
}*/

Widget progressIndicator(BuildContext context) {
  return Center(
      child: CircularProgressIndicator(
        backgroundColor: primaryColor,
        color: Colors.black,
        strokeWidth: 7,
      ));
}

