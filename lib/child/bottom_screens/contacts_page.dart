
import 'package:after_marjana/utils/constants.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> contacts=[];
  @override
  void initState(){
    super.initState();
    askPermissions();
  }


  Future<void> askPermissions() async{
    PermissionStatus permissionStatus= await getContactsPermissions();

    if(permissionStatus==PermissionStatus.granted){
       getAllContacts();
    }else{
      handInvaliedPermissions(permissionStatus);
    }
  }

  handInvaliedPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      dialogueBox(context, "Access to the contacts denied by the user");
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      dialogueBox(context, "May contact does exist in this device");
    }
  }

  Future<PermissionStatus> getContactsPermissions() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  getAllContacts() async{
    List<Contact> _contacts= await ContactsService.getContacts();

    setState(() {
      contacts=_contacts;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: contacts.length == 0
      ? Center(child: CircularProgressIndicator())
      : ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (BuildContext context, int index){
          Contact contact=contacts[index];
          return ListTile(
            title: Text(contact.displayName!),
          );
        },
      )
    );
  }
}
