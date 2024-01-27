

import 'dart:math';

import 'package:after_marjana/components/PrimaryButton.dart';
import 'package:after_marjana/components/SecondaryButton.dart';
import 'package:after_marjana/components/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:after_marjana/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ReviewPage extends StatefulWidget{
  @override
  State<ReviewPage> createState() =>_ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage>{
  TextEditingController locationC = TextEditingController();
  TextEditingController viewsC = TextEditingController();
  bool isSaving=false;
 showAlert(BuildContext context){
   showDialog(context: context, builder: (_) {
     return AlertDialog(
       title: Text("Review your place"),
       content: Form(child:
         Column(children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: CustomTextField(
               hintText: 'enter location',
               controller: locationC,
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: CustomTextField(
               controller: viewsC,
               hintText: 'enter location',
               maxLines: 3,
             ),
           ),
         ],)),
       actions: [
         PrimaryButton(title: "Save", onPressed: () {saveReview();
           Navigator.pop(context);
         }
         ),
         TextButton( child: Text("Cancel"),onPressed: () {
          Navigator.pop(context);
         }),
       ],
     );
   });
 }
saveReview() async{
   setState(() {
     isSaving=true;
   });
   await FirebaseFirestore.instance.collection('reviews').add({
     'location':locationC.text,
     'views':viewsC.text}).then((value){
       setState(() {
         isSaving=false;
         Fluttertoast.showToast(msg: 'review uploaded successfully');

       });
   });
}
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: isSaving == true
         ?  Center(child: CircularProgressIndicator())
      : SafeArea(
        child: Column(
          children: [

        Text(
             "Recent review by others",
          style: TextStyle(fontSize: 30,color: Colors.black),
        ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('reviews').snapshots(),

                builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator());
                  }
                 return ListView.builder(
                     itemCount:snapshot.data!.docs.length,
                     itemBuilder: (BuildContext context, int index){
                       final data=snapshot.data!.docs[index];
                       return Padding(
                         padding: const EdgeInsets.all(3.0),
                         child: Card(
                           elevation: 10,
                           //color: Colors.primaries[Random().nextInt(17)],
                           child: ListTile(title:
                           Text(data['location'],
                             style: TextStyle(fontSize: 20,color: Colors.black),
                           ),
                             subtitle: Text(data['views']),
                           ),

                         ),
                       );
                     },
                 );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple.shade300,
        onPressed: () {
          showAlert(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
