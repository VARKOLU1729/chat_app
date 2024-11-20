import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/Widgets/login_widgets.dart' as LoginWidgets;


class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {

  final _firebase = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance.collection('ChatUsers');
  String? email;
  String? password;
  String? userName;
  bool showPassword = false;
  final authKey = GlobalKey<FormState>();

  void save() async
  {
    if(authKey.currentState!.validate())
    {
      try {
        print("object1");
        await _firebase.createUserWithEmailAndPassword(email: email!, password: password!);
        print("object1.1");
        var userData = _firestore.doc(_firebase.currentUser!.uid);
        userData.set({"userName" : userName});
        // print("object2");
        // //set all the remaining users in the ChatUsers Collection as the current users contacts
        // final curUserChatContacts  = userData.collection("userChatContacts");
        // var snapShot = await _firestore.get();
        // print(snapShot.docs.length);
        // for(var doc in snapShot.docs)
        //   {
        //     if(doc.id != _firebase.currentUser!.uid)
        //     curUserChatContacts.doc(doc.id).set({"userName":doc.data()["userName"]});
        //   }

        Navigator.pop(context);
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
      appBar: AppBar(),
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
            LoginWidgets.Header("UserName"),
            LoginWidgets.buildUserNameField(onChanged: (val){setState(() {
              userName=val!;
            });}),
            SizedBox(height: 10,),
            LoginWidgets.Header("Email"),
            LoginWidgets.buildEmailField(onChanged: (val)=> {email = val!}),
            SizedBox(height: 10,),
            LoginWidgets.Header("Password"),
            LoginWidgets.buildPasswordField(onChanged:(val)=> {password = val!}, showPassword: showPassword),
            LoginWidgets.showPassword(showPassword: showPassword, onChanged: (val){setState(() {
              showPassword=val!;
            });}),
            SizedBox(height: 20,),
            LoginWidgets.buildActionButton(context: context, text: "Create Account", save: save),
            SizedBox(height: 40,),

          ],
        ),
      ),
    );
  }

}
