import 'dart:html';

import 'package:after_marjana/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {

  @override
  void initState(){
    super.initState();
    askPermissions();
  }


  Future<void> askPermissions() async{
    PermissionStatus permissionStatus= await getContactsPermissions();

    if(permissionStatus==PermissionStatus.granted){

    }else{
      handInvalidPermission(permissionStatus);
    }
  }

  handInvalidPermission(PermissionStatus permissionStatus){
    if(permissionStatus==PermissionStatus.denied){
      dialogueBox(context, "Access is denied");
    }else if(permissionStatus == PermissionStatus.permanentlyDenied){
      dialogueBox(context, "Contact doesn't exist");
    }
  }

  Future<PermissionStatus> getContactsPermissions() async{
    PermissionStatus permission= await Permission.contacts.status;
    if(permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    }else
      return permission;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Contact Page")),
    );
  }
}
