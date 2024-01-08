  import 'package:after_marjana/child/buttom_page.dart';
import 'package:after_marjana/child/child_login_screen.dart';
import 'package:after_marjana/db/share_pref.dart';
import 'package:after_marjana/parent/parent_home_screen.dart';
import 'package:after_marjana/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:after_marjana/child/bottom_screens/child_home_page.dart';
import 'package:after_marjana/child/buttom_page.dart';
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
  await MySharedPrefference.init();
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

        home: FutureBuilder(
    future: MySharedPrefference.getUserType(),

    builder: (BuildContext context, AsyncSnapshot snapshot){

      if(snapshot.data==""){
        return LoginScreen();
      }
      if(snapshot.data=="child"){
        return BottomPage();
      }
      if(snapshot.data=="parent"){
        return ParentHomeScreen();
      }

      return progressIndicator(context);
    },
        ),
    );
  }
}

//testing

/*class CheckAuth extends StatelessWidget {
  const CheckAuth({super.key});

  checkData(){
    if(MySharedPrefference.getUserType()=='parent'){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//testing2
    ghjjhjhggjhgjh);
  }
}*/
