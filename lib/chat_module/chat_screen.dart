import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:after_marjana/chat_module/message_text_field.dart';
import 'package:after_marjana/chat_module/singleMessage.dart';

import '../utils/constants.dart';

class ChatScreen extends StatefulWidget {
  final String currentUserId;
  final String friendId;
  final String friendName;

  const ChatScreen({
    Key? key,
    required this.currentUserId,
    required this.friendId,
    required this.friendName,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? type;
  String? myname;

  // Add ScrollController
  ScrollController _scrollController = ScrollController();

  getStatus() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.currentUserId)
        .get()
        .then((value) {
      setState(() {
        type = value.data()!['type'];
        myname = value.data()!['name'];
      });
    });
  }

  @override
  void initState() {
    getStatus();

    // Add listener for scroll controller
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.minScrollExtent) {
        // Scrolled to the top, do something if needed
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: Text(widget.friendName),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.currentUserId)
                  .collection('messages')
                  .doc(widget.friendId)
                  .collection('chats')
                  .orderBy('date', descending: true) // Set descending to true
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.length < 1) {
                    return Center(
                      child: Text(
                        type == "parent"
                            ? "TALK WITH CHILD"
                            : "TALK WITH PARENT",
                        style: TextStyle(fontSize: 30),
                      ),
                    );
                  }
                  return Container(
                    child: ListView.builder(
                      controller: _scrollController, // Pass the controller
                      reverse: true, // Set reverse to true
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool isMe =
                            snapshot.data!.docs[index]['senderId'] ==
                                widget.currentUserId;
                        final data = snapshot.data!.docs[index];
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) async {
                            // Your delete logic...
                          },
                          child: SingleMessage(
                            message: data['message'],
                            date: data['date'],
                            isMe: isMe,
                            friendName: widget.friendName,
                            myName: myname,
                            type: data['type'],
                          ),
                        );
                      },
                    ),
                  );
                }
                return progressIndicator(context);
              },
            ),
          ),
          MessageTextField(
            currentId: widget.currentUserId,
            friendId: widget.friendId,
          ),
        ],
      ),
    );
  }
}
