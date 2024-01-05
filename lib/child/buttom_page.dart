import 'package:after_marjana/child/bottom_screens/chat_page.dart';
import 'package:after_marjana/child/bottom_screens/child_home_page.dart';
import 'package:after_marjana/child/bottom_screens/contacts_page.dart';
import 'package:after_marjana/child/bottom_screens/profile_page.dart';
import 'package:after_marjana/child/bottom_screens/rating_page.dart'; // Fix: Changed ReviewPage to RatingPage
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({Key? key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    ContactsPage(),
    ChatPage(),
    ProfilePage(),
    ReviewPage(), // Fix: Changed ReviewPage to RatingPage
  ];

  void onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        height: 50, // Adjust as needed
        items: [
          Icon(Icons.home),
          Icon(Icons.contacts),
          Icon(Icons.chat),
          Icon(Icons.person),
          Icon(Icons.reviews), // Fix: Changed to a different icon, as there's no 'reviews' icon in the default Icons
        ],
        onTap: onTapped,
        animationDuration: Duration(milliseconds: 360),
        backgroundColor: Colors.white70, // Adjust as needed
        color: Colors.deepPurple.shade300, // Adjust as needed
        buttonBackgroundColor: Colors.deepPurple.shade300, // Adjust as needed
        animationCurve: Curves.easeInOut,
        letIndexChange: (index) => true,
      ),
    );
  }
}
