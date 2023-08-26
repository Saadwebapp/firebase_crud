import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/screens/auth/LoginScreen.dart';
import 'package:login_signup/utils/utils.dart';

class HomeScreen extends StatefulWidget {
   String email;
  HomeScreen({Key? key,  this.email= ""}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Home"),
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
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome: "),
            Text(widget.email),
          ],
        ),
      ),
    );
  }
}
