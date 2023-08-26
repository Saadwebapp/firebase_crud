import 'package:flutter/material.dart';
import 'package:login_signup/firebase_services/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService splashScreen = SplashService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        Text(
          "Welcome to our app",
          style: TextStyle(
            fontSize: 30,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}
