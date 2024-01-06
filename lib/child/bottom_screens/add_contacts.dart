import 'package:after_marjana/child/bottom_screens/contacts_page.dart';
import 'package:after_marjana/components/PrimaryButton.dart';
import 'package:after_marjana/db/db_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/contactsm.dart';

class AddContactsPage extends StatefulWidget {
  const AddContactsPage({super.key});

  @override
  State<AddContactsPage> createState() => _AddContactsPageState();
}

class _AddContactsPageState extends State<AddContactsPage> {
  DatabaseHelper databasehelper = DatabaseHelper();
  List<TContact>? contactList;
  int count =0;

  void showList(){
    Future<Database> dbFuture=databasehelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<TContact>> contactlistFuture= databasehelper.getContactList();
      contactlistFuture.then((value) {
        setState(() {
          this.contactList = value;
          this.count = value.length;
        });
      });

    });
  }

  void deleteContact(TContact contact) async{
    int result = await databasehelper.deleteContact(contact.id);
    if(result!=0){
      Fluttertoast.showToast(msg: "contact removed sucessfully");
      showList();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showList();
    });


    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    if(contactList==null){
      contactList=[];
    }
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            PrimaryButton(
                title: "Add trusted Contacts",
                onPressed: () async {
                 bool result= await Navigator.push
                    (context,
                      MaterialPageRoute(
                          builder: (context)=>ContactsPage(), ));
                 if(result==true){
                   showList();
                 }
                }),
            Expanded(
              child: ListView.builder(
                //shrinkWrap: true,
                itemCount: count,
                  itemBuilder: ( BuildContext context, int index){
                  return Card(
                    child:  ListTile(
                      title: Text(contactList![index].name),
                      trailing: IconButton(onPressed: () {
                        deleteContact(contactList![index]);
                      }, icon:Icon( Icons.delete ,
                      color: Colors.red,
                      )),
                    ),
                  );
                  },
              ),
            )
          ],
        ),
      ),
    );
  }
}
