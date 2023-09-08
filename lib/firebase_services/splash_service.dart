import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/screens/auth/LoginScreen.dart';
import 'package:login_signup/screens/main_screens/admin_screen.dart';
import 'package:login_signup/screens/main_screens/home.dart';

class SplashService{
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      final userEmail = user.email;

      if (userEmail == "saad@gbm.com") {
        Timer(
          Duration(seconds: 3),
              () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen(email: userEmail.toString())),
          ),
        );
      } else if (userEmail == "saba@gbm.admin.com") {
        Timer(
          Duration(seconds: 3),
              () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Admin_screen()),
          ),
        );
      } else {
        Timer(
          Duration(seconds: 3),
              () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()),
          ),
        );
      }
    } else {
      Timer(
        Duration(seconds: 3),
            () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()),
        ),
      );
    }
  }

}