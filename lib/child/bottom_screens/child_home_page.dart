import 'dart:math';


import 'package:after_marjana/widgets/home_widgets/emergency.dart';
import 'package:after_marjana/widgets/home_widgets/live_safe.dart';
import 'package:after_marjana/widgets/home_widgets/safehome/SafeHome.dart';
import 'package:flutter/material.dart';
import 'package:after_marjana/widgets/home_widgets/custom_appBar.dart';

import '../../widgets/home_widgets/CustomCarouel.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//  const HomeScreen({super.key});
  int qindex =0;

  getRandomQuote(){
    Random random = Random();
    setState(() {
      qindex=random.nextInt(6);
    });

  }

  @override
  void initState() {
    getRandomQuote();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              CustomAppBar(
                quoteIndex: qindex,
                onTap: getRandomQuote(),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    CustomCarouel(),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("Emergency",
                        style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),
                      ),
                    ),

                    Emergency(),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("Explore LiveSafe",
                        style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),
                      ),
                    ),
                    LiveSafe(),
                    SafeHome(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

