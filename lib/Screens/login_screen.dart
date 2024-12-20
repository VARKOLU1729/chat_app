import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/Widgets/login_widgets.dart' as LoginWidgets;

import 'create_account_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _firebase = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance.collection('ChatUsers');
  String? email;
  String? password;
  bool showPassword = false;
  final authKey = GlobalKey<FormState>();

  void save() async
  {
    if(authKey.currentState!.validate())
      {
        try {
          await _firebase.signInWithEmailAndPassword(email: email!, password: password!);
        }
        on FirebaseAuthException catch (error)
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message!)));
        }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildLoginForm()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm()
  {
    return Container(
      width: 400,
      child: Form(
        key: authKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoginWidgets.Header("Email"),
            LoginWidgets.buildEmailField(onChanged: (val)=> {email = val!}),
            SizedBox(height: 10,),
            LoginWidgets.Header("Password"),
            LoginWidgets.buildPasswordField(onChanged:(val)=> {password = val!}, showPassword: showPassword),
            LoginWidgets.showPassword(showPassword: showPassword, onChanged: (val){setState(() {
              showPassword=val!;
            });}),
            SizedBox(height: 20,),
            LoginWidgets.buildActionButton(context: context, text: "Login", save: save),
            SizedBox(height: 40,),
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Dont have an account ? ",
                  children: [
                    TextSpan(
                      mouseCursor: MouseCursor.defer,
                      text: "Create account",
                      style: TextStyle(color: Colors.orange),
                      recognizer: TapGestureRecognizer()..onTap=(){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreateAccountScreen()));}
                    )
                  ]
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
