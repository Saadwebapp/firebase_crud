import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/utils/utils.dart';
import 'package:login_signup/widgets/round_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric( horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          TextFormField(
            controller: _emailController  ,
            decoration: InputDecoration(
              hintText: "Email"
            ),
          ),
            SizedBox(height: 20,),
            RoundButton(title: "Forgot", onTap: (){
              auth.sendPasswordResetEmail(email: _emailController.text.toString()).then((value) {
                Utils().toastMessage("We have sent you an email to recover password, please check the email.");
              }).onError((error, stackTrace) {
                debugPrint(error.toString());
                Utils().toastMessage(error.toString());
              });
            }),
          ],
        ),
      ),
    );
  }
}
