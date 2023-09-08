import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_signup/screens/auth/Signup.dart';
import 'package:login_signup/screens/forgot_password.dart';
import 'package:login_signup/screens/main_screens/admin_screen.dart';
import 'package:login_signup/screens/main_screens/home.dart';
import 'package:login_signup/utils/utils.dart';
import 'package:login_signup/widgets/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController =TextEditingController();

  final _auth = FirebaseAuth.instance;
  void Login(){
    setState(() {
      loading =true;
    });
    _auth.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value) {
        Utils().toastMessage(value.user!.email.toString());
//        auth.currentUser!.email.toString();
if(_auth.currentUser!.email.toString()== "saad@gbm.com"){
  debugPrint("error");
  Navigator.push(context,
      MaterialPageRoute(builder: (context)=>HomeScreen(email: _auth.currentUser!.email.toString(),)));

}else {
  Navigator.push(context,
      MaterialPageRoute(builder: (context)=>Admin_screen()));

}
          setState(() {
          loading =false;
        });
    }).onError((error, stackTrace)  {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading =false;
      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Login Screen"),

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
                      SizedBox(height: 20,),
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

              RoundButton(title: "Login",
                  loading: loading,
                onTap: () {

                if(_formKey.currentState!.validate()){
                Login();
                };
              },),
              const SizedBox(height: 10,),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPasswordScreen()));
                }, child:const  Text ("Forgot Password?"),),
              ),
              const SizedBox(height: 30,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text ("Don't have an Account?"),
                  TextButton(onPressed: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupScreen()));
                  }, child:const  Text("Signup"))
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
