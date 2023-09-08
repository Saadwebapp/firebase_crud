import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../auth/LoginScreen.dart';

class Admin_screen extends StatefulWidget {
  const Admin_screen({Key? key}) : super(key: key);

  @override
  State<Admin_screen> createState() => _Admin_screenState();
}

class _Admin_screenState extends State<Admin_screen> {
  final auth = FirebaseAuth.instance;
  final ref=FirebaseDatabase.instance.ref("posts");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:Text("Admin screen"),
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value) {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            }).onError((error, stackTrace) {
              Utils().toastMessage(error.toString());
            });

          }, icon: Icon(Icons.logout_outlined)),
          SizedBox(width: 20,),
        ],
      ),
    );
  }
}
