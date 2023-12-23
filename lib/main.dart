import 'package:after_marjana/child/child_login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:after_marjana/home_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyAIwzoBWe4ITQGxELWuGdlYSAMyBpUNpiU",
        appId: "1:451228334146:android:38b4425dc5659aa78795db",
        messagingSenderId: "451228334146",
        projectId: "evesafe-86e8f",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: GoogleFonts.firaSansCondensedTextTheme(
              Theme.of(context).textTheme,
            ),
            primarySwatch: Colors.blue
        ),

        home: LoginScreen());
  }
}

