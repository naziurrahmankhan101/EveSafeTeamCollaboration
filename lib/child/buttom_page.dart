import 'package:after_marjana/child/bottom_screens/chat_page.dart';
import 'package:after_marjana/child/bottom_screens/child_home_page.dart';
import 'package:after_marjana/child/bottom_screens/contacts_page.dart';
import 'package:after_marjana/child/bottom_screens/profile_page.dart';
import 'package:after_marjana/child/bottom_screens/rating_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({super.key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int currentIndex=0;
  List<Widget> pages =[
    HomeScreen(),
    ContactsPage(),
    ChatPage(),
    ProfilePage(),
    ReviewPage()
  ];
  onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
     // color:Colors.black,
      child: Scaffold(

        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: onTapped,
          items: [
            BottomNavigationBarItem(
              label: 'home',

                icon: Icon(

                  Icons.home,
                )),
            BottomNavigationBarItem(
              label: 'contacts',
                icon: Icon(
                  Icons.contacts,
                )),
            BottomNavigationBarItem(
              label: 'chat',
                icon: Icon(
                  Icons.chat,
                )),
            BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(
                  Icons.person,
                )),
            BottomNavigationBarItem(
                label: 'Reviews',
                icon: Icon(
                  Icons.reviews,
                )),

          ],),
      ),
    );
  }
}
