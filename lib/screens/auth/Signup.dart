import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/screens/auth/LoginScreen.dart';
import 'package:login_signup/screens/auth/Signup.dart';
import 'package:login_signup/utils/utils.dart';
import 'package:login_signup/widgets/round_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController =TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  void Login(){
    if(_formKey.currentState!.validate()){
      setState(() {
        loading=true;
      });
      _auth.createUserWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString()).then((value){
        setState(() {
          loading=false;
        });
      }).onError((error, stackTrace) {
        Utils().toastMessage(error.toString());
        setState(() {
          loading=false;
        });
      });

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Signup Screen"),

      ),
      body:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formKey,

                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter Email";
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: InputDecoration(

                        hintText: "Email",
                        prefixIcon: Icon(Icons.email),


                      ),
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      obscureText: true,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter Password";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(

                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock)

                      ),
                    ),
                  ],
                )),
            const SizedBox(height: 50,),

            RoundButton(
              title: "Signup",
              loading: loading,
              onTap: () {
                Login();
              },),
            const SizedBox(height: 30,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text ("Already have an Account?"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                }, child:const  Text("Login"))
              ],
            ),

          ],
        ),
      ),
    );
  }
}
